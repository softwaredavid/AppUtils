//
//  Address.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/14.
//  Copyright © 2018年 田守彬. All rights reserved.

struct Address {
    static let httpHeader: String = "https://appjk.niceloo.com/App/PortalServiceIOS.asmx/"
    struct User {
        // MARK: == 登录
        static func login() -> String {
            return Address.httpHeader + "Login"
        }
        // MARK: == 注册获取验证码
        static func regMsgCode() -> String {
            return Address.httpHeader + "RegSMSCode"
        }
        // MARK: == 注册
        static func register() -> String {
            return Address.httpHeader + "Region"
        }
        // MARK: == 获取忘记密码验证码
        static func forgetPassMsgCode() -> String {
            return Address.httpHeader + "ModifySMSCode"
        }
        // MARK: == 忘记密码
        static func forgetPass() -> String {
            return Address.httpHeader + "ModifyPassword"
        }
        // MARK: == 获取用户信息
        static func userInfo() -> String {
            return Address.httpHeader + "GetUserInformation"
        }
    }
}
