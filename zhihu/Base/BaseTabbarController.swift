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
        addChildVC(vc: HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildVC(vc: HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildVC(vc: HomeViewController(), title: "首页", imageName: "tabbar_home")
        tabBar.barTintColor = .white
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
