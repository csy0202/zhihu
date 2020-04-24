//
//  SYSegmentDataSource.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/14.
//  Copyright © 2020 chensy. All rights reserved.
//
import UIKit
import JXSegmentedView
import Then

open class SYSegmentDataSource: JXSegmentedTitleDataSource {
    
    /// titleLabel 的 padding 内边距
    open var padding : UIEdgeInsets = UIEdgeInsets.zero
    /// 圆角
    open var cornerRadius : CGFloat = 0
    /// 当前背景色
    open var titleCurrentBackgroundColor : UIColor = .clear
    /// 正常背景色
    open var titleNormalBackgroundColor : UIColor = .clear
    /// 选中背景色
    open var titleSelectedBackgroundColor : UIColor = .clear
    
    open var labelWidth : CGFloat = 56
    open var labelHeight : CGFloat = 30
    
    open override func preferredItemModelInstance() -> JXSegmentedBaseItemModel {
        return SYSegmentItemModel()
    }
    
    open override func preferredRefreshItemModel(_ itemModel: JXSegmentedBaseItemModel, at index: Int, selectedIndex: Int) {
        super.preferredRefreshItemModel(itemModel, at: index, selectedIndex: selectedIndex)
        
        guard let itemModel = itemModel as? SYSegmentItemModel else {
            return
        }
        
        itemModel.titleNormalBackgroundColor = titleNormalBackgroundColor
        itemModel.titleSelectedBackgroundColor = titleSelectedBackgroundColor
        if index == selectedIndex {
            itemModel.titleCurrentBackgroundColor = titleSelectedBackgroundColor
        }else {
            itemModel.titleCurrentBackgroundColor = titleNormalBackgroundColor
        }
        
    }

    //MARK: - JXSegmentedViewDataSource
    open override func registerCellClass(in segmentedView: JXSegmentedView) {
        segmentedView.collectionView.register(SYSegmentCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    open override func segmentedView(_ segmentedView: JXSegmentedView, cellForItemAt index: Int) -> JXSegmentedBaseCell {
        let cell = segmentedView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        return cell
    }
    
    open override func refreshItemModel(_ segmentedView: JXSegmentedView, leftItemModel: JXSegmentedBaseItemModel, rightItemModel: JXSegmentedBaseItemModel, percent: CGFloat) {
        
        super.refreshItemModel(segmentedView, leftItemModel: leftItemModel, rightItemModel: rightItemModel, percent: percent)
        guard let leftModel = leftItemModel as? SYSegmentItemModel, let rightModel = rightItemModel as? SYSegmentItemModel else {
            return
        }
        
        leftModel.titleCurrentBackgroundColor = JXSegmentedViewTool.interpolateColor(from: leftModel.titleSelectedBackgroundColor, to: leftModel.titleNormalBackgroundColor, percent: percent)
        rightModel.titleCurrentBackgroundColor = JXSegmentedViewTool.interpolateColor(from:rightModel.titleNormalBackgroundColor , to:rightModel.titleSelectedBackgroundColor, percent: percent)
    }
    
    open override func refreshItemModel(_ segmentedView: JXSegmentedView, currentSelectedItemModel: JXSegmentedBaseItemModel, willSelectedItemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType) {
        
        super.refreshItemModel(segmentedView, currentSelectedItemModel: currentSelectedItemModel, willSelectedItemModel: willSelectedItemModel, selectedType: selectedType)
        
        guard let myCurrentSelectedItemModel = currentSelectedItemModel as? SYSegmentItemModel, let myWillSelectedItemModel = willSelectedItemModel as? SYSegmentItemModel else {
            return
        }
        
        myCurrentSelectedItemModel.titleCurrentBackgroundColor = myCurrentSelectedItemModel.titleNormalBackgroundColor
        myWillSelectedItemModel.titleCurrentBackgroundColor = myWillSelectedItemModel.titleSelectedBackgroundColor
        
    }
}

extension SYSegmentDataSource: Then {}

 
