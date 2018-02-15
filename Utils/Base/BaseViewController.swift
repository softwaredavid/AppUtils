//
//  BaseViewController.swift
//  PartOfXib
//
//  Created by Apple on 2017/6/26.
//  Copyright © 2017年 WangDaoLeTu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // showLeftBackBtn()
    }
   /* func showNoDataView(text:String="哦~~~,网络出错了,点击屏幕重新加载",tipAction:@escaping (()->())) {
        tapC = tipAction
        if noDataView != nil { return }
        noDataView = UIView(frame: view.bounds)
        noDataView!.backgroundColor = UIColor.white
        
        let iamgeView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        iamgeView.image = UIImage(named: "no_data")
        iamgeView.center = view.center
        
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        lab.numberOfLines = 0
        lab.center = view.center
        
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.y = view.center.y - 40
        lab.text = text
        lab.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
        noDataView?.addSubview(lab)
        noDataView?.addSubview(iamgeView)
        view.addSubview(noDataView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        noDataView!.addGestureRecognizer(tap)
    }
    func tapClick() {
        tapC?()
    }
    func hiddenNoDataView() {
        noDataView?.removeFromSuperview()
        noDataView = nil
    }
    func showLeftBackBtn(image: String = "icon_back") {
        navigationItem.hidesBackButton = true
        let view = navigationController?.navigationBar.viewWithTag(99999)
        if view != nil { view?.removeFromSuperview() }
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setImage(UIImage(named: image), for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        btn.tag = 99999
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 50)
        navigationController?.navigationBar.addSubview(btn)
    }
    func showRightBackBtn() {
        let view = navigationController?.navigationBar.viewWithTag(88888)
        if view != nil { view?.removeFromSuperview() }
        let btn = UIButton(frame: CGRect(x: screen_width - 60, y: 0, width: 60, height: 44))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("...", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        btn.titleEdgeInsets = UIEdgeInsets(top: -16, left: 0, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(rigthBtnClick), for: .touchUpInside)
        btn.tag = 88888
        btn.contentHorizontalAlignment = .center
        navigationController?.navigationBar.addSubview(btn)
    }
    func hiddenRightBtn() {
        navigationController?.navigationBar.viewWithTag(88888)?.removeFromSuperview()
    }
    func rigthBtnClick() {
        
    }
    func createSelectProjectBtn() {
        navigationItem.hidesBackButton = true
        let view = navigationController?.navigationBar.viewWithTag(99999)
        if view != nil { view?.removeFromSuperview() }
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 10)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setImage(UIImage(named: "select_pro"), for: .normal)
        btn.addTarget(self, action: #selector(selectProject), for: .touchUpInside)
        btn.tag = 99999
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -1, 0, 60)
        navigationController?.navigationBar.addSubview(btn)
    }
    func hidenBackBtn() {
        let hasSubviews = navigationController?.viewControllers.count != 0
        if !isHowLeftBack || !hasSubviews {
            navigationItem.leftBarButtonItem = nil
            navigationItem.hidesBackButton = true
        }
    }*/
}
