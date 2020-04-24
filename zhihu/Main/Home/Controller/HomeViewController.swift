//
//  HomeViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/1.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView
import Alamofire
import Moya
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
    
    let segmentedView = JXSegmentedView()
    var segmentedDataSource: SYSegmentMixDataSource!
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
        segmentedDataSource = SYSegmentMixDataSource()
        segmentedDataSource.imageSize = CGSize.zero
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titleNormalColor = UIColor.colorRGB(c: 126)
        segmentedDataSource.titleSelectedColor = UIColor.black
        segmentedDataSource.titleNormalFont = UIFont.boldSystemFont(ofSize: 14)
        segmentedDataSource.titles = ["关注", "推荐", "热榜", "抗击肺炎"]
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        view.addSubview(segmentedView)
        
        let indicator = JXSegmentedIndicatorRainbowLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.indicatorColors = [.black, .black, .black, UIColor.themeColor()]
        
        segmentedView.indicators = [indicator]
        
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
        segmentedView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 30)
        listContainerView.frame = CGRect(x: 0, y: 30, width: screenWidth, height: screenHeight - kTabbarH - kNaviH - 30)
        
        
        let lineWidth = 1/UIScreen.main.scale
        let lineLayer = CALayer()
        lineLayer.backgroundColor = UIColor.lineColor().cgColor
        lineLayer.frame = CGRect(x: 0, y: segmentedView.bounds.height - lineWidth, width: segmentedView.bounds.width, height: lineWidth)
        segmentedView.layer.addSublayer(lineLayer)
    }
    @objc func clickLeft(){}
}

extension HomeViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? SYSegmentMixDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 2 {
            return HotViewController()
        }else if index == 3 {
            let vc = BaseWebViewController()
            vc.url = "https://www.zhihu.com/special/19681091"
            return vc
        }
        return AttentionViewController()
    }
}

extension HomeViewController: JXSegmentedViewDelegate {}
