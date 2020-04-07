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
    /// titleView
    var titleViewF = CGRect.zero
    
    var avatarF = CGRect.zero
    var avatarUrl  = ""
    
    var nameF = CGRect.zero
    var name = ""
    
    var isVip = false
    var vipF = CGRect.zero
    var vipUrl = ""
    var widgetF = CGRect.zero
    var widgetUrl = ""

    var dateF = CGRect.zero
    var date = ""
    
    /// centerView
    var centerF = CGRect.zero
    var title : String = ""
    var titleF = CGRect.zero
    var height : CGFloat = 0
    
    var iconUrl : String = ""
    var iconF = CGRect.zero
    var isShowIcon = true
    var isShowVideo = false
    let iconW : CGFloat = 95
    let iconH : CGFloat = 67
    
    var subTitle : NSAttributedString!
    var subTitleF = CGRect.zero
    
    /// bottomView
    var bottomF = CGRect.zero
    
    var voteBtnF = CGRect.zero
    var voteBtnTitle = ""
    var commentBtnF = CGRect.zero
    var commentBtnTitle = ""
    var moreBtnF = CGRect.zero
    
    var model:Article?
    
    init(model:Article) {
        self.model = model
        guard let model = self.model else { return }
        
        getTitleViewFrame(model: model)
        
        getCenterViewFrame(model: model)
        
        getBottomViewFrame(model: model)
 
 
    }
    
    mutating func getTitleViewFrame(model:Article){
        titleViewF = CGRect(x: 0, y: 0, width: screenWidth, height: 60)
        
        avatarF = CGRect(x: 14, y: 16, width: 33, height: 33)
        avatarUrl = model.source?.actor?.avatar_url ?? ""
        
        name = model.source?.actor?.name ?? ""
        let nameW = (name as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 15), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil).width
        nameF = CGRect(x: avatarF.maxX + 8, y: avatarF.minY, width: nameW, height: 15)
        
        isVip = model.source?.actor?.vip_info?.is_vip ?? false
        if isVip {
            vipUrl = model.source?.actor?.vip_info?.vip_icon?.url ?? ""
            vipF = CGRect(x: nameF.maxX + 5, y: avatarF.minY, width: 15, height: 15)
            
            widgetUrl = model.source?.actor?.vip_info?.widget?.url ?? ""
            widgetF = CGRect(x: screenWidth - 14 - 60, y: avatarF.minY, width: 60, height: 30)
        }
        if let time = model.source?.action_time {
            date =  Date.getCreatedDate(str: time) + "·" + model.source!.action_text
            dateF = CGRect(x: nameF.minX, y: nameF.maxY + 6, width: 200, height: 12)
        }
        
        
        
        
    }
    
    mutating func getCenterViewFrame(model:Article){
        title = "未知类型title:\(String(describing: model.target?.type))"
        if model.target?.type == "answer" {
            title = model.target?.question?.title ?? ""
        }else if model.target?.type == "article" {
            title = model.target?.title ?? ""
        }
        
        var titleH = (title as NSString).boundingRect(with: CGSize(width: screenWidth-28, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil).height
        titleH = min(titleH, 41)
        titleF = CGRect(x: 14, y: 0, width: screenWidth-28, height: titleH)
        
         var centerH = titleF.maxY
         let temp = getSubTitle(model: model)
         subTitle = temp.0
         var subTitleH = CGFloat.zero
         var subTitleW = CGFloat.zero
         
         iconUrl = model.target?.thumbnail ?? ""
         if let extra_info = model.target?.thumbnail_extra_info {
             if extra_info.type == "video" {
                 isShowIcon = false
                 isShowVideo = true
                 subTitleW = screenWidth - 28
             }
         }else{
             if iconUrl.count == 0 {
                 isShowIcon = false
                 subTitleW = screenWidth - 28
             }else{
                 isShowIcon = true
                 subTitleW = screenWidth - 28 - 12 - iconW
             }
         }
         print(subTitleW)
         
         subTitleH = (temp.1 as NSString).boundingRect(with: CGSize(width: subTitleW, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], context: nil).height
         subTitleH = min(subTitleH, 67)
         subTitleF = CGRect(x: 14, y: titleF.maxY + 10, width: subTitleW, height: subTitleH)
         centerH = subTitleF.maxY
         
         if iconUrl.count > 0  && isShowIcon{
             iconF = CGRect(x: screenWidth - 14 - iconW, y: titleF.maxY + 10, width: iconW, height: iconH)
             centerH = iconF.maxY
         }else if isShowVideo{
             iconF = CGRect(x: 14, y: subTitleF.maxY + 10, width: screenWidth-28, height: 196)
             centerH = iconF.maxY
         }
        centerF = CGRect(x: 0, y: titleViewF.maxY, width: screenWidth, height: centerH)
    }
    
    mutating func getBottomViewFrame(model:Article){
        bottomF = CGRect(x: 0, y: centerF.maxY, width: screenWidth, height: 48)
        height = bottomF.maxY

        voteBtnF = CGRect(x: 14, y: 5, width: 80, height: 35)
        voteBtnTitle = getBtnTitle(count: model.target?.voteup_count)
        
        commentBtnF = CGRect(x: voteBtnF.maxX + 2, y: 5, width: 80, height: 35)
        commentBtnTitle = getBtnTitle(count: model.target?.comment_count)
        
        moreBtnF = CGRect (x: screenWidth - 50, y: 5, width: 40, height: 35)
    }
    
    
    func getSubTitle(model:Article) -> (NSAttributedString , String) {
        var str1 = ""
        if let name = model.target?.author?.name {
            str1 = name + "："
        }
        
        let str2 = str1 + (model.target?.excerpt ?? "")
        let attr = NSMutableAttributedString(string: str2)
        attr.addAttributes([NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15),NSMutableAttributedString.Key.foregroundColor : UIColor.black], range: NSRange(location: 0, length: str1.count))
        attr.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),NSMutableAttributedString.Key.foregroundColor : UIColor.colorRGB(r: 66, g: 66, b: 66)], range: NSRange(location: str1.count, length: str2.count-str1.count))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .left
        
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
