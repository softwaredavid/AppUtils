//
//  User.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/14.
//  Copyright © 2018年 田守彬. All rights reserved.
//

import Foundation

typealias user_func_void = (User) -> ()

enum LogType {
    case normal
    case weixin
    case qq
}
struct ResultModel<T: Codable>: Codable {
    var code: String?
    var msg: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case msg = "Msg"
        case data = "Data"
    }
}

struct UserInfo: Codable {
    var userName: String?
    var password: String?
    var userId: String?
    
    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case password = "Password"
        case userId = "UserId"
    }
}
struct User {
    
    var account: String?
    var passWord: String?
    var userId: String?
    var msgCode: String?
    var newPassWord: String?
    
    
    func saveUser(user: UserInfo) {
        let userDefault = UserDefaults.standard
        if user.userName != nil {
            userDefault.set(user.userName, forKey: UserDefaults.UserInfo.userName)
        }
    }
    func clearUser() {}
    
    func login(user: User?,type: LogType = .normal,complete:((UserInfo)->())?) {
        switch type {
        case .normal:
            loginNormal(user: user, complete: complete)
        case .weixin:
            break
        case .qq:
            break
        }
        
    }
    private func loginNormal(user: User?,complete: ((UserInfo)->())?) {
        guard let _ = user else { return }
        guard let _ = user?.account else { return }
        guard let _ = user?.passWord else { return }
        let dic:[String : String] = ["UserName":user!.account!,"Password":user!.passWord!]
        NetToos.shared.post(url: Address.Login.login(), para: dic) { (result, resoponse) in
            if !result {
                Alert.showText(text: "网络出错,请检查您的网络连接")
            } else {
                let result = JSON.parseJSON(type: ResultModel<UserInfo>.self, data: resoponse)
                guard let code = result?.code else {
                    return
                }
                if code == "1" {
                    if result?.data != nil {
                        let u = result!.data!
                        user?.saveUser(user: u)
                        complete?(u)
                    } else {
                        Alert.showText(text: "参数解析错误")
                    }
                } else {
                    Alert.showText(text: result?.msg ?? "服务器出错了,请联系客服")
                }
            }
        }
    }
    private func loginWeixin() {}
    private func loginQQ() {}
    
    static func logout(user: User,complete: void_func_void?) {
        user.clearUser()
        complete?()
    }
}
struct Register {
    static func register(user: User,complete:void_func_void?) {
        
    }
}
struct ForgetPass {
    static func forgetPass(user: User,complete:void_func_void?) {
        
    }
}
