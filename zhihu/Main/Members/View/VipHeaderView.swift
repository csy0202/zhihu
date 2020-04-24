//
//  VipHeaderView.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/17.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit

class VipHeaderView: BaseView {
    
    var contentView = UIView()
    var iconIV = UIImageView().then{
        $0.backgroundColor = UIColor.lineColor()
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    
    var nameL = UILabel().then{
        $0.textColor = UIColor.titleColor()
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.text = "哈哈哈哈哈哈"
    }
    
    var subTitleL = UILabel().then{
        $0.textColor = UIColor.colorRGB(c: 151)
        $0.font = UIFont.boldSystemFont(ofSize: 12)
         $0.text = "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"
    }
    
    var searchBtn = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "vip_search"), for: .normal)
    }
    
    var model:VipHeaderModel?{
        didSet{
            guard let model = model else { return }
            iconIV.set_image(model.avatar_url)
            nameL.text = model.name
            subTitleL.text = model.content
        }
    }
    
    override func configUI() {
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(20 + kStatusBarH)
        }
        
        contentView.addSubview(iconIV)
        iconIV.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalTo(14)
            $0.width.height.equalTo(40)
        }
        
        contentView.addSubview(nameL)
        nameL.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalTo(iconIV.snp.right).offset(10)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(subTitleL)
        subTitleL.snp.makeConstraints{
            $0.top.equalTo(nameL.snp.bottom).offset(2)
            $0.left.equalTo(iconIV.snp.right).offset(10)
        }
        
        contentView.addSubview(searchBtn)
        searchBtn.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-14)
            $0.width.height.equalTo(30)
            $0.centerY.equalTo(iconIV)
        }
    }
}
