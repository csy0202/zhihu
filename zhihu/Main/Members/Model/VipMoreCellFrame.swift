//
//  VipMoreCellFrame.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/24.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import UIKit

class VipMoreCellFrame : ModelFrame {
    let paragraphStyle = NSMutableParagraphStyle().then{
        $0.lineSpacing = 4
        $0.alignment = .left
    }
    
    var imgVM     = viewModel()
    var titleVM   = viewModel()
    var numVM     = viewModel()
    var priceVM   = viewModel()
    var model : VipMoreItemModel!
    
    override init(model: Any) {
        super.init(model: model)
        self.model = model as? VipMoreItemModel
        guard let model = self.model else { return }
        
        imgVM.F = CGRect(x: 20, y: 0, width: 70, height: 94)
        imgVM.url = model.image[0]
        
        /// 标题
        titleVM.X = imgVM.maxX + 10
        titleVM.Y = 2
        titleVM.W = screenWidth - imgVM.W - 50
        let title = model.title ?? ""
        let titleH = title.sizeWithRect(fontSize: 13, size: CGSize(width: titleVM.W, height: CGFloat(MAXFLOAT)), lineSpacing: 4).height
        titleVM.H = min(titleH, 40)
        
        let attrTitle =  NSMutableAttributedString(string: title)
        attrTitle.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13),NSMutableAttributedString.Key.foregroundColor : UIColor.titleColor(),NSAttributedString.Key.paragraphStyle:paragraphStyle], range: NSRange(location: 0, length: title.count))
        titleVM.attrTitle = attrTitle
        
        /// 章节数据
        
        var numTitle = model.description ?? ""
        if numTitle.count == 0 {
            numTitle = model.duration_text ?? ""
            if model.chapter_text?.count ?? 0 > 0 {
                numTitle += " | \(model.chapter_text!)"
            }
        }
        
        numVM.X = titleVM.X
        numVM.Y = titleVM.maxY + 10
        numVM.W = titleVM.W
        numVM.H = 14
        numVM.title =  numTitle
        
        
        let price = model.button_info?.button_text ?? "" + " 知乎币"
        let str = "原价："
        let string = str + price
        let priceTitle =  NSMutableAttributedString(string: string)
        priceTitle.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12),NSMutableAttributedString.Key.foregroundColor : UIColor.colorRGB(c: 200)], range: NSRange(location: 0, length: string.count))
        priceTitle.addAttributes([NSAttributedString.Key.strikethroughStyle: 1], range: NSRange(location: str.count, length: price.count))
        priceVM.attrTitle = priceTitle
        
    }
    
}
