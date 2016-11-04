//
//  BaseAnchorViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/12.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit
import MJRefresh

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class BaseAnchorViewController: BaseViewController {
    
    
    // MARK: 定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH) //header高度
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        }()
    
    lazy var header : MJRefreshGifHeader = {
        let header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(BaseAnchorViewController.loadData))
        
        header?.setImages([UIImage(named:"dyla_img_mj_stateIdle_64x66_")!], for: MJRefreshState.idle)
        header?.setImages([UIImage(named:"dyla_img_mj_statePulling_64x66_")!], for: MJRefreshState.pulling)
    header?.setImages([UIImage(named:"dyla_img_mj_stateRefreshing_01_135x66_")!,UIImage(named:"dyla_img_mj_stateRefreshing_02_135x66_")!,UIImage(named:"dyla_img_mj_stateRefreshing_03_135x66_")!,UIImage(named:"dyla_img_mj_stateRefreshing_04_135x66_")!],duration: 0.5,for:
         MJRefreshState.refreshing)
        header?.stateLabel.isHidden = false
        header?.lastUpdatedTimeLabel.isHidden = false
        
        return header!
    }()

        // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
        
    }
}



// MARK:- 设置UI界面
extension BaseAnchorViewController {
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
        
        

    }
    
   
}

// MARK:- 请求数据
extension BaseAnchorViewController {
    func loadData() {

    }
    
    override func loadDataFinished() {
        super.loadDataFinished()
        collectionView.mj_header.endRefreshing()
    }
}


// MARK:- 遵守UICollectionView的数据源协议
extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        // 2.给cell设置数据
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        if indexPath.section == 0 {
            let group = baseVM.anchorGroups[indexPath.section]
            group.icon_name = "home_header_hot"
            headerView.group = group
        } else {
            headerView.group = baseVM.anchorGroups[indexPath.section]
        }
        return headerView
    }
}

// MARK:- 遵守UICollectionView的代理协议
extension BaseAnchorViewController :  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //取出对应的主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        //判断是秀场房间还是普通房间
        anchor.isVertical == 0 ? pushNormalRoomVC() : presentShowRoomVC()
    }
    
    private func presentShowRoomVC() {
        let showRoomVC = RoomShowViewController()
        
        present(showRoomVC, animated: true, completion: nil)
    }
    
    private func pushNormalRoomVC() {
        let normalRoomVC = RoomNormalViewController()
        
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
    
    private func Player() {
    /*
    http://capi.douyucdn.cn/api/v1/room/71415?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=1478089800&auth=9f4dd28b236427303383c979f2bed266
     auth以前Android分析
     auth值：
     md5(room/522387/?aid=android&clientsys=android&time="+1231)
     不知道auth怎么加密的  无法得到最新auth算法
     暂时无法做，这里打算用其他平台直播流，仅测试直播流播放
    */
    }
}
