//
//  FunToPlayViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/11.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit
import MJRefresh

private let kTopMargin : CGFloat = 8

class FunToPlayViewController: BaseAnchorViewController {
    //MARK: 懒加载ViewModel对象
    fileprivate lazy var funToPlayVM : FunToPlayViewModel = FunToPlayViewModel()
    
}

extension FunToPlayViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        
        header.ignoredScrollViewContentInsetTop = kTopMargin
        collectionView.mj_header = MJRefreshGifHeader(refreshingBlock: {
            self.funToPlayVM.isloadMore = false
            self.funToPlayVM.currentPage = 0
            self.loadData()
        })
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.funToPlayVM.isloadMore = true
            self.funToPlayVM.currentPage += 1
            self.loadData()
        })
    }
}

extension FunToPlayViewController {
    override func loadData() {
        //1.给父类中的ViewModel进行赋值
        baseVM = funToPlayVM
        
        //请求数据
        funToPlayVM.loadFunToPlayData {
            self.collectionView.reloadData()
            
            //数据请求完成
            self.loadDataFinished()

        }
        
    }
}
