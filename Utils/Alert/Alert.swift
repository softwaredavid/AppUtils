//
//  Alert.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/15.
//  Copyright © 2018年 田守彬. All rights reserved.
//

import MBProgressHUD

struct Alert {
    @discardableResult
    static func showText(text: String) -> MBProgressHUD? {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        guard let window = appDelegate.window else {
            return nil
        }
        var hud: MBProgressHUD!
        Thread.ensureMainThread {
            hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.mode = .text
            hud.detailsLabel.text = text
            hud.detailsLabel.font = UIFont.systemFont(ofSize: 13)
            hud.bezelView.color = UIColor.black.withAlphaComponent(0.8)
            hud.detailsLabel.textColor = UIColor.white
            hud.offset.y = (screen_height - 64) / 2 - 100
            hud.margin = 10
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 2)
        }
        return hud
    }
    @discardableResult
    static func showProgressView(text: String?="请稍候") -> MBProgressHUD? {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        guard let window = appDelegate.window else {
            return nil
        }
        var hud: MBProgressHUD!
        Thread.ensureMainThread {
            hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.label.text = text
            hud.minSize = CGSize(width: 100, height: 50)
            hud.removeFromSuperViewOnHide = true
        }
        return hud
    }
}
