//
//  networktools.swift
//  weather
//
//  Created by swift on 2017/5/1.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit
import  Alamofire
// 枚举
enum methodtype{
    case get
    case post
}
class networktools {
    class func requestdata(url:String,type:methodtype,parameters:[String:String]? = nil,completion:@escaping (_ result:Any)->()){
        let method = type == methodtype.get ? HTTPMethod.get:HTTPMethod.post
        Alamofire.request(url, method: method, parameters: parameters ).responseJSON { (response) in
            guard let resultdata = response.result.value else{
                print(response.error ?? "error")
                return
            }
            completion(resultdata)
        }
    }
}
