//
//  SYSegmentItemModel.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/14.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView
open class SYSegmentItemModel: JXSegmentedTitleItemModel {
    open var padding : UIEdgeInsets = UIEdgeInsets.zero
    open var cornerRadius : CGFloat = 0
    open var titleCurrentBackgroundColor : UIColor = .clear
    open var titleNormalBackgroundColor : UIColor = .clear
    open var titleSelectedBackgroundColor : UIColor = .clear
    open var labelWidth : CGFloat = 56
    open var labelHeight : CGFloat = 30
}
