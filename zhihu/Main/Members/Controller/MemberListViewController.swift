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
        view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 195)
        return view
    }()
    
    var bannerModel:VipBannerModel?
    var moduleList : VipModuleList?
    override func configUI() {
        super.configUI()
        getBannerData()
    }
    
    /// 获取banner数据
    func getBannerData(){
        Network.request(api: Api.marketVipRecommendHeader, success: { (result) in
            self.bannerModel = VipBannerModel.deserialize(from: result)
            self.bannerView.bannerModel = self.bannerModel
        }) { (error) in
            
        }
    }
    
    override func loadData(isUp: Bool, isScrol: Bool = true) {
        Network.request(api: Api.marketVipRecommendCategories, success: { (result) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            self.moduleList = VipModuleList.deserialize(from: result)
            var modelArr : [ModuleFrame] = []
            for model in self.moduleList!.module_list{
                let modelF = ModuleFrame.init(model: model)
                modelArr.append(modelF)
            }
            self.dataArr = modelArr
            self.tableView.reloadData()
        }) { (error) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
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
        tableView.register(cellType: RecommendedType12.self)
        tableView.register(cellType: RecommendedType14.self)
        tableView.register(cellType: RecommendedType22.self)
        tableView.register(cellType: RecommendedType24.self)
        tableView.register(cellType: RecommendedType20.self)
    }
    /// 设置cell
    override func setTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let moduleF = dataArr[indexPath.row] as! ModuleFrame
        let cell = tableView.dequeueReusableCell(withIdentifier: moduleF.cellId, for: indexPath) as! RecommendedBaseCell
        cell.configData(moudleF: moduleF)
        cell.textLabel?.text = "\(moduleF.model?.type)"
        return cell
    }
}

extension MemberListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
