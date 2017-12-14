//
//  URL+Extension.swift
//  AppUtils
//
//  Created by 优路教育  on 2017/12/11.
//  Copyright © 2017年 田守彬. All rights reserved.

// 字符串的相关扩展:
//              字符串创建URL 字符串编码 字符串截取

import Foundation

extension String {
    // 字符串编码
    func encodeString() -> String? {
        if count == 0 {
            return nil
        }
        let str = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return str
    }
    // 创建url 并对 字符串进行编码
    func getUrl() -> URL? {
        let encodeStr = encodeString()
        return URL(string: encodeStr ?? "")
    }
    // 根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = count - start
        }
        if start > count { return self }
        /// 开始位置
        let startPosition = index(startIndex, offsetBy:start < 0 ? 0 : start)
        var endPosition: Index!
        if start + length > count {
            /// 结束位置
            endPosition = index(startPosition, offsetBy:start < 0 ? count : (count - start))
        } else {
            /// 结束位置
            endPosition = index(startPosition, offsetBy:len)
        }
        return String(self[startPosition ..< endPosition])
    }
}