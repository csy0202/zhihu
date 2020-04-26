//
//  RecommendedMoreCell.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/24.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit

class RecommendedMoreCell: BaseTableViewCell {
    
    private let img :RecommendedImageView = {
        let img  = RecommendedImageView(frame:CGRect.zero)
        return img
    }()
    
    private var titleL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.titleColor()
        lab.numberOfLines = 2
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    private var numL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 165)
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    
    private var priceL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 190)
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    
    override func configUI() {
        img.frame = CGRect(x: 20, y: 0, width: 70, height: 94)
        addSubview(img)
        addSubview(titleL)
        addSubview(numL)
        priceL.frame = CGRect(x: img.frame.maxX + 10, y: 75, width: screenWidth - img.frame.width - 50, height: 16)
        addSubview(priceL)
    }
    
    var modelF : VipMoreCellFrame?{
        didSet{
            guard let modelF = modelF else { return }
            img.set_image(modelF.imgVM.url)
            img.vipImgUrl = modelF.model.icons?.left_top_day_icon
            img.tagTitle = "电子书"
            
            titleL.attributedText = modelF.titleVM.attrTitle
            titleL.frame = modelF.titleVM.F
            
            numL.text = modelF.numVM.title
            numL.frame = modelF.numVM.F
            
            priceL.attributedText = modelF.priceVM.attrTitle
        }
    }
}
