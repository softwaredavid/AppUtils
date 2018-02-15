//
//  NetTool.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/12.
//  Copyright © 2018年 田守彬. All rights reserved.
//
struct FileData {
    var fileData: Data! // 文件数据
    var fileName: String! // 文件名字
    var mimeType: String! // 文件类型
    var serviceName: String! // 文件服务器名字
}

import Alamofire

class NetToos {
    static let shared = NetToos()
    private init() {}
    
    @discardableResult
    func get(url:String,para: [String: String],response: @escaping (Bool, Data?) -> Void) -> DataRequest {
        return request(url: url, method: .get
            , parameters: para, response: response)
    }
    
    @discardableResult
    func post(url:String,para: [String: String],response: @escaping (Bool, Data?) -> Void) -> DataRequest {
        return request(url: url, method: .post
            , parameters: para, response: response)
    }
    
    @discardableResult
    func request(url: String, method: HTTPMethod, parameters: [String: Any],response: @escaping (Bool, Data?) -> Void) -> DataRequest {
        let str = Parater.covertDicToJson(dic: parameters)
        let data = AES.aesEncryptText(str)
        let dic:[String: Any] = ["jsonData":data as Any]
        
        let request =  Alamofire.request(url,method: .post,parameters: dic).responseData {
            if $0.result.isSuccess {
                if $0.result.value != nil {
                    let json = self.handleParaToData(data: $0.result.value!)
                    response(true,json)
                } else {
                    response(true,nil)
                }
            } else {
                response(false,nil)
            }
        }
        return request
    }
    
    func upload(url: String,fileArray:[FileData],para: [String: String],response: @escaping (Bool, Data?) -> Void) {
        Alamofire.upload(multipartFormData: { formData in
            fileArray.forEach({
                formData.append($0.fileData, withName: $0.serviceName, fileName: $0.fileName, mimeType: $0.mimeType)
            })
            para.forEach({ (key,value) in
                if let data = value.data(using: .utf8) {
                    formData.append(data, withName: key)
                }
            })
        }, to: url) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseData(completionHandler: {
                    if $0.result.value != nil {
                        let json = self.handleParaToData(data: $0.result.value!)
                        response(true,json)
                    } else {
                        response(true,nil)
                    }
                })
            case .failure(_):
                response(false,nil)
            }
        }
    }
    // 下载
    func download(url: String,para: [String: String],response: @escaping (Bool, Data?) -> Void) {
        //指定下载路径
        let destination:DownloadRequest.DownloadFileDestination = { _, response in
            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentURL.appendingPathComponent(response.suggestedFilename!)
            return (fileURL,[.removePreviousFile,.createIntermediateDirectories])
        }
        
        let req = Alamofire.download(url, method: .post, parameters: para, encoding: URLEncoding.default, headers: nil, to: destination)
        req.downloadProgress(queue: DispatchQueue.main) { (p) in
            
        }
        req.responseData { (down) in
            if down.result.isSuccess {
                if down.result.value != nil {
                    let json = self.handleParaToData(data: down.result.value!)
                    response(true,json)
                } else {
                    response(true,nil)
                }
            } else {
                response(false,nil)
            }
        }
        req.suspend()
        req.resume()
    }
    // 转换为Data
    private func handleParaToData(data: Data) -> Data? {
        let sr = String(data: data, encoding: .utf8)
        let data = AES.aesDencryptText(sr)
        return data
    }
    // 转换为json
    private func handleParaToJSON(data: Data) -> [String : Any]? {
        let sr = String(data: data, encoding: .utf8)
        let responseStr = AES.aesDencryptText(sr)
        let json = Parater.covertDataJson(data: responseStr)
        return json
    }
}
