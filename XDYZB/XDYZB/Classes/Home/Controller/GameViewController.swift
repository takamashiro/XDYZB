//
//  GameViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/10.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 15
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: BaseViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight];
        
        return collectionView
        }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        gameView.backgroundColor = UIColor.orange
        gameView.contentMode = UIViewContentMode.center
        return gameView
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(kGameViewH + kHeaderViewH), width: kScreenW, height: kHeaderViewH)
        topHeaderView.moreBtn.isHidden = true
        topHeaderView.titleLabel.text = "常用"
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        return topHeaderView
    }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
}

// MARK:- 设置UI界面
extension GameViewController {
       override func setupUI() {
        
        contentView = collectionView

        // 1.添加collectionView
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH + kHeaderViewH, left: 0, bottom: 0, right: 0)
        
        // 2.添加GameView
        collectionView.addSubview(gameView)
        collectionView.addSubview(topHeaderView)
        
        super.setupUI()

    }
}

// MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadGameData {
            
            self.collectionView.reloadData()
            
            self.gameView.groups = Array(self.gameVM.games[0..<10])
       
            //3.数据请求完成
            self.loadDataFinished()

        }
    }
}

// MARK:- UICollectionView的数据源&代理
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        // cell.backgroundColor = UIColor.randomColor()
        cell.baseGame = gameVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "全部"
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}
