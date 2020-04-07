//
//  AttentionViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/4.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import Then
import MJRefresh
import SnapKit

class AttentionViewController: BaseViewController {
    
    let tableView = UITableView()
    var dataArr : [AttentionFrame] = []
    var attentionModel : AttentionModel?
    override func configUI() {
        super.configUI()
        configTableView()
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configTableView(){
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: AttentionCell.self)
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.clear
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadUpData))
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadDropData))
        
        view.addSubview(tableView)
    }
    
    @objc func loadUpData(){
//        https://api.zhihu.com/moments?feed_type=timeline&limit=10&reverse_order=0&scroll=up
        var parame:[String:Any] = [:]
//        parame["action"] = "up"
//        parame["session_id"] = "6c8e00e29e8630456c011865d620317b"
        parame["feed_type"] = "timeline"
        parame["limit"] = 10
        parame["reverse_order"] = 0
        parame["scroll"] = "up"
        
        NetProvider.request(target: ZHApi.moments(parameDic: parame), success: { (result) in
            self.tableView.mj_header?.endRefreshing()
            self.attentionModel = AttentionModel.deserialize(from: result)
            for model in self.attentionModel!.data{
                let modelF = AttentionFrame.init(model: model)
                self.dataArr.append(modelF)
            }
//            self.dataArr = self.attentionModel?.data ?? []
            self.tableView.reloadData()
        }) { (error) in
            self.tableView.mj_header?.endRefreshing()
        }
    }
    @objc func loadDropData(){
        self.tableView.mj_footer?.endRefreshing()
    }
}

extension AttentionViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AttentionCell = tableView.dequeueReusableCell(for: indexPath)
        cell.model = dataArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataArr[indexPath.row]
        return model.height
    }
}
