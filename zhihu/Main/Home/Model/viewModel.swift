//
//  viewModel.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/8.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import UIKit
public struct viewModel {
    public var F = CGRect.zero 
    public var X : CGFloat {
        get { return F.origin.x }
        set(newValue) {
            var tempFrame: CGRect = F
            tempFrame.origin.x    = newValue
            F                     = tempFrame
        }
    }
    public var Y : CGFloat {
        get { return F.origin.y }
        set(newValue) {
            var tempFrame: CGRect = F
            tempFrame.origin.y    = newValue
            F                     = tempFrame
        }
    }
    
    public var W : CGFloat {
        get { return F.size.width }
        set(newValue) {
            var tempFrame: CGRect = F
            tempFrame.size.width    = newValue
            F                     = tempFrame
        }
    }
    
    public var H : CGFloat {
        get { return F.size.height }
        set(newValue) {
            var tempFrame: CGRect = F
            tempFrame.size.height    = newValue
            F                     = tempFrame
        }
    }
    
//    public var Y : CGFloat = 0
//    public var W : CGFloat = 0
//    public var H : CGFloat = 0
    public var url = ""
    public var title = ""
    public var attrTitle = NSAttributedString(string: "")
    
    public var isShow = true
    
    public var maxX : CGFloat {
        get { return X + W }
    }
    public var maxY : CGFloat {
        get {  return Y + H }
    }
    
//    mutating func getFrame(){
//        F.origin.x = X
//        F.origin.y = Y
//        F.size.width = W
//        F.size.height = H
//    }
}

