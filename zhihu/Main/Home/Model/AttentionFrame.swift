//
//  AttentionFrame.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/4.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import UIKit
struct AttentionFrame {
    let paragraphStyle = NSMutableParagraphStyle().then{
        $0.lineSpacing = 4
        $0.alignment = .left
    }
    
    /// titleView
    var topVM    = viewModel()
    var avatarVM = viewModel()
    var nameVM   = viewModel()
    var vipVM    = viewModel()
    var widgetVM = viewModel()
    var dateVM   = viewModel()
    
    /// centerView
    var centerVM = viewModel()
    var titleVM  = viewModel()
    var descVM   = viewModel()
    var imgVM    = viewModel()
    var videoVM  = viewModel()

    /// bottomView
    var bottomVM  = viewModel()
    var voteVM    = viewModel()
    var commentVM = viewModel()
    var moreVM    = viewModel()
    var footVM    = viewModel()
    var closeVM   = viewModel()
    
    
//    var bottomF = CGRect.zero
//
//    var voteBtnF = CGRect.zero
//    var voteBtnTitle = ""
//    var commentBtnF = CGRect.zero
//    var commentBtnTitle = ""
//    var moreBtnF = CGRect.zero
    
    var height : CGFloat = 0
    var model:Article?
    
    init(model:Article) {
        self.model = model
        guard let model = self.model else { return }
        
        getTitleViewFrame(model: model)
        
        getCenterViewFrame(model: model)
        
        getBottomViewFrame(model: model)
        
    }
    
    mutating func getTitleViewFrame(model:Article){
        
        let marginTop :CGFloat = 16
        if model.type == "moments_feed" {
            avatarVM.url = model.source?.actor?.avatar_url ?? ""
            nameVM.title = model.source?.actor?.name ?? ""
            vipVM.isShow = model.source?.actor?.vip_info?.is_vip ?? false
            dateVM.title = Date.getCreatedDate(str: model.source?.action_time ?? 0) + "·" + model.source!.action_text
            
        }else{
            avatarVM.url = model.ad?.creatives[0].brand?.logo ?? ""
            nameVM.title = model.ad?.creatives[0].brand?.name ?? ""
            vipVM.isShow = false
            dateVM.title = "发布了广告"
        }
        avatarVM.F = CGRect(x: 14, y: marginTop, width: 33, height: 33)
        
        nameVM.W = (nameVM.title as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 15), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil).width
        nameVM.F = CGRect(x: avatarVM.F.maxX + 8, y: marginTop, width: nameVM.W, height: 15)
        
        if vipVM.isShow {
            vipVM.url = model.source?.actor?.vip_info?.vip_icon?.url ?? ""
            vipVM.F = CGRect(x: nameVM.F.maxX + 5, y: marginTop, width: 15, height: 15)
            
            widgetVM.url = model.source?.actor?.vip_info?.widget?.url ?? ""
            widgetVM.F = CGRect(x: screenWidth - 14 - 60, y: marginTop, width: 60, height: 30)
        }
        
        dateVM.F = CGRect(x: nameVM.F.minX, y: nameVM.F.maxY + 6, width: 200, height: 12)
        
