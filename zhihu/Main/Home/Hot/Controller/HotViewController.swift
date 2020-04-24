//
//  HotViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/4.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView
import Then
class HotViewController: BaseViewController {
    var hotList : HotTitleModel?
    var segmentedDataSource = SYSegmentDataSource().then {
        $0.isTitleColorGradientEnabled = true
        $0.isItemSpacingAverageEnabled = false
        $0.itemContentWidth = 56
        $0.titleNormalBackgroundColor = UIColor.colorRGB(c: 246)
        $0.titleSelectedBackgroundColor = UIColor.colorRGB(r: 235, g: 245, b: 255)
        $0.titleNormalColor = UIColor.colorRGB(c: 126)
        $0.titleSelectedColor = UIColor.colorRGB(r: 49, g: 149, b: 254)
        $0.titleNormalFont = UIFont.systemFont(ofSize: 13)
    }
    
    let segmentedView = JXSegmentedView()
    var titlse: [String] = []
    lazy var listContainerView: JXSegmentedListContainerView! = {
        let l = JXSegmentedListContainerView(dataSource: self)
        l.scrollView.isScrollEnabled = false
        return l
    }()
    override func configUI() {
        configPageView()
        getHotLists()
    }
    func configPageView(){
        
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        view.addSubview(segmentedView)

        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false
        
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
        segmentedView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 50)
        listContainerView.frame = CGRect(x: 0, y: 50, width: screenWidth, height: screenHeight - kTabbarH - kNaviH - 80)
    }
     func getHotLists() {
        Network.request(api: Api.hotList(), parame: [:], success: { (result) in
            self.hotList = HotTitleModel.deserialize(from: result)
            self.getTitls()
        }) { (error) in
            
        }
    }
    
    func getTitls(){
        
        for item in hotList!.data  {
            titlse.append(item.name)
        }
        segmentedDataSource.titles = titlse
        segmentedView.dataSource = segmentedDataSource
        segmentedDataSource.reloadData(selectedIndex: 0)
        segmentedView.reloadData()
    }
}

extension HotViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {

//        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension HotViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedTitleDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = HotListViewController()
//        for (index,item) in hotList!.data  {
//
//            titlse.append(item.name)
//        }
        vc.path = hotList?.data[index].identifier ?? "total"
        return vc
    }
}

extension HotViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
