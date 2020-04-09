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
    var upPara: [String:Any] = [:]
    var downPara: [String:Any] = [:]
    var isEnd = false
    override func configUI() {
        super.configUI()
        configTableView()
        loadData(isUp: true, isScrol: false)
    }
    
    func configTableView(){
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: AttentionCell.self)
        tableView.backgroundColor = UIColor.clear
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadUpData))
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadDropData))
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    @objc func loadUpData(){
        loadData(isUp: true)
    }
    @objc func loadDropData(){
        loadData(isUp: false)
    }
    @objc func loadData(isUp:Bool ,isScrol:Bool = true){

//https://api.zhihu.com/moments/recommend?action=down&offset=8&page_num=1&session_id=6326b565fd2826f61cac3bd1bdad6dd7&feed_type=all&reverse_order=0
        //        https://api.zhihu.com/moments?feed_type=timeline&limit=10&reverse_order=0&scroll=up
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
            parame["feed_type"] = "timeline"
            parame["reverse_order"] = 0
        }else{
            parame["feed_type"] = "timeline"
            parame["reverse_order"] = 0
            parame["limit"] = 10
            parame["start_type"] = "cold"
        }
        
        
        NetProvider.request(target: ZHApi.moments(parameDic: parame), success: { (result) in
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
            self.getLastRead()
        }) { (error) in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
        }
    }

    func getLastRead() {
        NetProvider.request(target: ZHApi.momentsLastread, success: { (result) in
            
        }) { (error) in
            
        }
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
