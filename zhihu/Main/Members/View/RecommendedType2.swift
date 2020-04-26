//
//  RecommendedType2.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/23.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
// MARK: - 模板2（为你讲书）
class RecommendedType2: RecommendedType12 {
    /// 注册cell
    override func getCell<T>() -> T.Type where T : BaseCollectionViewCell {
        return moduleReadCell.self as! T.Type
    }
}

// MARK: - 模板2 collectionViewCell
class moduleReadCell: BaseCollectionViewCell {
    private let img :RecommendedImageView = {
        let img  = RecommendedImageView(frame:CGRect.zero)
        return img
    }()
    private var tagL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 32)
        lab.text = "讲书"
        lab.backgroundColor = UIColor.colorRGB(c: 234)
        lab.font = UIFont.systemFont(ofSize: 9)
        lab.textAlignment = .center
        lab.layer.cornerRadius = 4
        lab.layer.masksToBounds = true
        lab.layer.maskedCorners = [.layerMinXMinYCorner]
        return lab
    }()
    
    private var titleL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.titleColor()
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    private var authL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 70)
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    private var detailL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 70)
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    private var buyBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("去订阅栏目 >", for: .normal)
        btn.setTitleColor(UIColor.themeColor(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    override func configSubViews(){
        img.frame = CGRect(x: 0, y: 0, width: 105, height: 140)
        addSubview(img)
        
        tagL.frame = CGRect(x: img.frame.width - 30, y: img.frame.height - 16, width: 30, height: 16)
        img.addSubview(tagL)
        
        titleL.frame = CGRect(x: img.frame.maxX + 10, y: 8, width:screenWidth - 50 - img.frame.width  , height: 18)
        addSubview(titleL)
        
        authL.frame = CGRect(x: titleL.frame.minX, y: titleL.frame.maxY + 8, width: titleL.frame.width  , height: 18)
        addSubview(authL)
        
        detailL.frame = CGRect(x: titleL.frame.minX, y: authL.frame.maxY + 12, width: titleL.frame.width  , height: 18)
        addSubview(detailL)
        
        buyBtn.frame = CGRect(x: titleL.frame.minX, y: img.frame.height - 26, width: 85, height: 16)
        addSubview(buyBtn)
    }
    override func configData(modelF:ContentFrame?){
        guard let modelF = modelF else { return }
        self.model = modelF.model
        img.set_image(modelF.model.artwork)
        if modelF.model.authors.count > 0 {
            img.frame = CGRect(x: 0, y: 0, width: 105, height: 140)
            img.vipImgUrl = modelF.model.icons?.left_top_day_icon
            img.tagTitle = "讲书"
            titleL.isHidden = false
            authL.isHidden = false
            detailL.isHidden = false
            tagL.isHidden = false
            titleL.text = modelF.model.title
            authL.text = "讲者：" + modelF.model.authors[0].name
            detailL.text = modelF.model.summary
        }else{
            titleL.isHidden = true
            authL.isHidden = true
            detailL.isHidden = true
            tagL.isHidden = true
            img.frame = CGRect(x: 0, y: 0, width: sizeModule2.width, height: 140)
        }
    }
}
