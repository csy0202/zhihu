//
//  cellHeaderView.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/20.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class cellHeaderView: BaseView {
    private var titleL: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        lab.font = UIFont.boldSystemFont(ofSize: 17)
        return lab
    }()
    
    private var moreBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.colorRGB(c: 153), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    
    var moduleModel : Module?{
        didSet{
            guard let moduleModel = moduleModel  else {
                return
            }
            titleL.text = moduleModel.title
            moreBtn.setTitle((moduleModel.target_title ?? "") + "▶", for: .normal)
        }
    }
    
    override func configUI() {
        titleL.frame = CGRect(x: 20, y: 25, width: 250, height: 20)
        addSubview(titleL)
        titleL.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(25)
            $0.height.equalTo(20)
        }
        moreBtn.frame = CGRect(x: screenWidth-80, y: 25, width: 60, height: 20)
        addSubview(moreBtn)
//        moreBtn.snp.makeConstraints {
//            $0.right.equalTo(-20)
//            $0.top.equalTo(25)
//            $0.height.equalTo(20)
//        }
    }
}
