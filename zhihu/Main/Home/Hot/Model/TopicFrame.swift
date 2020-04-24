//
//  TopicFrame.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/12.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import UIKit

class TopicFrame : ModelFrame {

    var numVM     = viewModel()
    var titleVM   = viewModel()
    var descVM    = viewModel()
    var metricsVM = viewModel()
    var imgVM     = viewModel()
    var lineVM    = viewModel()
    
    var model :  TopicModel?
    override init(model: Any) {
        super.init(model: model)
        self.model = model as? TopicModel
        guard let model = self.model else { return }

        numVM.F = CGRect(x: 16, y: 13, width: 24, height: 17)
        
        // ps: 标题 和 标号的距离为 7  标题和图片的距离为 14
         
        titleVM.title = model.target?.title ?? ""
        titleVM.X = numVM.F.maxX + 7
        titleVM.Y = 15
        titleVM.W = screenWidth - titleVM.X - 16

        imgVM.url = model.children[0].thumbnail ?? ""
        if imgVM.url.count > 0 {
            imgVM.isShow = true
            imgVM.F = CGRect(x: screenWidth - 16 - 95, y: 13, width: 95, height: 67)
            titleVM.W -= 95 + 14
        }
        
        titleVM.H = titleVM.title.sizeWithRect(fontSize: 17, size: CGSize(width: titleVM.W, height: CGFloat(MAXFLOAT)), isBold: true).height
        
        metricsVM.title = model.detail_text ?? ""
        metricsVM.X = titleVM.X
        metricsVM.W = 300
        metricsVM.H = 14
        metricsVM.Y = titleVM.maxY + 10
        
        descVM.title = model.target?.excerpt ?? ""
        if titleVM.H < 25 && descVM.title.count > 0 {
            descVM.isShow = true
            descVM.F = CGRect(x: titleVM.X, y: titleVM.maxY + 10, width: titleVM.W, height: 15)
            metricsVM.Y = descVM.maxY + 10
        }
        
        lineVM.X = 16
        lineVM.Y = max(metricsVM.maxY, imgVM.maxY) + 10
        lineVM.W = screenWidth - 32
        lineVM.H = 1
        
        height = lineVM.maxY
        
    }
}
