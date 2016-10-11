//
//  EntertainmentViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/11.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let kEntertainmentCellID = "kEntertainmentCellID"
private let kEntertainmentHeaderViewID = "kEntertainmentHeaderViewID"

class EntertainmentViewController: UIViewController {

    // MARK: 懒加载属性
    fileprivate lazy var entertainmentVM : EntertainmentViewModel = EntertainmentViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kEntertainmentCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kEntertainmentHeaderViewID)
        
        return collectionView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }

}

// MARK:- 设置UI界面
extension EntertainmentViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension EntertainmentViewController {
    fileprivate func loadData() {
        entertainmentVM.loadEntertainmentData { 
            self.collectionView.reloadData()

        }
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension EntertainmentViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return entertainmentVM.Entertainments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = entertainmentVM.Entertainments[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出模型对象
        let group = entertainmentVM.Entertainments[(indexPath as NSIndexPath).section]
        let anchor = group.anchors[(indexPath as NSIndexPath).item]
        
        // 2.定义Cell
        var cell : CollectionBaseCell!
        
        // 3.取出Cell
        
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEntertainmentCellID, for: indexPath) as! CollectionNormalCell
        
        // 4.将模型赋值给Cell
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kEntertainmentHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.取出模型
        headerView.group = entertainmentVM.Entertainments[(indexPath as NSIndexPath).section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
