//
//  RecommendedBaseCell.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/21.
//  Copyright © 2020 chensy. All rights reserved.
//

import UIKit
import Reusable
class RecommendedBaseCell: BaseTableViewCell {
    public var moudleF : ModuleFrame?
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.994)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(getCell().self, forCellWithReuseIdentifier: getCell().reuseIdentifier)
        return collectionView
    }()
    override func configUI() {}
    
    func configData(moudleF:ModuleFrame){
        self.moudleF = moudleF
    }
    /// 注册cell
    func getCell<T>() -> T.Type where T : BaseCollectionViewCell{
        return  BaseCollectionViewCell.self as! T.Type
    }
}

extension RecommendedBaseCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// 设置分区item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.setNumberOfItemsInSection(section: section)
    }
    /// 设置CollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return setCellForItemAt(indexPath: indexPath)
    }
    /// 设置分区内边距
    @objc  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return setSectionEdgeInset(section: section)
    }
    /// item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return setSizeForItem(indexPath: indexPath)
    }
    ///最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return setItemSpacing(section: section)
        
    }
    ///最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return setLineSpacing(section: section)
    }
    /// 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        setTargetContentOffset(targetContentOffset: targetContentOffset)
    }
    /// 调整f滚动结束位置
    @objc func setTargetContentOffset(targetContentOffset: UnsafeMutablePointer<CGPoint>){}
    
    @objc func setNumberOfItemsInSection(section: Int) ->Int{
        return self.moudleF?.contents.count ?? 0
    }
    
    @objc func setCellForItemAt(indexPath: IndexPath) -> UICollectionViewCell{
        let cellId = getCell().reuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCollectionViewCell
        cell.configData(modelF: self.moudleF?.contents[indexPath.row])
        return cell
    }

    @objc func setSectionEdgeInset(section: Int) ->UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 20 , bottom: 0, right: 20);
    }
    
    @objc func setSizeForItem(indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
    /// 设置item间距
    @objc func setItemSpacing(section: Int) -> CGFloat{
        return 10
    }
    /// 设置行间距
    @objc func setLineSpacing(section: Int) -> CGFloat{
        return 10
    }
    
}

class BaseCollectionViewCell: UICollectionViewCell , Reusable{
    var model : Content?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
    }
    func configSubViews(){}
    func configData(modelF:ContentFrame?){}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}