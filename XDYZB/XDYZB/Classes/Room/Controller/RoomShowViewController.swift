//
//  RoomShowViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/15.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class RoomShowViewController: UIViewController {

    var room_id : Int = 0
    
    lazy var closeBtn : UIButton = {
        let closeBtn = UIButton(frame: CGRect(x: 20, y: 20, width: 36, height: 36))
        
        closeBtn.setTitle("关闭", for: UIControlState.normal)
        closeBtn.tintColor = UIColor.white
        //closeBtn.backgroundColor = UIColor.blue
        closeBtn.addTarget(self, action: #selector(RoomShowViewController.exit), for: UIControlEvents.touchUpInside)
        closeBtn.sizeToFit()
        return closeBtn
    }()
    
    var backgroundImage : String = "" //封面背景
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        view.insertSubview(closeBtn, aboveSubview: view)
       

    }

    func setupBackgroundImage() {
        let width  = UIScreen.main.bounds.size.width;
        let length = UIScreen.main.bounds.size.height;
        let imgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: width, height: length))
        let data = NSData(contentsOf: NSURL(string: backgroundImage) as! URL)
        imgView.image = UIImage(data: data as! Data)
        //加高斯模糊
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = imgView.bounds
        imgView.addSubview(visualEffectView)
        view.addSubview(imgView)
    }
    
    func exit() {
        self.dismiss(animated: true, completion: nil)
    }
}
