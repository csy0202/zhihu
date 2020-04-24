//
//  HotListViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/10.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import JXSegmentedView

class HotListViewController: BaseTableViewController {
    var topicList : TopicList?
    var path: String = ""

    override func loadData(isUp:Bool ,isScrol:Bool = true){
        var parame:[String:Any] = [:]
        parame["reverse_order"] = 0
        parame["limit"] = 10
        Network.request(api: Api.hotList(path: path), parame: parame, success: { (result) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            self.topicList = TopicList.deserialize(from: result)

            var modelArr : [TopicFrame] = []
            for model in self.topicList!.data{
                let modelF = TopicFrame.init(model: model)
                modelArr.append(modelF)
            }
            self.dataArr = isUp ? modelArr : self.dataArr + modelArr
            self.tableView.reloadData()

            self.isEnd = self.topicList?.paging?.is_end ?? false
            if self.isEnd {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
        }) { (error) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
        }
    }
}
//MARK: - tableView 相关
extension HotListViewController {
    /// 注册cell
    override func registerCell() {
        tableView.register(cellType: HotCell.self)
    }
    /// 设置cell
    override func setTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell : HotCell  =  tableView.dequeueReusableCell(for: indexPath)
        cell.model = dataArr[indexPath.row] as? TopicFrame
        cell.num = indexPath.row
        return cell
    }
    /// cell点击事件
    override func getLinkUrl(didSelectedRowAt indexPath: IndexPath) -> String {
        let modelF = dataArr[indexPath.row] as? TopicFrame
        
        guard var url = modelF?.model?.target?.url else {
            return ""
        }
        url = url.replacingOccurrences(of: "api", with: "www")
        url = url.replacingOccurrences(of: "questions", with: "question")
        return  url
    }
}

extension HotListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
