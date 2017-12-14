//
//  ViewController.swift
//  AppUtils
//
//  Created by 优路教育  on 2017/12/7.
//  Copyright © 2017年 田守彬. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vi = UIView.init(frame: CGRect.init(x: 20, y: 200, width: 200, height: 200))
        vi.border(width: 1, color: UIColor.red)
        vi.rounderRectRadius(cornerRadius: 5)
        view.addSubview(vi)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
