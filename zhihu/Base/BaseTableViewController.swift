//
//  BaseTableViewController.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/12.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import Then
import MJRefresh
import SnapKit
import Reusable
class BaseTableViewController: BaseViewController {
    var dataArr : [ModelFrame] = []
    let tableView = UITableView()
    var isEnd = false
    override func configUI() {
        configTableView()
        loadData(isUp: true, isScrol: false)
    }
    
    func configTableView(){
        registerCell() // 设置cell
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
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
    func loadData(isUp:Bool ,isScrol:Bool = true){}
}

extension BaseTableViewController :UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setTableViewCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataArr[indexPath.row]
        return model.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = getLinkUrl(didSelectedRowAt: indexPath)
        if url.count > 0 {
            let webVC = BaseWebViewController()
            webVC.url = url
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
    /// 设置cell
    @objc func setTableViewCell(tableView:UITableView,indexPath:IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }
    /// 点击事件
    @objc func getLinkUrl(didSelectedRowAt indexPath:IndexPath) -> String{
        return ""
    }
    /// 注册Cell
    @objc func registerCell(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
}

