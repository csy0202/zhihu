//
//  cellContentView.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/3.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit

class cellContentView: BaseView {
    let titleL = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = UIColor.colorHex(value: 0x101010)
        $0.numberOfLines = 2
    }
    
    let subTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = UIColor.colorHex(value: 0x101010)
        $0.numberOfLines = 0
    }
    
    let rightImg = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    var modelF:AttentionFrame?{
        didSet{
            guard let modelF = modelF else { return }
            titleL.text = modelF.title
            titleL.frame = modelF.titleF
            subTitle.attributedText = modelF.subTitle
            subTitle.frame = modelF.subTitleF
            subTitle.lineBreakMode = .byTruncatingTail
            rightImg.set_image(modelF.iconUrl)
            rightImg.frame = modelF.iconF
        }
    }
    
    override func configUI() {
        addSubview(titleL)
        addSubview(subTitle)
        addSubview(rightImg)
    }
    
}
