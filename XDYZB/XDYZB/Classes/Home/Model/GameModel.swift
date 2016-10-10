//
//  GameModel.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/10.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class GameModel: GameBaseModel {
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
