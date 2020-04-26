//
//  RecommendedType21.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/24.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class RecommendedType21: RecommendedBaseCell {
    
    override func configSubviews() {
        super.configSubviews()
        
        collectionView.backgroundColor = UIColor.lineColor()
        collectionView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: sizeModule21.height)
        addSubview(collectionView)
    }
    /// 注册cell
    override func getCell<T>() -> T.Type where T : BaseCollectionViewCell {
        return moduleLiveCell.self as! T.Type
    }
    override func configData(moudleF: ModuleFrame) {
        super.configData(moudleF: moudleF)
        collectionView.reloadData()
    }
    /// 设置item Size
    override func setSizeForItem(indexPath: IndexPath) -> CGSize {
        return sizeModule21
    }
    /// 设置section 内边距
    override func setSectionEdgeInset(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

/// 模板21 （Live 直播中）
class moduleLiveCell: BaseCollectionViewCell {
    private var tagL: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.backgroundColor = UIColor.themeColor()
        lab.font = UIFont.systemFont(ofSize: 11)
        lab.text = "Live 直播中"
        lab.textAlignment = .center
        lab.layer.cornerRadius = 6
        lab.layer.masksToBounds = true
        lab.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMaxYCorner]
        return lab
    }()
    
    private var content : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
        return img
    }()
    
    private var nameL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 151)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = .center
        return lab
    }()
    
    private var line : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lineColor()
        return view
    }()
    
    private var titleL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.titleColor()
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    private var hotL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 151)
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    
    private var buyBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.setTitleColor(UIColor.themeColor(), for: .normal)
        btn.setTitle("立即进入 ▶", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.backgroundColor = UIColor.colorRGB(r: 232, g: 241, b: 253)
        return btn
    }()
    
    override func configSubViews(){
        backgroundColor = .lineColor()
        
        content.frame = CGRect(x: 0, y: 9, width: sizeModule21.width , height: 93)
        addSubview(content)

        img.frame = CGRect(x: 20, y: 16, width: 40, height: 40)
        content.addSubview(img)

        nameL.frame = CGRect(x: 10, y: img.frame.maxY + 6, width: 60, height: 15)
        content.addSubview(nameL)

        line.frame = CGRect(x: img.frame.maxX + 20, y: 22, width: 1, height: 50)
        content.addSubview(line)

        titleL.frame = CGRect(x: line.frame.maxX + 14, y: 22, width: content.frame.width - line.frame.maxX - 24, height: 20)
        content.addSubview(titleL)

        hotL.frame = CGRect(x: titleL.frame.minX, y: nameL.frame.minY, width: 120, height: 15)
        content.addSubview(hotL)

        buyBtn.frame = CGRect(x:content.frame.width - 100, y: 57, width: 90, height: 24)
        content.addSubview(buyBtn)

        tagL.frame = CGRect(x: 0, y: 0, width: 65, height: 18)
        addSubview(tagL)
    }
    
    override func configData(modelF: ContentFrame?) {
        guard let modelF = modelF else { return }
        self.model = modelF.model
        img.set_image(modelF.model.speaker?.member?.avatar_url)
        nameL.text = modelF.model.speaker?.member?.name
        titleL.text = modelF.model.subject
        hotL.text = "\(modelF.model.heat)热度"
    }
}
