//
//  ButtonL.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/7.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit

class ButtonL: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .left
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        setTitleColor(UIColor.colorHex(value: 0x8d8d8d), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 25, y: 0, width: contentRect.size.width - 25, height: contentRect.size.height)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 2, y: 0, width: 18, height: contentRect.size.height)
    }
    
    
    
}
