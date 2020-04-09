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
            header.frame = model.topVM.F
            header.modelF = model
            
            centerView.frame = model.centerVM.F
            centerView.modelF = model
            
            bottom.frame = model.bottomVM.F
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
        $0.backgroundColor = UIColor.colorRGB(r: 248, g: 248, b: 248)
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
            iconIV.set_image(modelF.avatarVM.url)
            iconIV.frame = modelF.avatarVM.F
            
            nameL.text = modelF.nameVM.title
            nameL.frame = modelF.nameVM.F
            
            vipImg.isHidden = !modelF.vipVM.isShow
            widgetImg.isHidden = !modelF.vipVM.isShow
            if modelF.vipVM.isShow {
                vipImg.set_image(modelF.vipVM.url)
                vipImg.frame = modelF.vipVM.F
                widgetImg.set_image(modelF.widgetVM.url)
                widgetImg.frame = modelF.widgetVM.F
            }
            
            timeL.text = modelF.dateVM.title
            timeL.frame = modelF.dateVM.F
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
        $0.backgroundColor = UIColor.colorRGB(r: 241, g: 241, b: 241)
    }
    
    let videoImg = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    var modelF:AttentionFrame?{
        didSet{
            guard let modelF = modelF else { return }
            titleL.text = modelF.titleVM.title
            titleL.frame = modelF.titleVM.F
            titleL.lineBreakMode = .byTruncatingTail
            
            subTitle.isHidden = !modelF.descVM.isShow
            if modelF.descVM.isShow {
                subTitle.attributedText = modelF.descVM.attrTitle
                subTitle.frame = modelF.descVM.F
                subTitle.lineBreakMode = .byTruncatingTail
            }
            
            rightImg.isHidden = !modelF.imgVM.isShow
            if modelF.imgVM.isShow {
                rightImg.set_image(modelF.imgVM.url)
                rightImg.frame = modelF.imgVM.F
            }
            
            videoImg.isHidden = !modelF.videoVM.isShow
            if modelF.videoVM.isShow {
                videoImg.set_image(modelF.videoVM.url)
                videoImg.frame = modelF.videoVM.F
            }
        }
    }
    
    override func configUI() {
        addSubview(titleL)
        addSubview(subTitle)
        addSubview(rightImg)
        addSubview(videoImg)
        
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
    }
    
    let moreBtn = UIButton().then {
        $0.setImage(UIImage(named: "more"), for: .normal)
        $0.imageView?.contentMode = .center
    }
    
    let footL = UILabel().then {
        $0.textColor = .colorHex(value: 0x8d8d8d)
        $0.font = .systemFont(ofSize: 12)
    }
    
    let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "close"), for: .normal)
        $0.imageView?.contentMode = .center
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = UIColor.colorRGB(r: 245, g: 245, b: 245)
    }
    
    
    var modelF:AttentionFrame?{
        didSet{
            guard let modelF = modelF else { return }
            voteBtn.isHidden = !modelF.voteVM.isShow
            if modelF.voteVM.isShow {
                voteBtn.frame = modelF.voteVM.F
                voteBtn.setTitle(modelF.voteVM.title, for: .normal)
            }
            
            commentBtn.isHidden = !modelF.commentVM.isShow
            if modelF.commentVM.isShow {
                commentBtn.frame = modelF.commentVM.F
                commentBtn.setTitle(modelF.commentVM.title, for: .normal)
            }
            
            moreBtn.isHidden = !modelF.moreVM.isShow
            if modelF.moreVM.isShow {
                moreBtn.frame = modelF.moreVM.F
            }
            
            footL.isHidden = !modelF.footVM.isShow
            if modelF.footVM.isShow {
                footL.frame = modelF.footVM.F
                footL.text = modelF.footVM.title
            }
            
            closeBtn.isHidden = !modelF.closeVM.isShow
            if modelF.closeVM.isShow {
                closeBtn.frame = modelF.closeVM.F
            }

            lineView.frame = CGRect(x: 0, y: 40, width: screenWidth, height: 8)
        }
    }
    
    override func configUI() {
        addSubview(voteBtn)
        addSubview(commentBtn)
        addSubview(moreBtn)
        addSubview(footL)
        addSubview(closeBtn)
        addSubview(lineView)
    }
}
