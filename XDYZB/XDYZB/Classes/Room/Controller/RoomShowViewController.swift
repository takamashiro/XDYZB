//
//  RoomShowViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/15.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit
//import SnapKit
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
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        
       
        view.insertSubview(closeBtn, aboveSubview: view)

    }

    func exit() {
        self.dismiss(animated: true, completion: nil)
    }
}
