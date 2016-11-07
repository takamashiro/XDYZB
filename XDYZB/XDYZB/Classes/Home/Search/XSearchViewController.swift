//
//  SearchLiveRoomController.swift
//  XDYZB
//
//  Created by takamashiro on 2016/11/7.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class XSearchViewController: PYSearchViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
}
