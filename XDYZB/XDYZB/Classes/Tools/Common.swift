//
//  Common.swift
//  XDYZB
//
//  Created by takamashiro on 2016/9/26.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

let kStatusBarH : CGFloat = 20
let kNavigationBarH : CGFloat = 44
let kTabbarH : CGFloat = 44

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height


//请求API
let kGetbigDataRoom = "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
let kGetVerticalRoom = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
let kgetHotCate = "http://capi.douyucdn.cn/api/v1/getHotCate"
let kGetCycleData = "http://www.douyutv.com/api/v1/slide/6"

let kGetGameData = "http://capi.douyucdn.cn/api/v1/getColumnDetail"

//娱乐
//http://capi.douyucdn.cn/api/v1/getHotRoom/2?time=1475372700
let kGetEntertainmentData = "http://capi.douyucdn.cn/api/v1/getHotRoom/2"
//趣玩
//前20
//http://capi.douyucdn.cn/api/v1/getColumnRoom/3?offset=0&limit=20
//再20
//http://capi.douyucdn.cn/api/v1/getColumnRoom/3?offset=20&client_sys=ios&limit=20
let kGetFunToPlayData = "http://capi.douyucdn.cn/api/v1/getColumnRoom/3"
