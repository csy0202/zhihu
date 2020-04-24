//
//  MemberViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/16.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView
class MemberViewController: BaseViewController {
    let segmentedView = JXSegmentedView()
    var segmentedDataSource: JXSegmentedTitleDataSource!
    var headerModel : VipHeaderModel?
    
    var naviView = VipHeaderView()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func configUI() {
        naviView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 70 + kStatusBarH)
        view.addSubview(naviView)
        configPageView()
        configSubViews()
        getVipTitleLists()
    }
    func configPageView(){
        
        
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titleNormalColor = UIColor.colorRGB(c: 151)
        segmentedDataSource.titleSelectedColor = UIColor.colorRGB(r: 206, g: 154, b: 79)
        segmentedDataSource.titleNormalFont = UIFont.boldSystemFont(ofSize: 14)
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        view.addSubview(segmentedView)
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.indicatorColor =  UIColor.colorRGB(r: 206, g: 154, b: 79)
        
        segmentedView.indicators = [indicator]
        
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
        segmentedView.frame = CGRect(x: 0, y: naviView.frame.maxY, width: screenWidth, height: 35)
        listContainerView.frame = CGRect(x: 0, y: segmentedView.frame.maxY, width: screenWidth, height: screenHeight - kTabbarH -  segmentedView.frame.maxY)

        
        let lineWidth = 1/UIScreen.main.scale
        let lineLayer = CALayer()
        lineLayer.backgroundColor = UIColor.lineColor().cgColor
        lineLayer.frame = CGRect(x: 0, y: segmentedView.bounds.height - lineWidth, width: segmentedView.bounds.width, height: lineWidth)
        segmentedView.layer.addSublayer(lineLayer)
    }
    func configSubViews(){
        
    }
    
    @objc func clickLeft(){}
    
     func getVipTitleLists() {
        Network.request(api: Api.marketHeader, parame: [:], success: { (result) in
            self.headerModel = VipHeaderModel.deserialize(from: result)
            self.getTitls()
            self.naviView.model = self.headerModel
        }) { (error) in
            
        }
    }
    
    func getTitls(){
        var titles = [String]()
        for item in headerModel!.sub_webs  {
            titles.append(item.title)
        }
        segmentedDataSource.titles = titles
        segmentedView.dataSource = segmentedDataSource
        segmentedDataSource.reloadData(selectedIndex: 0)
        segmentedView.reloadData()
    }
    
}

extension MemberViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedTitleDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {

        return MemberListViewController()
    }
}

extension MemberViewController: JXSegmentedViewDelegate {}
