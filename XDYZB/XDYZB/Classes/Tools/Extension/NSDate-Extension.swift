//
//  NSDate-Extension.swift
//  XDYZB
//
//  Created by takamashiro on 2016/9/28.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970) 
        return "\(interval)"
    }
}
