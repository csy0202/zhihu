//
//  RecommendedHeaderView.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/17.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit

class RecommendedHeaderView: BaseView {
    private var bannerView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(bannerCell.self, forCellWithReuseIdentifier: "bannerCell")
        return collectionView
    }()
    
    private var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor =  .lineColor()
        return view
    }()
    
    var bannerModel : VipBannerModel?{
        didSet{
            guard let bannerModel = bannerModel  else {
                return
            }
            bannerView.set_image(bannerModel.banners[0].artwork)
            collectionView.reloadData()
        }
    }
    
    override func configUI() {
        backgroundColor = .white
        bannerView.frame = CGRect(x: 15, y: 15, width: screenWidth - 30, height: 90)
        addSubview(bannerView)
        
        collectionView.frame = CGRect(x: 0, y: bannerView.frame.maxY, width: screenWidth, height: 90)
        addSubview(collectionView)
        
        bottomView.frame = CGRect(x: 0, y: collectionView.frame.maxY, width: screenWidth, height: 8)
        addSubview(bottomView)
    }
}

extension RecommendedHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerModel?.navs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! bannerCell
        cell.model = self.bannerModel?.navs[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        delegate?.recommendGuessLikeCellItemClick(model: (self.recommendList?[indexPath.row])!)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 14 , bottom: 10, right: 14);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //    //最小行间距
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 5;
    //    }
    //
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(screenWidth-48)/5,height:70)
    }
}


class bannerCell: UICollectionViewCell {
    private var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private var titleL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.titleColor()
        lab.font = UIFont.systemFont(ofSize: 13)
        return lab
    }()
    
    var model : Nav?{
        didSet{
            guard let model = model else {
                return
            }
            img.set_image(model.icon)
            titleL.text = model.title
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }
    func configCell(){
        addSubview(img)
        img.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(5)
            $0.centerX.equalToSuperview()
        }
        addSubview(titleL)
        titleL.snp.makeConstraints {
            $0.top.equalTo(img.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
