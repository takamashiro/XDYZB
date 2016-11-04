//
//  RoomNormalViewController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/15.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController {

     var room_id : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purple
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false , animated: true)
    }
}


