//
//  BaseTabbarController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/1.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class BaseTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(vc: HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildVC(vc: MemberViewController(), title: "会员", imageName: "tabbar_vip")
        addChildVC(vc: HomeViewController(), title: "发现", imageName: "tabbar_find")
        addChildVC(vc: HomeViewController(), title: "消息", imageName: "tabbar_message")
        addChildVC(vc: HomeViewController(), title: "我的", imageName: "tabbar_me")
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
    }
    func addChildVC(vc:UIViewController,title:String,imageName:String){
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
//        let selectImage = UIImage(named: imageName + "_selected")
//        vc.tabBarItem.selectedImage = selectImage?.withRenderingMode(.alwaysOriginal)
        let navi = BaseNavigationViewController(rootViewController: vc)
        addChild(navi)
    }
}
