//
//  UIcolor+Extension.swift
//  WeiB
//
//  Created by 陈淑洋 on 2018/11/16.
//  Copyright © 2018 chensy. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
   class func colorHex(value:UInt32, alpha:CGFloat = 1.0) -> UIColor
    {
        return UIColor(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
   class func colorRGB(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1.0) -> UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/1.0)
    }
    
    class var randomColor:UIColor{
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
