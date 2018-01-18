//
//  Service.swift
//  NiceLoo
//
//  Created by 优路教育  on 2018/1/17.
//  Copyright © 2018年 张书鹏. All rights reserved.
//

import Foundation
import MBProgressHUD

typealias NetProtocol =  ParseParaProtocol

// 上传文件 数据模型
struct FileData {
    var fileData: Data! // 文件数据
    var fileName: String? // 文件名字
    var mimeType: String! // 文件类型
    var serviceName: String! // 文件服务器名字
}
struct Service<A> {
    var parameters: [String: Any]  // 参数
    var path: String // 服务器路径
    var error: ((Error?) -> ())? // 错误
    var imgArray: [FileData]? // 图片数组 可选
    init(parameters: [String: Any],path: String) {
        self.parameters = parameters
        self.path = path
    }
}
extension Service {
    func get<T: ParseParaProtocol>(parse: T?,callBack: (Any?,A?) -> ()) {/*get*/}
    // post
    func post<T: ParseParaProtocol>(parse: T?,callBack: @escaping (Any?,A?) -> ()) {
        let net = NetDataEngine.sharedInstance()
        net?.post(path, parameters: parameters,
                  download: nil,
                  /*成功*/    success: { callBack($0, parse?.parse(json: $0)) })
       /*请求失败*/ { self.error?($0) }
    }
    // post file
    func postFile<T: ParseParaProtocol>(parse: T?,callBack: @escaping (Any?,A?) -> ()) {
        let net = NetDataEngine.sharedInstance()
        net?.postImage(path,
                       imagePre: "Photo",
                       parameters: parameters,
                       imageArray: imgArray as! NSMutableArray,
                       download: nil,
                       /*成功*/success: { callBack($0,parse?.parse(json: $0)) },
            /*请求失败*/failed: { self.error?($0) })
    }
}
