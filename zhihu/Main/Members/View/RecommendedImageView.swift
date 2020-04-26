//
//  RecommendedImageView.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/26.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
class RecommendedImageView: UIImageView {
    lazy var vipImg : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private var tagL : UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.colorRGB(c: 32)
        lab.backgroundColor = UIColor.colorRGB(c: 234, a: 0.9)
        lab.font = UIFont.systemFont(ofSize: 9)
        lab.layer.cornerRadius = 4
        lab.layer.masksToBounds = true
        lab.layer.maskedCorners = [.layerMinXMinYCorner]
        return lab
    }()
    
    var vipImgUrl : String? {
        didSet {
            guard let vipImgUrl = vipImgUrl  else {
                vipImg.isHidden = true
                return
            }
            vipImg.isHidden = false
            vipImg.kf.setImage(with: URL(string: vipImgUrl), placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { [weak self] (image, error, cacheType, url) in
                guard let img = image else {return}
                let width = 17 / img.size.height * img.size.width
                self?.vipImg.frame = CGRect(x: 0, y: 0, width: width, height: 17)
            }
        }
    }
    
    var tagTitle : String? {
        didSet{
            guard let tagTitle = tagTitle else { return }
            tagL.text = "  \(tagTitle)  "
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFill
        backgroundColor = UIColor.lineColor()
        layer.cornerRadius = 4
        layer.masksToBounds = true
        addSubview(vipImg)
        
        addSubview(tagL)
        tagL.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.right.bottom.equalToSuperview()
        }
        addSubview(tagL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
