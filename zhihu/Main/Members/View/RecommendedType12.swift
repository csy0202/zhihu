//
//  RecommendedType12.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/22.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
// MARK: - 模板12 （精选专题）
class RecommendedType12: RecommendedBaseCell {
    var titleView: cellHeaderView = {
        let view = cellHeaderView()
        return view
    }()
    
    override func configUI() {
        titleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 60)
        addSubview(titleView)
        
        // 注册cell
        collectionView.frame = CGRect(x: 0, y: 60, width: screenWidth, height: sizeModule12.height)
        addSubview(collectionView)
    }
    
    override func configData(moudleF: ModuleFrame) {
        super.configData(moudleF: moudleF)
        titleView.moduleModel = moudleF.model
        collectionView.reloadData()
    }
    /// 注册cell
    override func getCell<T>() -> T.Type where T : BaseCollectionViewCell {
        return moduleImgCell.self as! T.Type
    }
    /// 设置 item size
    override func setSizeForItem(indexPath: IndexPath) -> CGSize {
        return sizeModule12
    }
    /// 滚动结束位置
    override func setTargetContentOffset(targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let pageSize = sizeModule12.width + 10
        let page = roundf(Float(targetContentOffset.pointee.x / pageSize))
        targetContentOffset.pointee.x = pageSize * CGFloat(page)
    }
}

// MARK: - 模板12 collectionViewCell
class moduleImgCell: BaseCollectionViewCell {
    
    private var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 4
        img.layer.masksToBounds = true
        return img
    }()

    override func configSubViews(){
        img.frame = CGRect(x: 0, y: 0, width: sizeModule12.width, height: 140)
        addSubview(img)
    }
    
    override func configData(modelF:ContentFrame?){
        guard let modelF = modelF else { return }
        self.model = modelF.model
        img.set_image(modelF.model.artwork)
    }
}


