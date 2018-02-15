//
//  Address.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/14.
//  Copyright © 2018年 田守彬. All rights reserved.

struct Address {
    static let httpHeader: String = "https://appjk.niceloo.com/App/PortalServiceIOS.asmx/"
    struct Login {
        // MARK: == 登录
        static func login() -> String {
            return Address.httpHeader + "Login"
        }
        // MARK: == 忘记密码
        static func forgetPass() {}
        // MARK: == 注册
        static func register() {}
    }
}
