//
//  UIFactory.swift
//  AppUtils
//
//  Created by 优路教育  on 2017/12/12.
//  Copyright © 2017年 田守彬. All rights reserved.
// 创建各种UI控件
  // UILabel, UIButton, UITextField, 一像素宽的UIView,一像素高的UIView, UIImageView 等

import UIKit

class UIFactory {
    /// 创建 label
    func createLabel(frame: CGRect,text:String) -> UILabel? {
        
        let lablel = UILabel(frame:frame)
        lablel.text = text
        
        return lablel
    }
    /// 创建 button
    func createButton(frame:CGRect,text:String?=nil,image:String?=nil) -> UIButton? {
        
        let button = UIButton(type: .system)
        button.frame = frame
        if text != nil {
            button.setTitle(text, for: .normal)
        }
        if image != nil {
            let img = UIImage(named: image!)
            button.setImage(img, for: .normal)
        }
        
        return button
    }
    /// 创建 textField
    func createTextField(frame:CGRect, placeholder: String) -> UITextField? {
       
        let textField = UITextField(frame: frame)
        textField.placeholder = placeholder
        
        return textField
    }
    /// 创建 textView
    func createTextView(frame:CGRect, placeholder: String) -> UITextView? {
        
       
        return nil
    }
    /// 创建 一像素宽的view
    func createSingWidthView(frame:CGRect,bgColor:UIColor?) -> UIView? {
        
        let view = UIView(frame:frame)
        view.height = 1
        view.backgroundColor = bgColor
        
        return view
    }
    /// 创建 一像素高的view
    func createSingHeightView(frame:CGRect,bgColor:UIColor?) -> UIView? {
        
        let view = UIView(frame:frame)
        view.width = 1
        view.backgroundColor = bgColor
        
        return view
    }
    /// 创建 imageView
    func createImageView(frame:CGRect,image:String) -> UIImageView? {
        
        let imageView = UIImageView(frame: frame)
        imageView.image = UIImage(named: image)
        
        return imageView
    }
}