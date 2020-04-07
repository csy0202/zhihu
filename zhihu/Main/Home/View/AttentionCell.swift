//
//  AttentionCell.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/2.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import Reusable
class AttentionCell: BaseTableViewCell,Reusable{
    let header = HeaderView()
    let centerView = CenterView()
    let bottom = BottomView()
    var model:AttentionFrame?{
        didSet
        {
            guard let model = model else { return }
            header.frame = model.titleViewF
            header.modelF = model
            
            centerView.frame = model.centerF
            centerView.modelF = model
            
            bottom.frame = model.bottomF
            bottom.modelF = model
        }
    }
    override func configUI() {
        super.configUI()
        addSubview(header)
        addSubview(centerView)
        addSubview(bottom)
    }
}

class HeaderView: BaseView {
    let iconIV = UIImageView().then {
        $0.layer.cornerRadius = 16.5
        $0.layer.masksToBounds = true
        $0.isUserInteractionEnabled = true
    }
    
    let nameL = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor.colorHex(value: 0x101010)
    }
    
    let timeL = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor.colorRGB(r: 153, g: 153, b: 153)
    }
    
    let vipImg = UIImageView()
    let widgetImg = UIImageView()
    
    var modelF:AttentionFrame?{
        didSet{
            guard let modelF = modelF else { return }
            iconIV.set_image(modelF.avatarUrl)
            iconIV.frame = modelF.avatarF
            
            nameL.text = modelF.name
            nameL.frame = modelF.nameF
            
            vipImg.isHidden = !modelF.isVip
            widgetImg.isHidden = !modelF.isVip
            if modelF.isVip {
                vipImg.set_image(modelF.vipUrl)
                vipImg.frame = modelF.vipF
                widgetImg.set_image(modelF.widgetUrl)
                widgetImg.frame = modelF.widgetF
            }
            
            timeL.text = modelF.date
            timeL.frame = modelF.dateF
        }
    }
    override func configUI(){
        addSubview(iconIV)
        addSubview(nameL)
        addSubview(timeL)
        addSubview(vipImg)
        addSubview(widgetImg)
    }
}
class CenterView: BaseView {
    let titleL = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = UIColor.colorHex(value: 0x101010)
        $0.numberOfLines = 2
    }
    
    let subTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = UIColor.colorHex(value: 0x101010)
        $0.numberOfLines = 0
    }
    
    let rightImg = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    var modelF:AttentionFrame?{
        didSet{
            guard let modelF = modelF else { return }
            titleL.text = modelF.title
            titleL.frame = modelF.titleF
            subTitle.attributedText = modelF.subTitle
            subTitle.frame = modelF.subTitleF
            subTitle.lineBreakMode = .byTruncatingTail
            rightImg.set_image(modelF.iconUrl)
            rightImg.frame = modelF.iconF
        }
    }
    
    override func configUI() {
        addSubview(titleL)
        addSubview(subTitle)
        addSubview(rightImg)
    }
}

class BottomView: BaseView {
    let voteBtn = ButtonL().then {
        $0.setImage(UIImage(named: "voteup_count"), for: .normal)
        $0.setTitleColor(UIColor.colorHex(value: 0x8d8d8d), for: .normal)
        $0.setTitle("3万", for: .normal)
    }
    
    let commentBtn = ButtonL().then {
        $0.setImage(UIImage(named: "comment_count"), for: .normal)
        $0.setTitleColor(UIColor.colorHex(value: 0x8d8d8d), for: .normal)
//        $0.setTitle("3万", for: .normal)
    }
    
    let moreBtn = UIButton().then {
        $0.setImage(UIImage(named: "more"), for: .normal)
        $0.imageView?.contentMode = .center
    }
    
    let lineView = UIView().then {
         $0.backgroundColor = UIColor.colorRGB(r: 245, g: 245, b: 245)
    }
    
    
    var modelF:AttentionFrame?{
        didSet{
            guard let modelF = modelF else { return }
            voteBtn.frame = modelF.voteBtnF
            voteBtn.setTitle(modelF.voteBtnTitle, for: .normal)
            
            commentBtn.frame = modelF.commentBtnF
            commentBtn.setTitle(modelF.commentBtnTitle, for: .normal)
            
            moreBtn.frame = modelF.moreBtnF
            
            lineView.frame = CGRect(x: 0, y: 40, width: screenWidth, height: 8)
        }
    }
    
    override func configUI() {
        addSubview(voteBtn)
        addSubview(commentBtn)
        addSubview(moreBtn)
        addSubview(lineView)
    }
}
