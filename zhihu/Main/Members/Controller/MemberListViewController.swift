//
//  MemberListViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/17.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView

class MemberListViewController: BaseTableViewController {
    private var bannerView: RecommendedHeaderView = {
        let view = RecommendedHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 203)
        return view
    }()
    
    private var footerView : UIImageView = {
        let footView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 153))
        footView.image = UIImage(named: "footView")
        footView.backgroundColor = UIColor.lineColor()
        footView.contentMode = .center
        return footView
    }()
    
    var bannerModel:VipBannerModel?
    var moduleList : VipModuleList?
    var moreList = [VipMoreCellFrame]()
    var upPara: [String:Any] = [:]
    var downPara: [String:Any] = [:]
    var isLoad = false
    
    override func loadData(isUp: Bool, isScrol: Bool = true) {
        if isUp { moreList.removeAll() }
        if (!isScrol) {
            getBannerData()
            getMoudleListData()
            return
        }
        
        // 如果正在请求数据 则不重新请求
        if isLoad { return }
        isLoad = true
        
        // 请求更多数据
        var parame:[String:Any] = [:]
        if moreList.count == 0 {
            parame["limit"] = 10
            parame["offset"] = 0
        }else{
            for (key,value) in downPara {
                parame[key] = value
            }
        }
        parame["dataType"] = "new"
        Network.request(api: Api.marketRecommendationsInterest, parame: parame, success: { (result) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            let moreListArr = VipMoreListModel.deserialize(from: result)
            
            var modelArr : [VipMoreCellFrame] = []
            for model in moreListArr!.data{
                let modelF = VipMoreCellFrame.init(model: model)
                modelArr.append(modelF)
            }
            self.moreList = isUp ? modelArr : self.moreList + modelArr
            self.tableView.reloadData()
            
            self.isEnd = moreListArr?.paging?.is_end ?? false
            if self.isEnd {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                self.tableView.tableFooterView = self.footerView
            }else{
                self.downPara = String.getParameter(url: moreListArr?.paging?.next)
                self.tableView.tableFooterView = UIView()
            }
            self.upPara = String.getParameter(url: moreListArr?.paging?.previous)
            self.isLoad = false
        }) { (error) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            self.isLoad = false
        }
    }
    
    /// 获取banner数据
    func getBannerData(){
        Network.request(api: Api.marketVipRecommendHeader, success: { (result) in
            self.bannerModel = VipBannerModel.deserialize(from: result)
            self.bannerView.bannerModel = self.bannerModel
        }) { _ in }
    }
    
    /// 获取banner数据
    func getMoudleListData(){
        Network.request(api: Api.marketVipRecommendCategories, success: { (result) in
            self.moduleList = VipModuleList.deserialize(from: result)
            var modelArr : [ModuleFrame] = []
            for model in self.moduleList!.module_list{
                let modelF = ModuleFrame.init(model: model)
                modelArr.append(modelF)
            }
            self.dataArr = modelArr
            self.tableView.reloadData()
        }) { _ in }
    }
    // 开始加载更多数据
    func getMoreData(indexPath: IndexPath){
        if isLoad { return }
        if indexPath.section == 0 && moreList.count == 0 {
            if dataArr.count - indexPath.row <= 5 {
                loadData(isUp: false)
            }
        }else if indexPath.section == 1 {
            if moreList.count - indexPath.row <= 8 && !isEnd{
                loadData(isUp: false)
            }
        }
    }
    
}

//MARK: - tableView 相关
extension MemberListViewController {
    /// 注册cell
    override func registerCell() {
        tableView.tableHeaderView = bannerView
        tableView.register(cellType: RecommendedBaseCell.self)
        tableView.register(cellType: RecommendedType2.self)
        tableView.register(cellType: RecommendedType6.self)
        tableView.register(cellType: RecommendedType7.self)
        tableView.register(cellType: RecommendedType12.self)
        tableView.register(cellType: RecommendedType14.self)
        tableView.register(cellType: RecommendedType21.self)
        tableView.register(cellType: RecommendedType22.self)
        tableView.register(cellType: RecommendedType24.self)
        tableView.register(cellType: RecommendedType20.self)
        tableView.register(cellType: RecommendedMoreCell.self)
    }
    /// 设置cell
    override func setTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        getMoreData(indexPath: indexPath)
        if indexPath.section == 0 {
            let moduleF = dataArr[indexPath.row] as! ModuleFrame
            let cell = tableView.dequeueReusableCell(withIdentifier: moduleF.cellId, for: indexPath) as! RecommendedBaseCell
            cell.configData(moudleF: moduleF)
            cell.showBottomLine = indexPath.row % 2 == 0 || indexPath.row == dataArr.count - 1
            cell.textLabel?.text = "\(moduleF.model!.type)"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedMoreCell", for: indexPath) as! RecommendedMoreCell
            cell.modelF = moreList[indexPath.row]
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? dataArr.count : moreList.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let model = dataArr[indexPath.row]
            let showLine = indexPath.row % 2 == 0 || indexPath.row == dataArr.count - 1
            let bottomH : CGFloat = showLine ? 8 : 38
            return model.height + bottomH
        }else{
            return 113
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerview = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
            headerview.backgroundColor = .white
            let titleL = UILabel(frame: CGRect(x: 20, y: 25, width: 250, height: 20))
            titleL.textColor = .black
            titleL.font = UIFont.boldSystemFont(ofSize: 17)
            titleL.text = "发现更多"
            headerview.addSubview(titleL)
            return headerview
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 60 : 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 60
        if(scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0)
        }
        
    }
}

extension MemberListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
