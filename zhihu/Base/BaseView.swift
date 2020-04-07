//
//  BaseView.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/3.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configUI(){
        
    }
}
