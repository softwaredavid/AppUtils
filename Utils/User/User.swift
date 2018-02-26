//
//  User.swift
//  AppUtils
//
//  Created by shuaitong du on 2018/2/14.
//  Copyright © 2018年 田守彬. All rights reserved.
//

import Foundation

enum LogType {
    case normal
    case weixin
    case qq
}

struct UserInfo: Codable {
    var userName: String?
    var password: String?
    var userId: String?
    var phone: String?
    var userIcon: String?
    private var sexCode: String?
    
    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case password = "Password"
        case userId = "UserId"
        case phone = "Mobile"
        case userIcon = "UserIcon"
        case sexCode = "Sex"
    }
    
    // 获取性别
    func getSex() -> Sex {
        if sexCode == "0" {
            return .man
        } else {
            return .woman
        }
    }
}

enum Sex: String {
    case man = "男"
    case woman = "女"
}

struct User {
    
    var account: String?
    var password: String?
    var userId: String?
    var msgCode: String?
    var rePassword: String?
    
    static func userIsLogin() -> Bool {
        let userName = User.getUserName()
        let password = User.getPassword()
        return userName != nil && password != nil
    }
    
    static func getUserName() -> String? {
        let userDefault = UserDefaults.standard
        let userName = userDefault.object(forKey: UserDefaults.UserInfo.userName) as? String
        return userName
    }
    
    static func getPassword() -> String? {
        let userDefault = UserDefaults.standard
        let password = userDefault.object(forKey: UserDefaults.UserInfo.password) as? String
        return password
    }
    
    static func getUserDic() -> [String : String]? {
        var dic = [String : String]()
        guard let userName = User.getUserName() else {
            return nil
        }
        guard let password = User.getPassword() else {
            return nil
        }
        dic["UserName"] = userName
        dic["Password"] = password
        return dic
    }
    
    func saveUser(user: UserInfo) {
        let userDefault = UserDefaults.standard
        if user.userName != nil {
            userDefault.set(user.userName, forKey: UserDefaults.UserInfo.userName)
        }
        if user.password != nil {
            userDefault.set(user.password, forKey: UserDefaults.UserInfo.password)
        }
        if user.userId != nil {
            userDefault.set(user.userId, forKey: UserDefaults.UserInfo.userId)
        }
    }
    
    static func clearUser() {
        let userdefault = UserDefaults.standard
        userdefault.set(nil, forKey: UserDefaults.UserInfo.userName)
        userdefault.set(nil, forKey: UserDefaults.UserInfo.password)
        userdefault.set(nil, forKey: UserDefaults.UserInfo.userId)
    }
    
    func login(type: LogType = .normal,complete:((UserInfo)->())?) {
        switch type {
        case .normal:
            loginNormal(complete: complete)
        case .weixin:
            break
        case .qq:
            break
        }
    }
    
    private func loginNormal(complete: ((UserInfo)->())?) {
        guard let _ = account else {
            Alert.showText(text: "用户名不能为空")
            return
        }
        guard let _ = password else {
            Alert.showText(text: "密码不能为空")
            return
        }
        let dic:[String : String] = ["UserName":account!,"Password":password!]
        let hud = Alert.showProgressView()
        NetToos.shared.post(url: Address.User.login(), para: dic, modelType: UserInfo.self) { (result, model) in
            hud?.hide(animated: true)
            if result {
                self.saveUser(user: model!)
                complete?(model!)
            }
        }
    }
    private func loginWeixin() {}
    private func loginQQ() {}
    
    static func logout(complete: void_func_void?) {
        User.clearUser()
        complete?()
    }
}

// 用户信息相关
extension User {
    // 获取用户信息
    static func getUserInfo(complete: ((UserInfo)->())?) {
        guard let dic = User.getUserDic() else {
            Alert.showText(text: "未登录，请登录")
            return
        }
        let hud = Alert.showProgressView()
        NetToos.shared.post(url: Address.User.userInfo(), para: dic, modelType: UserInfo.self) { (result, model) in
            hud?.hide(animated: true)
            if result {
                complete?(model!)
            }
        }
    }
}

// 注册
extension User {
    // 注册验证码
    func getRegMsgCode(complete: void_func_void?) {
        var dic = [String : String]()
        if account != nil {
            if !(account!.isPhone()) {
                Alert.showText(text: "手机号码不正确")
                return
            }
            dic["Phone"] = account!
        } else {
            Alert.showText(text: "手机号码不能为空")
            return 
        }
        let hud = Alert.showProgressView()
        NetToos.shared.post(url: Address.User.regMsgCode(), para: dic, modelType: UserInfo.self) { (result, model) in
            hud?.hide(animated: true)
            if result {
                Alert.showText(text: "验证码获取成功")
                complete?()
            }
        }
    }
    // 注册
    func register(complete:void_func_void?) {
        if account == nil { Alert.showText(text: "用户名不能为空"); return }
        if msgCode == nil { Alert.showText(text: "验证码不能为空"); return }
        if !account!.isPhone() { Alert.showText(text: "用户名不是手机号"); return }
        if password == nil { Alert.showText(text: "密码不能为空"); return }
        if rePassword == nil { Alert.showText(text: "确认密码不能为空"); return }
        if password != rePassword { Alert.showText(text: "密码和确认密码不一致"); return }
        let dic = ["Phone":account!,"Password":password!,"RePassword":rePassword!,"SMSCode":msgCode!]
        let hud = Alert.showProgressView()
        NetToos.shared.post(url: Address.User.register(), para: dic, modelType: UserInfo.self) { (result, model) in
            hud?.hide(animated: true)
            if result {
                Alert.showText(text: "验证码获取成功")
                complete?()
            }
        }
    }
}

// 忘记密码
extension User {
    // 忘记密码获取验证码
    func getForgetMsgCode(complete: void_func_void?) {
        var dic = [String : String]()
        if account != nil {
            if !(account!.isPhone()) {
                Alert.showText(text: "手机号码不正确")
                return
            }
            dic["Phone"] = account!
        } else {
            Alert.showText(text: "手机号码不能为空")
            return
        }
        let hud = Alert.showProgressView()
        NetToos.shared.post(url: Address.User.forgetPassMsgCode(), para: dic, modelType: UserInfo.self) { (result, model) in
            hud?.hide(animated: true)
            if result {
                Alert.showText(text: "验证码获取成功")
                complete?()
            }
        }
    }
    // 忘记密码
    func findPassword(complete:void_func_void?) {
        if account == nil { Alert.showText(text: "手机号不能为空"); return }
        if msgCode == nil { Alert.showText(text: "验证码不能为空"); return }
        if password == nil { Alert.showText(text: "新密码不能为空"); return }
        if rePassword == nil { Alert.showText(text: "确认密码不能为空"); return }
        if password != rePassword { Alert.showText(text: "新密码和确认密码不一致"); return }
        let dic = ["Phone":account!,"Password":password!,"RePassword":rePassword!,"SMSCode":msgCode!]
        let hud = Alert.showProgressView()
        NetToos.shared.post(url: Address.User.forgetPass(), para: dic, modelType: UserInfo.self) { (result, model) in
            hud?.hide(animated: true)
            if result {
                Alert.showText(text: "密码修改成功")
                let userDefault = UserDefaults.standard
                userDefault.set(self.password, forKey: UserDefaults.UserInfo.password)
                complete?()
            }
        }
    }
}
