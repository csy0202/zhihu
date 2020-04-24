//
//  RecommendedType22.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/22.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class RecommendedType22: RecommendedBaseCell {
    var titleView: cellHeaderView = {
        let view = cellHeaderView()
        return view
    }()
    
    override func configUI() {
        titleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 55)
        addSubview(titleView)
        
        collectionView.frame = CGRect(x: 0, y: 55, width: screenWidth, height: sizeModule22.height)
        addSubview(collectionView)
    }
    
    override func configData(moudleF: ModuleFrame) {
        super.configData(moudleF: moudleF)
        titleView.moduleModel = moudleF.model
        collectionView.reloadData()
    }
    override func getCell<T>() -> T.Type where T : BaseCollectionViewCell {
        return moduleRankCell.self as! T.Type
    }
    override func setSizeForItem(indexPath: IndexPath) -> CGSize {
        return sizeModule22
    }
    override func setSectionEdgeInset(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    override func setItemSpacing(section: Int) -> CGFloat {
        return 0
    }
    /// 滚动结束位置
    override func setTargetContentOffset(targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let pageSize = sizeModule12.width + 10
        let page = roundf(Float(targetContentOffset.pointee.x / pageSize))
        targetContentOffset.pointee.x = pageSize * CGFloat(page)
    }
}
class moduleRankCell: BaseCollectionViewCell {
    private var content : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.colorRGB(c: 200).cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 4
        return view
    }()
    
    private var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private var row1 : RankView!
    private var row2 : RankView!
    private var row3 : RankView!

    override func configSubViews() {
        content.frame = CGRect(x: 5, y: 5, width: sizeModule22.width, height: 100)
        addSubview(content)
        
        img.frame = CGRect(x:0, y: 0, width: 50, height: 100)
        content.addSubview(img)
        
        row1 = RankView(frame: CGRect(x:50, y: 10, width: content
        .frame.width - 50, height: 20))
        content.addSubview(row1)
        
        row2 = RankView(frame: CGRect(x:50, y: row1.frame.maxY + 10, width: content
        .frame.width - 50, height: 20))
        content.addSubview(row2)
        
        row3 = RankView(frame: CGRect(x:50, y: row2.frame.maxY + 10, width: content
        .frame.width - 50, height: 20))
        content.addSubview(row3)
    }
    override func configData(modelF:ContentFrame?){
        guard let modelF = modelF else { return }
        self.model = modelF.model
        img.image = UIImage(named: modelF.imgVM.url)
        
        row1.setTitle(title: modelF.model.data[0].title, rank: 1)
        row2.setTitle(title: modelF.model.data[1].title, rank: 2)
        row3.setTitle(title: modelF.model.data[2].title, rank: 3)
    }
}

class RankView: BaseView {
    private var rankL: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.boldSystemFont(ofSize: 14)
        lab.textAlignment = .center
        return lab
    }()
    
    private var titleL: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.titleColor()
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    override func configUI() {
        rankL.frame = CGRect(x: 5, y: 0, width: 10, height: frame.height)
        addSubview(rankL)
        
        titleL.frame = CGRect(x: rankL.frame.maxX + 5, y: 0, width: frame.width - rankL.frame.maxX - 5, height: frame.height)
        addSubview(titleL)
    }
    
    func setTitle(title:String?,rank:Int){
        if rank == 1 {
            rankL.textColor = UIColor.colorRGB(r: 241, g: 64, b: 62)
        }else if rank == 2 {
            rankL.textColor = UIColor.colorRGB(r: 255, g: 147, b: 0)
        }else if rank == 3 {
            rankL.textColor = UIColor.colorRGB(r: 255, g: 198, b: 1)
        }
        rankL.text = "\(rank)"
        titleL.text = title
    }
}




