//
//  currentdata.swift
//  weather
//
//  Created by swift on 2017/5/2.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit
import SwiftyJSON
class currentdata:NSObject {
//定义属性
}
extension  currentdata{
 //请求数据
    func requestcurrentdata(completion:@escaping (_ data:[JSON])->()){
        var dataarry:[JSON] = []
        let url:String = "http://api.avatardata.cn/Weather/Query"
         let parameters = ["key":"7fdd18a26632413982d69f58977ec744","cityname":"海安"]
        networktools.requestdata(url: url, type: .get, parameters: parameters) { (result) in
          let json = JSON(result)
            guard let totaldata = json["result"].dictionary else{
                return
            }
          let cityname = totaldata["realtime"]?["city_name"]
          let info = totaldata["realtime"]?["weather"]["info"]
          let temperature = totaldata["realtime"]?["weather"]["temperature"]
          let week = totaldata["weather"]?[0]["week"]
          let high = totaldata["weather"]?[0]["info"]["day"][2]
          let low = totaldata["weather"]?[0]["info"]["night"][2]
            dataarry.append(low!)
            dataarry.append(high!)
            dataarry.append(week!)
            dataarry.append(temperature!)
            dataarry.append(info!)
            dataarry.append(cityname!)
            completion(dataarry)
            
        }
    }
    //第一天的数据方法
    func model(week:Int,totaldata:[String:JSON])->[JSON]{
        var dataarry:[JSON ] = []
        let weekend = totaldata["weather"]?[week]["week"]
        let high = totaldata["weather"]?[week]["info"]["day"][2]
        let highimage = totaldata["weather"]?[week]["info"]["day"][0]
        let low = totaldata["weather"]?[week]["info"]["night"][2]
        let lowimage = totaldata["weather"]?[week]["info"]["night"][0]
        dataarry.append(weekend!)
        dataarry.append(high!)
        dataarry.append(highimage!)
        dataarry.append(low!)
        dataarry.append(lowimage!)
        return dataarry
    }

    //请求一周天气数据
    func requestweekdata(completion:@escaping (_ dataa:[[JSON]])->()){
        var daydata:[JSON] = []
        var tabledataarry = [[JSON]]()
        let urll:String = "http://api.avatardata.cn/Weather/Query"
        let parameterss = ["key":"7fdd18a26632413982d69f58977ec744","cityname":"海安"]
       networktools.requestdata(url: urll, type: .get, parameters: parameterss) { (result) in
        let json = JSON(result)
        guard let tdata = json["result"].dictionary else{
            return
        }
        for i in 1...6{
            daydata = self.model(week: i, totaldata: tdata)
            tabledataarry.append(daydata)
        }
        completion(tabledataarry)
        }
    }
    //请求生活数据抽取
    func shenghuomodel(tdata:[String:JSON],advice:String)->JSON{
       return (tdata["life"]?["info"][advice][0])!
    }
    //请求生活数据
    func requestshenghuodata(completion:@escaping (_ dataa:[JSON])->()){
        var advicedata:[JSON] = []
        let urll:String = "http://api.avatardata.cn/Weather/Query"
        let parameterss = ["key":"7fdd18a26632413982d69f58977ec744","cityname":"海安"]
        networktools.requestdata(url: urll, type: .get, parameters: parameterss) { (result) in
            let json = JSON(result)
            guard let tdata = json["result"].dictionary else{
                return
            }
            advicedata.append(self.shenghuomodel(tdata: tdata, advice: "kongtiao"))
            advicedata.append(self.shenghuomodel(tdata: tdata, advice: "yundong"))
            advicedata.append(self.shenghuomodel(tdata: tdata, advice: "ziwaixian"))
            advicedata.append(self.shenghuomodel(tdata: tdata, advice: "ganmao"))
            advicedata.append(self.shenghuomodel(tdata: tdata, advice: "xiche"))
            advicedata.append(self.shenghuomodel(tdata: tdata, advice: "chuanyi"))
            completion(advicedata)
        }
    }
    
    //请求黄历数据
    func requesthuanglidata(completion:@escaping (_ data:[JSON])->()){
        var huanglidata:[JSON] = []
        let url:String = "http://route.showapi.com/856-1"
        let parameters = ["showapi_appid":"37435","showapi_sign":"39bff99dc3f94b64bd8ac39bd03cb6b9"]
        networktools.requestdata(url: url, type: .get
            , parameters: parameters) { (result) in
                let json = JSON(result)
                guard let totaldata = json["showapi_res_body"].dictionary else{
                    return
                }
                let nongli = totaldata["nongli"]
                let gongli = totaldata["gongli"]
                let yi = totaldata["yi"]
                let ji = totaldata["ji"]
                huanglidata.append(nongli!)
                huanglidata.append(gongli!)
                huanglidata.append(yi!)
                huanglidata.append(ji!)
                completion(huanglidata)
        }
    }
    
}

/*
 0 晴
 1 多云
 2 阴
 3 阵雨
 4 雷阵雨
 7 小雨
 8 中雨
 9 大雨
 */

//http://route.showapi.com/856-1?showapi_appid=37435&showapi_sign=39bff99dc3f94b64bd8ac39bd03cb6b9
//appid = 37435
//secret = 39bff99dc3f94b64bd8ac39bd03cb6b9














