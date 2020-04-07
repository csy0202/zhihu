//
//  HomeViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/1.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
//import Then
//import MJRefresh
//import SnapKit
import DNSPageView
class HomeViewController: BaseViewController {

    let titleBtn = UIButton().then {
        $0.size = CGSize(width: 245, height: 35)
        $0.backgroundColor = UIColor.colorHex(value: 0xF0F0F0)
        $0.setTitle("经典的有哪些？", for: .normal);
        $0.setTitleColor(UIColor.colorHex(value: 0x898989), for: .normal)
        $0.setImage(UIImage(named: "search"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.layer.cornerRadius = 4.0
        $0.layer.masksToBounds = true
    }
    override func configUI() {
        configNavi()
        configPageView()
        
    }
    /// 导航栏配置
    func configNavi(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "tv"), style: .done, target: self, action: #selector(clickLeft))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "tv"), style: .done, target: self, action: #selector(clickLeft))
        navigationItem.titleView = titleBtn
    }
    func configPageView(){
        let style = PageStyle()
        style.isTitleViewScrollEnabled = true
        style.titleMargin = 50
        style.titleColor = UIColor.colorRGB(r: 155, g: 155, b: 155)
        style.titleSelectedColor = UIColor.colorRGB(r: 26, g: 26, b: 26)
        
        style.titleViewHeight = 30
        style.isShowBottomLine = true
        style.bottomLineHeight = 3
        style.bottomLineColor = UIColor.colorRGB(r: 26, g: 26, b: 26)
        //               style.isTitleScaleEnabled = true
        
        // 设置标题内容
        let titles = ["关注", "推荐", "热榜", "抗击肺炎"]
        
        // 创建每一页对应的controller
        let childViewControllers: [UIViewController] = titles.map { _ -> UIViewController in
            let controller = AttentionViewController()
            addChild(controller)
            return controller
        }
        
        let y:CGFloat = 0
        //        UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
        let size = UIScreen.main.bounds.size
        
        // 创建对应的PageView，并设置它的frame
        // titleView和contentView会连在一起
        let pageView = PageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height - kNaviH - kTabbarH), style: style, titles: titles, childViewControllers: childViewControllers)
        view.addSubview(pageView)
    }
    @objc func clickLeft(){
        
    }
}
