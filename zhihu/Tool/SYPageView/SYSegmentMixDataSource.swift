//
//  SYSegmentMixDataSource.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/15.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView

class SYSegmentMixDataSource: JXSegmentedTitleImageDataSource {
    open override func preferredRefreshItemModel(_ itemModel: JXSegmentedBaseItemModel, at index: Int, selectedIndex: Int) {
         super.preferredRefreshItemModel(itemModel, at: index, selectedIndex: selectedIndex)

         guard let itemModel = itemModel as? JXSegmentedTitleImageItemModel else {
             return
         }
         
        if index == 0 {
            itemModel.titleImageType = .rightImage
            itemModel.imageSize = CGSize(width: 6, height: 6)
            itemModel.selectedImageInfo = "titleImge"
            itemModel.normalImageInfo = ""
        }
        
        if index == 3 {
            itemModel.titleNormalColor = UIColor.themeColor()
            itemModel.titleSelectedColor = UIColor.themeColor()
            itemModel.titleCurrentColor = UIColor.themeColor()

        }
     }
    
    open override func preferredSegmentedView(_ segmentedView: JXSegmentedView, widthForItemAt index: Int) -> CGFloat {
        var itemWidth = super.preferredSegmentedView(segmentedView, widthForItemAt: index)
        if itemContentWidth == JXSegmentedViewAutomaticDimension {
            
            if index == 0 {
               itemWidth += titleImageSpacing + imageSize.width
            }
        }
        return itemWidth
    }
}

