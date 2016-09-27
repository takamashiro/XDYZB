//
//  MainViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/9/26.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //通过storyboard获取控制器
        
        addChildVC(storyName: "Home");
        addChildVC(storyName: "Live");
        addChildVC(storyName: "Follow");
        addChildVC(storyName: "Profile");
    }

    private func addChildVC(storyName:String) {
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        addChildViewController(childVC!);
        
    }

}
