//
//  UIKit+Extension.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/3.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView {
    func set_image(_ string : String?){
        self.kf.setImage(with: URL(string: string ?? ""))
    }
}

extension String {
    
    static func checkIsChinese(string: String) -> Bool {
        
        for (_, value) in string.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    func urldecodeString () -> String {
        if !String.checkIsChinese(string: self){
            return self
        }
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    /// 获取字符串 size
    /// - Parameters:
    ///   - font: 字体
    ///   - size: size
    ///   - lineSpacing: 行间距 默认0 不设置段落样式
    ///   - isBold: 是否粗体 默认否
    func sizeWithRect(fontSize:CGFloat , size:CGSize , lineSpacing : CGFloat = 0 , isBold : Bool = false ) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = .left
        let font : UIFont = isBold ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize)
        var attributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font:font]
        if lineSpacing != 0 {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        return (self as NSString).boundingRect(with:size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
    }
}

//MARK: -定义button相对label的位置
enum ButtonEdgeInsetsStyle {
    case Top
    case Left
    case Right
    case Bottom
}

extension UIButton {
    
    func layoutButton(style: ButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .Top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
            break;
            
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2, bottom: 0, right: imageTitleSpace)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
            break;
            
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-imageTitleSpace/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}
