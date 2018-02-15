////
////  ParsePara.swift
////  NiceLoo
////
////  Created by 优路教育  on 2018/1/17.
////  Copyright © 2018年 张书鹏. All rights reserved.
////
//// 参数解析
//
//import Foundation
//
//protocol ParseParaProtocol {
//    func parse<T>(json: Any?) -> T?
//}
//extension ParseParaProtocol {
//    func parse<T>(json: Any?) -> T? {
//        return nil
//    }
//}
//
//struct ParsePara {
//    /// MARK:  解析成数组
//    static func parseToArray<T: NSObject>(jsonList: Any?) -> [T] {
//        let array: [T] = (NSArray.yy_modelArray(with: T.self, json: jsonList ?? "") as? [T]) ?? [T]()
//        return array
//    }
//    /// MARK: 解析成对象
//    static func parseToObject<T: NSObject>(json: Any?) -> T? {
//        guard let js = json as? [AnyHashable : Any] else {
//            return nil
//        }
//        let m: T? = T.yy_model(with: js)
//        return m
//    }
//}

