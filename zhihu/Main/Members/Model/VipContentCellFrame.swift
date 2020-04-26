//
//  VipContentCellFrame.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/21.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import UIKit

/// 模板2 的 size （为你讲书）
let sizeModule2 = CGSize(width: screenWidth - 40, height: 160)
let moduleHeight2 : CGFloat = 60 + 160

/// 标准模板6  的 size （如何 xxx ?)
let sizeModule6 = CGSize(width:(screenWidth-50)/2,height:175)
let moduleHeight6 : CGFloat = 60 + 175 * 2

/// 模板7 的 size （电子书）
let sizeModule7 = CGSize(width: (screenWidth - 60)/3, height: 225)
let moduleHeight7 : CGFloat = 60 + 225

/// 模板12 的 size （精选专题）
let sizeModule12 = sizeModule2
let moduleHeight12 : CGFloat = 60 + 160

/// 模板14 的 size （热门推荐)
let sizeModule14 = sizeModule6
let moduleHeight14 : CGFloat = 60 + 175

/// 模板20 的 size （小说阅读）
let sizeModule20 = sizeModule7
let moduleHeight20 : CGFloat = 60 + 225 * 2

// 模板21 的 size （Live 直播中）
var sizeModule21 = CGSize(width: screenWidth - 20, height: 103)
let moduleHeight21 : CGFloat = 103

/// 模板22 的 size （盐选榜单）
let sizeModule22 = CGSize(width: screenWidth - 40, height: 125)
let moduleHeight22 : CGFloat = 55 + 125

/// 模板24 的 size （今日限免 & 折扣）
let sizeModule24 = CGSize(width:(screenWidth-20)/2,height:275)
let moduleHeight24 : CGFloat = 70 + 275


class ModuleFrame : ModelFrame {
//    var collectionVM     = viewModel()
    var cellId = "RecommendedBaseCell"
    var contents  = [ContentFrame]()
    var model :  Module?
    // collectionView 偏移量
    var collectionOffSet = CGPoint.zero
    override init(model: Any) {
        super.init(model: model)
        self.model = model as? Module
        guard let model = self.model else { return }
        
        for content in model.contents {
            let contentF = ContentFrame(model: content, type: model.type)
            contents.append(contentF)
        }
        
        if model.type == 2 {
            cellId = "RecommendedType2"
            height = moduleHeight2
        }else if model.type == 6 {
            cellId = "RecommendedType6"
            height = moduleHeight6
        }else if model.type == 7 {
            cellId = "RecommendedType7"
            height = moduleHeight7
        }else if model.type == 12 {
            cellId = "RecommendedType12"
            height = moduleHeight12
        }else if model.type == 14 {
            cellId = "RecommendedType14"
            height = moduleHeight14
        }else if model.type == 20 {
            cellId = "RecommendedType20"
            height = moduleHeight20
        }else if model.type == 21 {
           let w : CGFloat = model.contents.count > 1 ? 30 : 20
            sizeModule21 = CGSize(width: screenWidth - w, height: 103)
            cellId = "RecommendedType21"
            height = moduleHeight21
        }else if model.type == 22 {
            cellId = "RecommendedType22"
            height = moduleHeight22
        }else if model.type == 24 {
            cellId = "RecommendedType24"
            height = moduleHeight24
        }else{
            height = 45
        }
        
    }
}

class ContentFrame : ModelFrame {
    let paragraphStyle = NSMutableParagraphStyle().then{
        $0.lineSpacing = 4
        $0.alignment = .left
    }

    var imgVM     = viewModel()
    var titleVM   = viewModel()
    var numVM     = viewModel()
    var model     : Content!
    var type      : Int!
    
    var priceVM  = viewModel()
    
    init(model: Content , type:Int) {
        super.init(model: model)
        self.model = model
        self.type = type
        
        
        if type == 2 || type == 12 || type == 21 { return }
        
        if type == 22 {
            if model.rank_name == "HOTTEST" {
                imgVM.url = "rank_hot"
            }else if model.rank_name == "FASTEST" {
                imgVM.url = "rank_fast"
            }else if model.rank_name == "NEWEST" {
                imgVM.url = "rank_new"
            }
            return
        }
        
        if type == 24 {
            // 只获取price富文本，其他frame等设置都在cell内部初始化设置一次
            let price = String(format: "￥%.1f", model.price / 100)
            let str = "原价："
            let string = str + price
            let attrTitle =  NSMutableAttributedString(string: string)
            attrTitle.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11),NSMutableAttributedString.Key.foregroundColor : UIColor.colorRGB(c: 200)], range: NSRange(location: 0, length: string.count))
            attrTitle.addAttributes([NSAttributedString.Key.strikethroughStyle: 1], range: NSRange(location: str.count, length: price.count))
            priceVM.attrTitle = attrTitle
            return
        }
        
        // collectionCell 宽
        var itemW = sizeModule6.width
        // tag文案
        var tagTitle = "盐选专栏"
        // 图片高度
        var imgH : CGFloat = 90
        // 底部章节数据 | 作者
        var numTitle = model.chapter_text ?? ""
        if model.duration_text?.count ?? 0 > 0 {
            numTitle += " | \(model.duration_text!)"
        }
        
        if type == 20 || type == 7 {// 网络文学
            itemW = sizeModule20.width
            tagTitle = type == 20 ? "网络文学" : "电子书"
            imgH = 140
            numTitle = model.authors[0].name
        }
        /// 图片
        imgVM.X = 0
        imgVM.Y = 0
        imgVM.W = itemW
        imgVM.H = imgH
        imgVM.url = model.artwork ?? ""
        imgVM.title = tagTitle

        
        /// 标题
        titleVM.X = 0
        titleVM.Y = imgVM.maxY + 8
        titleVM.W = itemW
        let title = model.title ?? ""
        let titleH = title.sizeWithRect(fontSize: 13, size: CGSize(width: titleVM.W, height: CGFloat(MAXFLOAT)), lineSpacing: 4).height
        titleVM.H = min(titleH, 40)
        
        let attrTitle =  NSMutableAttributedString(string: title)
        attrTitle.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13),NSMutableAttributedString.Key.foregroundColor : UIColor.titleColor(),NSAttributedString.Key.paragraphStyle:paragraphStyle], range: NSRange(location: 0, length: title.count))
        titleVM.attrTitle = attrTitle
        
        /// 章节数据
        numVM.X = 0
        numVM.Y = titleVM.maxY + 10
        numVM.W = itemW
        numVM.H = 12
        numVM.title =  numTitle
    }
    
}
