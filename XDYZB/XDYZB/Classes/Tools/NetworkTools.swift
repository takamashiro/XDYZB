//
//  NetworkTools.swift
//  XDYZB
//
//  Created by takamashiro on 2016/9/28.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : NSString]? = nil, finishedCallback : @escaping (_ result : AnyObject) -> ()) {
        
        // 1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString,method:method,parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result as AnyObject)
        }
    }
}
