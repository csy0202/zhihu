//
//  AttentionViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/4.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView
class AttentionViewController: BaseTableViewController {
    var attentionModel : AttentionModel?
    var upPara: [String:Any] = [:]
    var downPara: [String:Any] = [:]
    
    override func loadData(isUp:Bool ,isScrol:Bool = true){
        var parame:[String:Any] = [:]
        if isScrol {
            if isUp {
                for (key,value) in upPara {
                    parame[key] = value
                }
            }else{
                for (key,value) in downPara {
                    parame[key] = value
                }
            }
        }else{
            parame["limit"] = 10
            parame["start_type"] = "cold"
        }
        parame["feed_type"] = "timeline"
        parame["reverse_order"] = 0
        Network.request(api: Api.moments, parame: parame, success: { (result) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            self.attentionModel = AttentionModel.deserialize(from: result)
            
            var modelArr : [AttentionFrame] = []
            for model in self.attentionModel!.data{
                let modelF = AttentionFrame.init(model: model)
                modelArr.append(modelF)
            }
            self.dataArr = isUp ? modelArr : self.dataArr + modelArr
            self.tableView.reloadData()
            
            self.isEnd = self.attentionModel?.paging?.is_end ?? false
            if self.isEnd {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                self.downPara = String.getParameter(url: self.attentionModel?.paging?.next)
            }
            self.upPara = String.getParameter(url: self.attentionModel?.paging?.previous)
        }) { (error) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
        }
    }
}

//MARK: - tableView 相关
extension AttentionViewController {
    /// 注册cell
    override func registerCell() {
        tableView.register(cellType: AttentionCell.self)
    }
    /// 设置cell
    override func setTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell : AttentionCell  = tableView.dequeueReusableCell(for: indexPath)
        cell.model = dataArr[indexPath.row] as? AttentionFrame
        return cell
    }
    /// cell点击事件
    override func getLinkUrl(didSelectedRowAt indexPath: IndexPath) -> String {
        let modelF = dataArr[indexPath.row] as? AttentionFrame
        return modelF?.model?.target?.url ?? ""
    }
}

extension AttentionViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView { return view }
}

