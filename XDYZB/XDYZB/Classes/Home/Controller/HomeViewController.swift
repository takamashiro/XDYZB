//
//  HomeViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/9/26.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {

    
    //MARK:- 懒加载属性
    internal lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    internal lazy var pageContentView : PageContentView = {[weak self] in
        //确定内容的frame
        let kContentH = kScreenH - (kStatusBarH + kNavigationBarH + kTitleViewH) - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: kContentH)
        //确定所以的自控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        for _ in 0..<1 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
        
    }()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI();
       
        
    }


}

//MARK: -设置UI界面
extension HomeViewController {

    public func setupUI() {
        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //1.设置导航栏
        setupNavigationBar()
        //2.添加TitleView
        view.addSubview(pageTitleView)
        //3.添加ContentView
        view.addSubview(pageContentView)
        
        pageContentView.backgroundColor = UIColor.purple
    }
    
    fileprivate func setupNavigationBar() {
        

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", target: self, action: #selector(self.leftItemClick))
        
        
        let size = CGSize(width: 40, height: 40)
    
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size,target:self,action:#selector(self.historyItemClick))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked",size: size,target:self,action:#selector(self.searchItemClick))
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click",size: size,target:self,action:#selector(self.qrCodeItemClick))
       
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
        
    }
}

//MARK: - PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}

//MARK:- PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
       pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK:- selector
extension HomeViewController {
    func leftItemClick() {
        print("leftItemClick")
    }
    
    func historyItemClick() {
        print("historyItemClick")
    }
    
    func searchItemClick() {
        print("searchItemClick")
    }
    
    func qrCodeItemClick() {
        print("qrCodeItemClick")
    }
}
