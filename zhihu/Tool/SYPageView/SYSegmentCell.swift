//
//  SYSegmentCell.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/14.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView

open class SYSegmentCell: JXSegmentedTitleCell {
    

    open override func layoutSubviews() {
        let labelBounds = CGRect(x: 0, y: 0, width: 56, height: 30)
        
        titleLabel.bounds = labelBounds
        titleLabel.center = contentView.center
        
        titleLabel.layer.cornerRadius = 3
        titleLabel.layer.masksToBounds = true
    }

    open override func reloadData(itemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType) {
        
        super.reloadData(itemModel: itemModel, selectedType: selectedType )

        guard let myItemModel = itemModel as? SYSegmentItemModel else {
            return
        }
        
        titleLabel.backgroundColor = myItemModel.titleCurrentBackgroundColor
        
    }
    
        open override func preferredTitleColorAnimateClosure(itemModel: JXSegmentedTitleItemModel) -> JXSegmentedCellSelectedAnimationClosure {
            guard let myItemModel = itemModel as? SYSegmentItemModel else {
                return super.preferredTitleColorAnimateClosure(itemModel: itemModel)
            }
            
           
                let closure: JXSegmentedCellSelectedAnimationClosure = {[weak self] (percent) in
                    if itemModel.isSelected {
                        //将要选中
                        myItemModel.titleCurrentBackgroundColor = JXSegmentedViewTool.interpolateColor(from: myItemModel.titleNormalBackgroundColor, to: myItemModel.titleSelectedBackgroundColor, percent: percent)
                    }else {
                        //将要取消选中
                        myItemModel.titleCurrentBackgroundColor = JXSegmentedViewTool.interpolateColor(from: myItemModel.titleSelectedBackgroundColor, to: myItemModel.titleNormalBackgroundColor, percent: percent)
                    }
                    self?.titleLabel.backgroundColor = myItemModel.titleCurrentBackgroundColor
                }
                //手动调用closure，更新到最新状态
                closure(0)
                return closure
            
        }
        
}

