//
//  RecommendedType24.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/22.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class RecommendedType24: RecommendedBaseCell {
    
    private var titleL: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        lab.font = UIFont.boldSystemFont(ofSize: 17)
        return lab
    }()
    
    private var subTitleL: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 153)
        lab.font = UIFont.systemFont(ofSize: 13)
        return lab
    }()
    
    private var moreBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("订阅", for: .normal)
        btn.setTitleColor(UIColor.themeColor(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.backgroundColor = UIColor.colorRGB(c: 247)
        btn.layer.cornerRadius = 3
        btn.layer.masksToBounds = true
        return btn
    }()
    override func configSubviews() {
        super.configSubviews()
        titleL.frame = CGRect(x: 20, y: 20, width: 250, height: 20)
        addSubview(titleL)
        
        subTitleL.frame = CGRect(x: 20, y: titleL.frame.maxY + 6, width: 250, height: 16)
        addSubview(subTitleL)
        
        moreBtn.frame = CGRect(x: screenWidth - 90, y: 25, width: 70, height: 30)
        addSubview(moreBtn)
        
        collectionView.frame = CGRect(x: 0, y: 70, width: screenWidth, height: sizeModule24.height)
        addSubview(collectionView)
    }
     /// 注册cell
    override func getCell<T>() -> T.Type where T : BaseCollectionViewCell {
        return modulePriceCell.self as! T.Type
    }
    override func configData(moudleF: ModuleFrame) {
        super.configData(moudleF: moudleF)
        titleL.text = moudleF.model?.title
        subTitleL.text = "点击订阅，第一时间获取免费&特价好内容"
        collectionView.reloadData()
    }
    /// 设置item Size
    override func setSizeForItem(indexPath: IndexPath) -> CGSize {
        return sizeModule24
    }
    /// 设置section 内边距
    override func setSectionEdgeInset(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    /// item 间距
    override func setItemSpacing(section: Int) -> CGFloat {
        return 0
    }
}

/// 模板24 （今日限免 & 折扣）
class modulePriceCell: BaseCollectionViewCell {
    private var content : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.colorRGB(c: 200).cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 4
        return view
    }()
    
    private var flagL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.layer.cornerRadius = 4
        lab.layer.masksToBounds = true
        lab.font = UIFont.systemFont(ofSize: 10)
        lab.textAlignment = .center
        lab.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMaxYCorner]
        lab.backgroundColor = UIColor.themeColor()
        return lab
    }()
    
    private var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 4
        img.layer.masksToBounds = true
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
    
    private var priceL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 190)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = .center
        return lab
    }()
    
    private var buyBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.colorRGB(r: 249, g: 152, b: 27).cgColor
        btn.layer.borderWidth = 1
        btn.setTitleColor(UIColor.colorRGB(r: 249, g: 152, b: 27), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()
    
    override func configSubViews(){
        content.frame = CGRect(x: 10, y: 5, width: sizeModule24.width - 20, height: sizeModule24.height - 20)
        addSubview(content)
        
        flagL.frame = CGRect(x: 0, y: 0, width: 40, height: 18)
        content.addSubview(flagL)
        
        img.frame = CGRect(x: (content.frame.width - 84)/2, y: 20, width: 84, height: 112)
        content.addSubview(img)
        
        titleL.frame = CGRect(x: 16, y: img.frame.maxY + 10, width: content.frame.width - 32, height: 36)
        content.addSubview(titleL)
        
        priceL.frame = CGRect(x: 16, y: titleL.frame.maxY + 10, width: content.frame.width - 32, height: 14)
        content.addSubview(priceL)
        
        buyBtn.frame = CGRect(x: (content.frame.width - 80)/2, y: priceL.frame.maxY + 6, width: 80, height: 30)
        content.addSubview(buyBtn)
    }
    
    override func configData(modelF: ContentFrame?) {
        guard let modelF = modelF else { return }
        self.model = modelF.model
        flagL.text = modelF.model.label_text
        img.set_image(modelF.model.tab_artwork)
        titleL.text = modelF.model.title
        priceL.attributedText = modelF.priceVM.attrTitle
        buyBtn.setTitle(modelF.model.button_text, for: .normal)
    }
}

