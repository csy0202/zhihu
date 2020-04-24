//
//  HotCell.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/12.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit

class HotCell: BaseTableViewCell {
    let numL = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = UIColor.numColor()
    }
    
    let titleL = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    let descL = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor.descColor()
        $0.numberOfLines = 1
    }
    
    let metricsL = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor.numColor()
    }
    
    let imgV = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.lineColor()
    }
    
    let lineView = UIView().then{
        $0.backgroundColor = UIColor.lineColor()
    }
    
    var num : Int?{
        didSet {
            guard let num = num else { return }
            numL.text = "\(num + 1)"
        }
    }
    
    var model : TopicFrame? {
        didSet {
            guard let model = model else { return }
            numL.frame = model.numVM.F
            
            titleL.frame = model.titleVM.F
            titleL.text = model.titleVM.title
            
            descL.isHidden = !model.descVM.isShow
            if model.descVM.isShow {
                descL.frame = model.descVM.F
                descL.text = model.descVM.title
            }
            
            imgV.isHidden = !model.imgVM.isShow
            if model.imgVM.isShow {
                imgV.frame = model.imgVM.F
                imgV.set_image(model.imgVM.url)
            }
            
            metricsL.frame = model.metricsVM.F
            metricsL.text = model.metricsVM.title
            
            lineView.frame = model.lineVM.F
        }
    }
    override func configUI() {
        addSubview(numL)
        addSubview(titleL)
        addSubview(descL)
        addSubview(metricsL)
        addSubview(imgV)
        addSubview(lineView)
    }
}
