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
    public var X : CGFloat = 0
    public var Y : CGFloat = 0
    public var W : CGFloat = 0
    public var H : CGFloat = 0
    public var url = ""
    public var title = ""
    public var attrTitle = NSAttributedString(string: "")
    public var F = CGRect.zero
    public var isShow = true
    
    public var maxX : CGFloat {
        get { return self.X + self.W }
    }
    public var maxY : CGFloat {
        get {  return Y + H }
    }
    
    mutating func getFrame(){
        F.origin.x = X
        F.origin.y = Y
        F.size.width = W
        F.size.height = H
    }
}

