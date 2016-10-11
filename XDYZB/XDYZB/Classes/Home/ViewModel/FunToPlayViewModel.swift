//
//  FunToPlayViewModel.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/11.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit


class FunToPlayViewModel {
    
    lazy var FunToPlays : [AnchorModel] = [AnchorModel]()
    var parameters :[String : NSString]? {
        didSet {
            parameters = self.getParameters(isMore: false)  //逻辑有待修改
        }
    }
}

extension FunToPlayViewModel {
    func loadFunToPlayData(finishedCallback : @escaping () -> ()) {
        
        let parameters = ["offset" : "0","limit" : "20"]
        NetworkTools.requestData(.GET, URLString: kGetFunToPlayData, parameters: parameters as [String : NSString]?) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历数组,获取字典,并且将字典转成模型对象
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.FunToPlays.append(anchor)
            }
            
            finishedCallback()
        }
    }
}
//下拉刷新
//前20
//http://capi.douyucdn.cn/api/v1/getColumnRoom/3?offset=0&limit=20

//更多刷新 更改offset，limit还是为20

extension FunToPlayViewModel {
    func getParameters(isMore:Bool)-> [String : NSString] {
        
        let key1 = "offset"
        let key2 = "limit"
        var keyValue1 = 0   //改变值
        let keyValue2 = 20
        
        if isMore {
            keyValue1 = keyValue1 + 20
        }else {
            keyValue1 = 0
        }
        
        return [key1:"\(keyValue1)" as NSString,key2:"\(keyValue2)" as NSString]
    }
}
