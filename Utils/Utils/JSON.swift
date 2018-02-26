//
//  JSON.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/15.
//  Copyright © 2018年 田守彬. All rights reserved.
struct JSON {
    static func parseJSON<T>(type: T.Type,data: Data?) ->T? where T : Decodable {
        var obj: T?
        do {
           obj = try JSONDecoder().decode(type, from: data!)
        } catch {
            print("parse json fail")
        }
        return obj
    }
}
