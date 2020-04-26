//
//  RecommendedType.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/20.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class RecommendedType14: RecommendedBaseCell {
    
    private var titleView: cellHeaderView = {
        let view = cellHeaderView()
        return view
    }()
    
    override func configSubviews() {
        super.configSubviews()
        titleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 60)
        addSubview(titleView)
        
        collectionView.alwaysBounceHorizontal = true
        collectionView.frame = CGRect(x: 0, y: titleView.frame.maxY, width: screenWidth, height: sizeModule14.height)
        addSubview(collectionView)
    }
    
    override func configData(moudleF: ModuleFrame) {
        super.configData(moudleF: moudleF)
        titleView.moduleModel = moudleF.model
        collectionView.reloadData()
    }
    /// 注册cell
    override func getCell<T>() -> T.Type where T : BaseCollectionViewCell {
        return moduleCommonCell.self as! T.Type
    }
    /// 设置item Size
    override func setSizeForItem(indexPath: IndexPath) -> CGSize {
        return sizeModule14
    }
    /// 滚动结束位置
    override func setTargetContentOffset(targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let pageSize = sizeModule14.width + 10
        let page = roundf(Float(targetContentOffset.pointee.x / pageSize))
        targetContentOffset.pointee.x = pageSize * CGFloat(page)
    }
}

class RecommendedType6: RecommendedType14 {
    
    override func configSubviews() {
        super.configSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.bounces = false
        collectionView.frame = CGRect(x: 0, y: 60, width: screenWidth, height: sizeModule6.height * 2)
    }
    /// 设置行间距
    override func setLineSpacing(section: Int) -> CGFloat { return 0 }
}

class RecommendedType20: RecommendedType6 {
    override func configSubviews() {
        super.configSubviews()
        collectionView.frame = CGRect(x: 0, y: 60, width: screenWidth, height: sizeModule20.height * 2)
    }
    /// 设置item Size
    override func setSizeForItem(indexPath: IndexPath) -> CGSize {
        return sizeModule20
    }
}

class RecommendedType7: RecommendedType20 {
    override func configSubviews() {
        super.configSubviews()
        collectionView.frame = CGRect(x: 0, y: 60, width: screenWidth, height: sizeModule7.height)
    }
}

/// 通用模板(6 7 14 20)
class moduleCommonCell: BaseCollectionViewCell {
    private let img :RecommendedImageView = {
        let img  = RecommendedImageView(frame:CGRect.zero)
        return img
    }()
    
    private var titleL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.titleColor()
        lab.numberOfLines = 2
        lab.font = UIFont.systemFont(ofSize: 13)
        return lab
    }()

    
    private var numL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 165)
        lab.font = UIFont.systemFont(ofSize: 11)
        return lab
    }()
    
    override func configSubViews(){
        addSubview(img)
        addSubview(titleL)
        addSubview(numL)
    }
    
    override func configData(modelF: ContentFrame?) {
        guard let modelF = modelF else { return }
        self.model = modelF.model
        img.set_image(modelF.model.artwork)
        img.frame = modelF.imgVM.F
        img.vipImgUrl = modelF.model.icons?.left_top_day_icon
        img.tagTitle = modelF.imgVM.title
        
        titleL.attributedText = modelF.titleVM.attrTitle
        titleL.frame = modelF.titleVM.F
        
        numL.text = modelF.numVM.title
        numL.frame = modelF.numVM.F
    }
}
