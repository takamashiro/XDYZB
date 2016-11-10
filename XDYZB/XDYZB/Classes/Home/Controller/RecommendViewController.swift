//
//  RecommendViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/9/27.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit
import MJRefresh

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    //MARK: -懒加载属性
    fileprivate lazy var recommandViewModel : RecommandViewModel = RecommandViewModel()
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
   
}

extension RecommendViewController {
    
    override func setupUI() {
        
        // 1.先调用super.setupUI()
        super.setupUI()

        //2.将cycleView添加到CollectionView中
        collectionView.addSubview(cycleView)
        // 3.将gameView添加collectionView中
        collectionView.addSubview(gameView)
        collectionView.mj_header = header
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        header.ignoredScrollViewContentInsetTop = kCycleViewH + kGameViewH
        collectionView.mj_header = header
    
     }

}


//MARK:- 请求数据
extension RecommendViewController {
    override func loadData() {
  
        // 0.给父类中的ViewModel进行赋值
        baseVM = recommandViewModel
        
        recommandViewModel.requestData() {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var tempGroups = self.recommandViewModel.anchorGroups
            tempGroups.removeFirst()
            tempGroups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            tempGroups.append(moreGroup)
            self.gameView.groups = tempGroups
            
            //3.数据请求完成
            self.loadDataFinished()
        }
        // 2.请求轮播数据
        recommandViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommandViewModel.cycleModels
        }
        
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommandViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
