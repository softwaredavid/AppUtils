//
//  Parametet.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/12.
//  Copyright © 2018年 田守彬. All rights reserved.
//
import Foundation

struct Parater {
    // 字典转换为json
    static func covertDicToJson(dic: [String: Any]?) -> String? {
        guard let covertDic = dic else { return nil }
        if (!JSONSerialization.isValidJSONObject(covertDic)) {
            return nil
        }
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: covertDic, options: .prettyPrinted)
        } catch  {
            print("dic covert to json fail")
            jsonData = nil
        }
        if jsonData == nil {
            return nil
        }
        return String(data: jsonData!, encoding: .utf8)
    }
    // data转换为json
    static func covertDataJson(data: Data?) -> [String: Any]? {
        guard let jsonData = data else {
            return nil
        }
        var jsonObj: [String: Any]?
        do {
            jsonObj =  try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String : Any]
        } catch  {
            print("json covert obj fail")
            return nil
        }
        return jsonObj
    }
}
