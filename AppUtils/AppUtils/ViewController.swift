//
//  ViewController.swift
//  AppUtils
//
//  Created by 优路教育  on 2017/12/7.
//  Copyright © 2017年 田守彬. All rights reserved.

//public static func color<T: FloatingPoint>(r: T,g: T,b: T) -> T {

    //return r + b + g
//}

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.createColor(colorStr: "FFFFFF")
        let vi = UIView.init(frame: CGRect.init(x: 20, y: 200, width: 200, height: 200))
//        vi.border(width: 1, color: UIColor.red)
//        vi.rounderRectRadius(cornerRadius: 5)
        vi.addRoundedCorners(.topLeft, cornerRadius: CGSize(width: 10, height: 15), color: UIColor.green)
        
        let y = UIButton.init(type: .system)
        y.frame = CGRect.init(x: 10, y: 10, width: 30, height: 30)
        y.addTarget(self, action: #selector(click), for: .touchUpInside)
        y.backgroundColor = UIColor.yellow
        vi.addSubview(y)
        view.addSubview(vi)
        //"TrialProjectid":"6da04545-2464-468f-998f-576584c9c8e4"
        let str = "{\"TrialProjectid" + ":" + "6da04545-2464-468f-998f-576584c9c8e4\"}"
        
//        let net = NetToos.shared
//        net.post(url: "https://appjk.niceloo.com/App/PortalServiceIOS.asmx/GetOneTwoClass", para: ["TrialProjectid":"6da04545-2464-468f-998f-576584c9c8e4"]) { (success, dic) in
//
//        }
        var user = User()
        user.account = "15037153382"
        user.passWord = "123456"
        user.login(user: user) {
            
        }
        
        let v2 = vi.clone()
        v2.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        v2.backgroundColor = UIColor.red
        view.addSubview(v2);
        
       /* let s: String? = "abc"
        let v = s.flatMap { (a: String) -> Int? in
            return Int(a)
        }
       
        
        var date: NSDate? = Date() as NSDate
        var formatted = date.map(string().stringFromDate)*/
        /*stride(from: 0, to: 10, by: 1).map { (<#Int#>) -> T in
            <#code#>
        }
         ok回归正题，先说下@convention是干什么的。
         他是用来修饰闭包的。他后面需要跟一个参数：
         
         @convention(swift) : 表明这个是一个swift的闭包
         @convention(block) ：表明这个是一个兼容oc的block的闭包
         @convention(c) : 表明这个是兼容c的函数指针的闭包。
         
         作者：xingou
         链接：https://www.jianshu.com/p/f4dd6397ae86
         來源：简书
         著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
         */
        
        
        let arr = ["q","w","e"]
        let c =  arr.find {
            print($0)
            return $0 == "e"
        }
        print(c)
//        for item in arr.drop(while: { (<#String#>) -> Bool in
//            <#code#>
//        }) {
//            <#code#>
//        }
        var arr2 = ["a","b","c","f"]
        let a = arr2.drop { str -> Bool in
            print(str)// 返回true元素将会被删除 检测到条件时会提前退出 检测到fasle时会退出
            return str != "c"
        }
        let b = arr2.prefix { str -> Bool in
            return str == "c"
        }
        print(arr2)
        print(a)
         print(b)
    }
    // 汉字转拼音
    func covertToPingYin() {
        /// 汉字转拼音
        if #available(iOS 9.0, *) {
         print("问题答疑".applyingTransform(kCFStringTransformMandarinLatin as StringTransform, reverse: false))
         } else {
         // Fallback on earlier versions
         }
    }
    @objc func click() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