        topVM.F = CGRect(x: 0, y: 0, width: screenWidth, height: 60)
    }
    
    mutating func getCenterViewFrame(model:Article){
        titleVM.title = "未知类型title:\(String(describing: model.target?.type))"
        
        let contentW = screenWidth - 28
        imgVM.W = 95
        imgVM.H = 67
        
        videoVM.isShow = false
        imgVM.isShow = false
        if model.type == "moments_feed" {
            if model.target?.type == "answer" {
                titleVM.title = model.target?.question?.title ?? ""
            }else if model.target?.type == "article" {
                titleVM.title = model.target?.title ?? ""
            }
            let titleH = (titleVM.title as NSString).boundingRect(with: CGSize(width: contentW, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil).height
            titleVM.H = min(titleH, 41)
            titleVM.W = contentW
            titleVM.Y = 0
            titleVM.X = 14
            
            centerVM.H = titleVM.maxY
            
            let temp = getSubTitle(s1: model.target?.author?.name ?? "", s2: model.target?.excerpt ?? "")
            descVM.attrTitle = temp.0
            descVM.X = 14
            descVM.Y = titleVM.maxY + 10
            descVM.W = contentW
            
            if let extra_info = model.target?.thumbnail_extra_info {
                if extra_info.type == "video" {
                    videoVM.isShow = true
                    videoVM.url = model.target?.thumbnail ?? ""
                    videoVM.W = contentW
                    videoVM.H = 196
                    videoVM.X = 14
                }
            }else{
                if model.target?.thumbnail.count ?? 0 > 0 {
                    imgVM.isShow = true
                    imgVM.X = screenWidth - 14 - imgVM.W
                    imgVM.Y = titleVM.maxY + 10
                    imgVM.url = model.target?.thumbnail ?? ""
                    descVM.W -= (imgVM.W + 12)
                }
            }
            
            let subTitleH = (temp.1 as NSString).boundingRect(with: CGSize(width: descVM.W, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.paragraphStyle:paragraphStyle], context: nil).height
            descVM.H = min(subTitleH, 67)
            centerVM.H = descVM.maxY
            
            if videoVM.isShow {
                videoVM.Y = descVM.maxY + 10
            }
        }else{
            titleVM.title = model.ad?.creatives[0].title ?? ""
            titleVM.W = contentW
            titleVM.X = 14
            titleVM.Y = 0
            
            if model.ad?.creatives[0].description.count ?? 0 > 0 {
                let temp = getSubTitle(s2: model.ad?.creatives[0].description ?? "")
                descVM.attrTitle = temp.0
                descVM.title = temp.1
                descVM.W = contentW
                descVM.X = 14
            }else{
                descVM.isShow = false
            }
            
            if model.ad?.creatives[0].thumbnail_extra_info?.type == "video"{
                videoVM.isShow = true
                videoVM.url = model.ad?.creatives[0].thumbnail_extra_info?.url ?? ""
                videoVM.W = contentW
                videoVM.H = 196
                videoVM.X = 14
            }else{
                if model.ad?.creatives[0].image.count ?? 0 > 0 {
                    imgVM.isShow = true
                    imgVM.url = model.ad?.creatives[0].image ?? ""
                    imgVM.X = screenWidth - 14 - imgVM.W
                    
                    if descVM.isShow {
                        titleVM.W = contentW
                        descVM.W  =  contentW - imgVM.W - 12
                    }else{
                        titleVM.W = contentW - imgVM.W - 12
                    }
                }
            }
            
            let titleH = (titleVM.title as NSString).boundingRect(with: CGSize(width: titleVM.W, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil).height
            titleVM.H = min(titleH, 41)
            centerVM.H = titleVM.maxY
            if descVM.isShow {
                let subTitleH = (descVM.title as NSString).boundingRect(with: CGSize(width: descVM.W, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.paragraphStyle:paragraphStyle], context: nil).height
                descVM.H = min(subTitleH, 67)
                descVM.Y = titleVM.maxY + 10
                centerVM.H = descVM.maxY
                if imgVM.isShow {
                    imgVM.Y = descVM.Y
                    centerVM.H = imgVM.maxY
                }
                
                if videoVM.isShow {
                    videoVM.Y = descVM.maxY + 10
                    centerVM.H = videoVM.maxY
                }
            }else{
                if imgVM.isShow {
                    imgVM.Y = 0
                    centerVM.H = imgVM.maxY
                }
                
                if videoVM.isShow {
                    videoVM.Y = titleVM.maxY + 10
                    centerVM.H = videoVM.maxY
                }
            }
        }
        
        titleVM.getFrame()
        if descVM.isShow { descVM.getFrame()}
        if imgVM.isShow { imgVM.getFrame()}
        if videoVM.isShow { videoVM.getFrame()}
        centerVM.F = CGRect(x: 0, y: topVM.F.maxY, width: screenWidth, height: centerVM.H)
    }
    
    mutating func getBottomViewFrame(model:Article){
        voteVM.isShow = false
        commentVM.isShow = false
        moreVM.isShow = false
        footVM.isShow = false
        closeVM.isShow = false
        if model.type == "moments_feed" {
            voteVM.isShow = true
            voteVM.F = CGRect(x: 14, y: 5, width: 80, height: 35)
            voteVM.title = getBtnTitle(count: model.target?.voteup_count)
            
            commentVM.isShow = true
            commentVM.F = CGRect(x: voteVM.F.maxX + 2, y: 5, width: 80, height: 35)
            commentVM.title = getBtnTitle(count: model.target?.comment_count)
            
            moreVM.isShow = true
            moreVM.F = CGRect (x: screenWidth - 50, y: 5, width: 40, height: 35)
        }else {
            footVM.isShow = true
            footVM.title = model.ad?.creatives[0].cta?.value ?? ""
            if let appInfo = model.ad?.creatives[0].app_info {
                if model.ad?.creatives[0].thumbnail_extra_info?.type == "video"  {
                    footVM.title = getBtnTitle(count: model.ad?.creatives[0].video_watch_num) + "人观看·" + footVM.title
                }else{
                   footVM.title = "AppStore 评分：" + String(format: "%.1f", appInfo.score) + "·" + footVM.title
                }
            }
            footVM.F = CGRect(x: 14, y: 5, width: 250, height: 35)
            
            closeVM.isShow = true
            closeVM.F = CGRect(x: screenWidth - 50, y: 5, width: 40, height: 35)
        }
        
        bottomVM.F = CGRect(x: 0, y: centerVM.F.maxY, width: screenWidth, height: 48)
        height = bottomVM.F.maxY
    }
    
    func getSubTitle(s1:String = "",s2:String) -> (NSAttributedString , String){
        var str1 : String = ""
        if s1.count > 0 {
            str1 = s1 + "："
        }
        let str2 = str1 + s2
        let attr = NSMutableAttributedString(string: str2)
        attr.addAttributes([NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15),NSMutableAttributedString.Key.foregroundColor : UIColor.black], range: NSRange(location: 0, length: str1.count))
        attr.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),NSMutableAttributedString.Key.foregroundColor : UIColor.colorRGB(r: 66, g: 66, b: 66)], range: NSRange(location: str1.count, length: str2.count-str1.count))
        attr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, str2.count))
        
        return (attr , str2)
    }

    func getBtnTitle(count:Int?) -> String{
        var voteCount = Double(count ?? 0)
        var title = String(format: "%.0f",voteCount)
        if voteCount > 100000000.0 {
            voteCount = voteCount / 100000000.0
            title = String(format: "%.1f亿",voteCount)
        } else if voteCount > 10000.0 {
            voteCount = voteCount / 10000.0
            title = String(format: "%.1f万",voteCount)
        }
        return title
    }
}
