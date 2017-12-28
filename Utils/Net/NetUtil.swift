//
//  NetUtil.swift
//  AppUtils
//
//  Created by 优路教育  on 2017/12/16.
//  Copyright © 2017年 田守彬. All rights reserved.

// 网络请求单例类 此类 提供 get post post上传图片等方法

import UIKit
import Alamofire

class NetUtil: NSObject {
    
    public static let staredInstance = NetUtil()
    
    // 请求baseURL
    public var baseUrl: String?
    
    private override init() {}
    
    private func url(urlString: String) -> String {
        guard let _ = baseUrl else { return urlString }
        return baseUrl! + urlString
    }
    
    // get 请求
    public func getJSON() {}
    // post 请求
    public func postJSON() {}
    // post 请求
    public func postImage() {}
}
