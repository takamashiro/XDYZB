//
//  UIBarButtonItem-Extension.swift
//  XDYZB
//
//  Created by takamashiro on 2016/9/26.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    //苹果不推荐使用类方法，推荐使用构造函数
    class func createItem(_ imageName: String, highImageName: String,size:CGSize) -> UIBarButtonItem {
    
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named:highImageName), for: UIControlState.highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    // 遍历构造函数: 1>convenience 开头 2>在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName: String, highImageName: String = "",size: CGSize = CGSize.zero,target: AnyObject?,action: Selector) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        if highImageName != "" {
            btn.setImage(UIImage(named:highImageName), for: UIControlState.highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView:btn)
        
    }
}
