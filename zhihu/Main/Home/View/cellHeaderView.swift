//
//  cellHeaderView.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/3.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class cellHeaderView: BaseView {
    let iconIV = UIImageView().then {
        $0.layer.cornerRadius = 16.5
        $0.layer.masksToBounds = true
        $0.isUserInteractionEnabled = true
    }
    
    let nameL = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor.colorHex(value: 0x101010)
    }
    
    let timeL = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor.colorRGB(r: 153, g: 153, b: 153)
    }

    let vipImg = UIImageView()
    let widgetImg = UIImageView()
    
    var source:Source?{
        didSet{
            guard let source = source else { return }
            iconIV.set_image(source.actor?.avatar_url)
            nameL.text = source.actor?.name
            if source.action_time > 0 {
                timeL.text =  Date.getCreatedDate(str: source.action_time) + "·" + source.action_text
            }
            
            let isVip = source.actor?.vip_info?.is_vip ?? false
            vipImg.isHidden = !isVip
            widgetImg.isHidden = !isVip
            if isVip {
                vipImg.set_image(source.actor?.vip_info?.vip_icon?.url)
                widgetImg.set_image(source.actor?.vip_info?.widget?.url)
            }
            
        }
    }
    override func configUI(){
        addSubview(iconIV)
        iconIV.snp.makeConstraints{
            $0.left.equalTo(14)
            $0.top.equalTo(16)
            $0.width.height.equalTo(33)
        }
        
        addSubview(nameL)
        nameL.snp.makeConstraints {
            $0.left.equalTo(iconIV.snp.right).offset(8)
            $0.top.equalTo(iconIV)
            $0.height.equalTo(15)
        }
        
        addSubview(timeL)
        timeL.snp.makeConstraints {
            $0.left.equalTo(nameL)
            $0.top.equalTo(nameL.snp.bottom).offset(6)
        }
        
        addSubview(vipImg)
        vipImg.snp.makeConstraints {
            $0.left.equalTo(nameL.snp.right).offset(5)
            $0.top.equalTo(iconIV)
            $0.width.height.equalTo(15)
        }
        
        addSubview(widgetImg)
        widgetImg.snp.makeConstraints {
            $0.right.equalToSuperview().inset(14)
            $0.top.equalTo(iconIV)
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }
    }
}
