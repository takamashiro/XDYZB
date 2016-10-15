//
//  CustomNavigationViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/15.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1.获取系统的Pop手势
        guard let systemGesture = interactivePopGestureRecognizer else {return}
        
        //2.获取手势添加到的view中
        guard let gestureView = systemGesture.view else {return}
        
        //3.获取target/action
        //3.1 利用运行时机制查看所有的属性名称
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            
            print(String(cString: name!))
        }
         */
        let targets = systemGesture.value(forKey: "targets") as? [NSObject]
        guard let targetObject = targets?.first else {return}
        //3.2取出target
        guard let target = targetObject.value(forKey: "target") else {return}
        //3.2取出action
        let action = Selector(("handleNavigationTransition:"))
        
        //创建自己的Pan手势
        let panGesture = UIPanGestureRecognizer()
        gestureView.addGestureRecognizer(panGesture)
        panGesture.addTarget(target , action: action)
    }
    
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        
        super.pushViewController(viewController, animated: animated)
    }
}
