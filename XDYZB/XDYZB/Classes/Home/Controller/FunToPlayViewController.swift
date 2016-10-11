//
//  FunToPlayViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/11.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4

private let kFunToPlayCellID = "kFunToPlayCellID"

class FunToPlayViewController: UIViewController {
        // MARK: 懒加载属性
        fileprivate lazy var FunToPlayVM : FunToPlayViewModel = FunToPlayViewModel()
        fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
            // 1.创建布局
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = kItemMargin
            layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
    
            // 2.创建UICollectionView
            let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColor.white
            
            collectionView.dataSource = self
            collectionView.delegate = self
            
            collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
            collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kFunToPlayCellID)
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
extension FunToPlayViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension FunToPlayViewController {
    fileprivate func loadData() {
        FunToPlayVM.loadFunToPlayData {
            self.collectionView.reloadData()

        }
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension FunToPlayViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return FunToPlayVM.FunToPlays.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出模型对象

        let anchor = FunToPlayVM.FunToPlays[indexPath.row]

        // 2.定义Cell
        var cell : CollectionBaseCell!

        // 3.取出Cell

        cell = collectionView.dequeueReusableCell(withReuseIdentifier: kFunToPlayCellID, for: indexPath) as! CollectionNormalCell

        // 4.将模型赋值给Cell
        cell.anchor = anchor

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
