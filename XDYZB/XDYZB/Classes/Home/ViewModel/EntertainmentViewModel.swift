//
//  EntertainmentViewModel.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/11.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import Foundation

class EntertainmentViewModel {
    lazy var Entertainments : [AnchorGroup] = [AnchorGroup]()
}

extension EntertainmentViewModel {
    func loadEntertainmentData(finishedCallback : @escaping () -> ()) {
        
        let parameters = ["time" : Date.getCurrentTime()]
        NetworkTools.requestData(.GET, URLString: kGetEntertainmentData, parameters: parameters as [String : NSString]?) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历数组,获取字典,并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.Entertainments.append(group)
            }
            
            finishedCallback()
        }
    }
}
