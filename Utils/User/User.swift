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
    var Code: String?
    var Msg: String?
    var Data: T?
}
struct UserInfo: Codable {
    var UserName: String?
    var Password: String?
    var UserId: String?
}
struct User {
    
    var account: String?
    var passWord: String?
    var userId: String?
    var msgCode: String?
    var newPassWord: String?
    
    
    func saveUser(user: UserInfo) {}
    func clearUser() {}
    
    func login(user: User?,type: LogType = .normal,complete:void_func_void?) {
        switch type {
        case .normal:
            loginNormal(user: user, complete: complete)
        case .weixin:
            break
        case .qq:
            break
        }
        
    }
    
    private func loginNormal(user: User?,complete: void_func_void?) {
        guard let _ = user else { return }
        guard let _ = user?.account else { return }
        guard let _ = user?.passWord else { return }
        let dic:[String : String] = ["UserName":user!.account!,"Password":user!.passWord!]
        NetToos.shared.post(url: Address.Login.login(), para: dic) { (result, resoponse) in
            if !result {
                Alert.showText(text: "网络出错,请检查您的网络连接")
            } else {
                let result = JSON.parseJSON(type: ResultModel<UserInfo>.self, data: resoponse)
//                guard let code = resoponse?["Code"] as? String else {
//                    return
//                }
//                if code == "1" {
//                    //let user = JSON.parseJSON(data: <#T##Data?#>)
//                    complete?()
//                } else {
//                    //let msg = resoponse?["Msg"] as? String
//                    Alert.showText(text: msg ?? "服务器出错了,请联系客服")
//                }
            }
        }
    }
    private func loginWeixin() {}
    private func longinQQ() {}
    
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
