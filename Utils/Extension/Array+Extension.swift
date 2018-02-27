

//
//  Array+Extension.swift
//  AppUtils
//
//  Created by 优路教育  on 2018/1/5.
//  Copyright © 2018年 田守彬. All rights reserved.
//

import Foundation

public extension Array {
    // 查找某个元素在数组中的索引
    func find(_ f: (Iterator.Element) -> Bool) -> (Int?,Iterator.Element?)? {
        for (index,element) in self.enumerated() {
            if f(element) {
                return (index, element)
            }
        }
        return nil
    }
}
