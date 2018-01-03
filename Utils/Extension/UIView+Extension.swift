//
//  UIView+Extension.swift
//  AppUtils
//
//  Created by 优路教育  on 2017/12/7.
//  Copyright © 2017年 田守彬. All rights reserved.
//

import UIKit

extension UIView {
    // x
   public var x: CGFloat {
        set {
            frame.origin.x = newValue
        }
        get {
            return frame.origin.x
        }
    }
    // y
    public var y: CGFloat {
        set {
            frame.origin.y = newValue
        }
        get {
            return frame.origin.y
        }
    }
    // width
    public var width: CGFloat {
        set {
            frame.size.width = newValue
        }
        get {
            return frame.size.width
        }
    }
    // height
    public var height: CGFloat {
        set {
            frame.size.height = newValue
        }
        get {
            return frame.size.height
        }
    }
    // border
    public func border(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    // 圆角
    public func rounderRectRadius(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    // 阴影
    public func shadow(color:UIColor,opacity:CGFloat,radius:CGFloat,offset:CGSize) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
}
