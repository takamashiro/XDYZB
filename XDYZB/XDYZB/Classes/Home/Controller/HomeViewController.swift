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

    lazy var window : UIWindow = UIWindow()
    
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
        childVCs.append(FunToPlayViewController())
       //以后要视图控制器懒加载
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
        
    }()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI();
        let x = UIScreen.main.bounds.size.width - 44 - 10
        let y = UIScreen.main.bounds.size.height - 64 - 44
        let livingBtn = UIButton(frame: CGRect(x: x, y: y, width: 44, height: 44))
        
        livingBtn.setImage(UIImage(named:"home_play_btn_44x44_"), for: UIControlState.normal)
        livingBtn.addTarget(self, action: #selector(presentLiveVC), for: UIControlEvents.touchUpInside)
        UIApplication.shared.windows.first!.addSubview(livingBtn)
    }

    func presentLiveVC() {
        present(LiveMySelfViewController(), animated: true, completion: nil)
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
       
        
        navigationItem.rightBarButtonItems = [searchItem,qrcodeItem,historyItem];
        
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
    
    
    func qrCodeItemClick() {
        //1.创建二维码控制器
        let sb = UIStoryboard(name: "QRCode", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        //2.弹出二维码控制器
        present(vc, animated: true, completion: nil)
    }
}

extension HomeViewController:PYSearchViewControllerDelegate {
    func searchItemClick() {
        // 1.创建热门搜索
        //let hotSeaches = ["Java", "Python", "Objective-C", "Swift", "C", "C++", "PHP", "C#", "Perl", "Go", "JavaScript", "R", "Ruby", "MATLAB"]
        // 2. 创建控制器


        let searchViewController = PYSearchViewController.init(hotSearches: nil, searchBarPlaceholder: "搜索房间ID、主播名称") { (searchViewController, searchBar, searchText) in
            searchViewController?.navigationController?.pushViewController(SearchResultViewController(), animated: true)
        }
        searchViewController?.hotSearchStyle = PYHotSearchStyle.arcBorderTag
        searchViewController?.searchHistoryStyle = PYSearchHistoryStyle.normalTag
        searchViewController?.delegate = self
     
        let nav = UINavigationController.init(rootViewController: searchViewController!)
        
        nav.navigationBar.tintColor = UIColor.orange

        present(nav, animated: false, completion: nil)
        
    }
    
    /** 点击(开始)搜索时调用 */
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWithsearchBar searchBar: UISearchBar!, searchText: String!) {
         searchViewController?.navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
    /** 搜索框文本变化时，显示的搜索建议通过searchViewController的searchSuggestions赋值即可 */
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange seachBar: UISearchBar!, searchText: String!) {
        if  searchText.characters.count > 0{ // 与搜索条件再搜索
             // 根据条件发送查询（这里模拟搜索）
           delay(0.25, closure: { 
            // 搜素完毕
            // 显示建议搜索结果
            var searchSuggestionsM  = [String]()
            
            for i in 0...5 {
               let searchSuggestion = String(format: "搜索建议 %d", i)
                searchSuggestionsM.append(searchSuggestion)
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
           })
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    /** 点击取消时调用 */
    func didClickCancel(_ searchViewController: PYSearchViewController!) {
        
    }

}
