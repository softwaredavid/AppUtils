
//
//  Navigation+Extension.swift
//  AppUtils
//
//  Created by 优路教育  on 2018/2/26.
//  Copyright © 2018年 田守彬. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func push(vc viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }
    
    func pop(vc viewController: UIViewController?) {
        if viewController != nil {
            popToViewController(viewController!, animated: true)
        } else {
            popViewController(animated: true)
        }
    }
}
