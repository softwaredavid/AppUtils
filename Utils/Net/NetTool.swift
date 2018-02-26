//
//  NetTool.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/12.
//  Copyright © 2018年 田守彬. All rights reserved.
//

struct ResultModel<T: Codable>: Codable {
    var code: String?
    var msg: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case msg = "Msg"
        case data = "Data"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy:CodingKeys.self)
        code = try? container.decode(String.self, forKey: .code)
        msg = try? container.decode(String.self, forKey: .msg)
        data = try? container.decode(T.self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(code, forKey: .code)
        try? container.encode(msg, forKey: .msg)
        try? container.encode(data, forKey: .data)
    }
}

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
    func get<T>(url:String,para: [String: String],modelType: T.Type,response: @escaping (Bool, T?) -> Void) -> DataRequest where T : Codable {
        return request(url: url, method: .get
            , parameters: para, modelType: modelType, response: response)
    }
    
    @discardableResult
    func post<T>(url:String,para: [String: String],modelType: T.Type,response: @escaping (Bool, T?) -> Void) -> DataRequest where T : Codable {
        return request(url: url, method: .post
            , parameters: para, modelType: modelType, response: response)
    }
    
    @discardableResult
    func request<T>(url: String, method: HTTPMethod, parameters: [String: Any],modelType: T.Type,response: @escaping (Bool, T?) -> Void) -> DataRequest where T : Codable {
        let str = Parater.covertDicToJson(dic: parameters)
        let data = AES.aesEncryptText(str)
        let dic:[String: String] = ["jsonData":data!]
        let request =  Alamofire.request(url,method: .post,parameters: dic).responseString {
            if $0.result.isSuccess {
                if $0.result.value != nil {
                    let json = self.handleParaToData(data: $0.result.value!)
                    print(self.handleParaToJSON(data: $0.result.value!))
                    if json == nil {
                        response(false,nil)
                    } else {
                        let data = self.parsePara(para: modelType, data: json!)
                        if !data.0 {
                            response(false,nil)
                        } else {
                            response(true,data.1)
                        }
                    }
                } else {
                    response(true,nil)
                }
            } else {
                Alert.showText(text: "网络出错,请检查您的网络连接")
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
                upload.responseString(completionHandler: {
                    if $0.result.value != nil {
                        let json = self.handleParaToData(data: $0.result.value!)
                        response(true,json)
                    } else {
                        response(true,nil)
                    }
                })
            case .failure(_):
                Alert.showText(text: "网络出错,请检查您的网络连接")
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
        req.responseString { (down) in
            if down.result.isSuccess {
                if down.result.value != nil {
                    let json = self.handleParaToData(data: down.result.value!)
                    response(true,json)
                } else {
                    response(true,nil)
                }
            } else {
                Alert.showText(text: "网络出错,请检查您的网络连接")
                response(false,nil)
            }
        }
        req.suspend()
        req.resume()
    }
}
// 参数处理
extension NetToos {
    // 转换为Data
    private func handleParaToData(data: String) -> Data? {
        let data = AES.aesDencryptText(data)
        return data
    }
    // 转换为json
    private func handleParaToJSON(data: String) -> [String : Any]? {
        let responseStr = AES.aesDencryptText(data)
        let json = Parater.covertDataJson(data: responseStr)
        return json
    }
    
    // 解密后的参数处理
    private func parsePara<T>(para: T.Type,data: Data) -> (Bool,T?) where T : Codable {
        let result = JSON.parseJSON(type: ResultModel<T>.self, data: data)
        guard let code = result?.code else {
            Alert.showText(text: "数据解析失败")
            return (false,nil)
        }
        if code == "1" {
            if result?.data != nil {
                return (true,result!.data)
            } else {
                Alert.showText(text: "参数解析错误")
                return (false,nil)
            }
        } else {
            Alert.showText(text: result?.msg ?? "服务器出错了,请联系客服")
            return (false,nil)
        }
    }
}
