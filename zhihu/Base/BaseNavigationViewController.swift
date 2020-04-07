//
//  BaseNavigationViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/2.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class BaseNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .black
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage.init()
    }
}
