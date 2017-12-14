//
//  UIImageView+Extension.swift
//  AppUtils
//
//  Created by 优路教育  on 2017/12/14.
//  Copyright © 2017年 田守彬. All rights reserved.
//

import UIKit

extension UIImageView {
    // 圆角
    func imageRounderRectRadius(cornerRadius: CGFloat) {
        let bzPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        let layer = CAShapeLayer()
        layer.path = bzPath.cgPath
        layer.fillColor = self.layer.borderColor
        layer.strokeColor = self.layer.borderColor
        self.layer.mask = layer
    }
}
