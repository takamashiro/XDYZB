//
//  GameBaseModel.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/10.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    /// 组显示的标题
    var tag_name : String = ""
    /// 游戏对应的图标
    var icon_url : String = ""
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
