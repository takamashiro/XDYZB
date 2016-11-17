//
//  BaseViewModel.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/12.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class BaseViewModel {
    var isloadMore = false
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}



extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.GET, URLString: URLString, parameters: parameters) { (result) in
            // 1.对界面进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            if(!self.isloadMore) { self.anchorGroups.removeAll() }//先清空
            // 2.遍历数组中的字典
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else {
                
                let group = AnchorGroup()
                
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict:dict))
                }
                
                self.anchorGroups.append(group)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}

