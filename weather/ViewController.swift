//
//  ViewController.swift
//  weather
//
//  Created by swift on 2017/5/1.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftGifOrigin
import UserNotifications
class ViewController: UIViewController,shareviewdelegate {
 //拖
    @IBOutlet weak var beijing: UIImageView!
    @IBOutlet weak var cityname: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBAction func sharebtn(_ sender: UIButton) {
        shareview.show()
    }
    
    @IBOutlet weak var advice: UICollectionView!
    @IBOutlet weak var weekweather: UITableView!
//定义属性
    var namedata:[String] = ["空调","运动","紫外线","感冒","洗车","穿衣"]
    let currentmodel:currentdata = currentdata()
    var tabledata = [[JSON]]()
    var collectiondata = [JSON]()
    var huanglidata = [JSON]()
    var shareview:JAShareview!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        weekweather.dataSource = self
        weekweather.delegate = self
        advice.delegate = self
        advice.dataSource = self
        
    //1.设置ui
        setupui()
    //2.请求数据
        lodacurrentdata()
        lodaweekdata()
        loadadvicedata()
        lodahuanglidata()
     //3.本地定时推送
        pushnotification()
       
    }
    func sharebtnclick(index:Int){
        if index == 0 {
           
            currentmodel.requestcurrentdata(completion: { (data) in
                let info:String = "\(data[5]),\(data[4]),当前温度\(data[3])°,最高温度\(data[1])°,最低温度\(data[0])°,\(data[7])\(data[8])。"
                WXApi.sharetext(text: info, insence: WXSceneTimeline)
            })
        }
        else if index == 1 {
            
            currentmodel.requestcurrentdata(completion: { (data) in
                let info:String = "\(data[5]),\(data[4]),当前温度\(data[3])°,最高温度\(data[1])°,最低温度\(data[0])°,\(data[7])\(data[8])。"
                WXApi.sharetext(text: info, insence: WXSceneSession)
            })
        }

    }
}
//消息推送
extension ViewController{
    fileprivate func pushnotification(){
        currentmodel.requestcurrentdata { (data) in
            
            let info:String = "\(data[5]),\(data[4]),当前温度\(data[3])°,最高温度\(data[1])°,最低温度\(data[0])°,\(data[7])\(data[8])。"
            let content = UNMutableNotificationContent()
            content.title = "天气"
            content.subtitle = "顾大侠创作的"
            content.badge = 1
            content.body = info
            content.sound = UNNotificationSound.default()
            
//            let imgname = "applelogo"
//            guard let imgurl = Bundle.main.url(forResource: imgname, withExtension: "png") else{
//                return
//            }
//            let attachment = try! UNNotificationAttachment(identifier: imgname, url: imgurl, options: .none)
//            content.attachments = [attachment]
            
            print(content)

            var components = DateComponents()
            components.hour = 6
            components.minute = 0
            let tigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            //let tigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            let requestid = "first"
            let request = UNNotificationRequest(identifier: requestid, content: content, trigger: tigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if error == nil{
                    print("推送成功")
                }
            }
        }
    }
}
//设置ui
extension ViewController{
    fileprivate func setupui(){
        shareview = JAShareview()
        shareview.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-240, width: UIScreen.main.bounds.width, height: 240)
        
        shareview.delegate = self
        shareview.additem(title: "朋友圈", withimage: UIImage(named: "friends")!)
         shareview.additem(title: "好友", withimage: UIImage(named: "weixin")!)
        //当前天气ui设置
        setcurrentweather()
        //一周天气ui设置
        weeklyweather()
        //黄历ui设置,添加到collectionview中
        sethuangli()
    }
}
extension ViewController{
    fileprivate func setcurrentweather(){
        weekweather.backgroundColor = UIColor(red: 36/255, green: 35/255, blue: 45/255, alpha: 1.0)
        weekweather.separatorColor = .none
    }
    fileprivate func weeklyweather(){
        advice.backgroundColor = UIColor(red: 36/255, green: 35/255, blue: 45/255, alpha: 1.0)
    }
    fileprivate func sethuangli(){
        let vieww = UIView(frame: CGRect(x: 0, y: 270, width: self.view.frame.width, height: 130))
        vieww.backgroundColor = UIColor.orange
        let yi = UILabel()
        yi.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 26)
        
        yi.text = "\(huanglidata)"
        vieww.addSubview(yi)
        advice.addSubview(vieww)
        
    }
}
//collectionview的数据源代理
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerid", for: indexPath)
//        reusableview.backgroundColor = UIColor(red: 36/255, green: 35/255, blue: 45/255, alpha: 1.0)
//        let textelabel = UILabel()
//        textelabel.text = "生活小贴士"
//        textelabel.textColor = UIColor.white
//        textelabel.font = UIFont.systemFont(ofSize: 25)
//        textelabel.sizeToFit()
//        textelabel.textAlignment = .center
//        textelabel.center = CGPoint(x: self.view.frame.width/2, y: 20)
//        reusableview.addSubview(textelabel)
//        return reusableview
//    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectiondata.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncellid", for: indexPath) as! adviceCollectionViewCell
        cell.image.image = UIImage(named: namedata[indexPath.item])
        cell.name.text = namedata[indexPath.item]
        cell.advice.text = "\(collectiondata[indexPath.item])"
        return cell
    }
}
//tableview中的headerview设置
extension ViewController{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headview = UIView()
        headview.backgroundColor = UIColor(red: 36/255, green: 35/255, blue: 45/255, alpha: 1.0)
        let textelabel = UILabel()
        textelabel.text = "一周天气预报"
        textelabel.textColor = UIColor.white
        textelabel.font = UIFont.systemFont(ofSize: 25)
        textelabel.sizeToFit()
        textelabel.textAlignment = .center
        textelabel.center = CGPoint(x: self.view.frame.width/2, y: 20)
        headview.addSubview(textelabel)
        return headview
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
//tableview数据源代理
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabledata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! weekweatherTableViewCell
        cell.high.text = "\(tabledata[indexPath.row][1])"
        cell.low.text = "\(tabledata[indexPath.row][3])"
        cell.weekend.text = "星期\(tabledata[indexPath.row][0])"
        cell.weatherimage.image = UIImage(named: "\(tabledata[indexPath.row][2])")
        cell.nightimage.image = UIImage(named: "\(tabledata[indexPath.row][4])")
       // cell.weatherimage.loadGif(name: "\(tabledata[indexPath.row][2])")
       // cell.nightimage.loadGif(name:  "\(tabledata[indexPath.row][4])")
        cell.backgroundColor = UIColor(red: 36/255, green: 35/255, blue: 45/255, alpha: 1.0)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

//请求数据
extension ViewController{
   fileprivate func lodacurrentdata(){
       currentmodel.requestcurrentdata { (data) in
        //赋值
        self.cityname.text = "\(data[5])"
        self.info.text = "\(data[4])"
        self.temperature.text = "\(data[3])"
        self.week.text = "星期\(data[2])"
        self.high.text = "\(data[1])"
        self.low.text = "\(data[0])"
        self.beijing.loadGif(name: "\(data[4])")
        
     }
    }
    //一周天气
    fileprivate func lodaweekdata(){
        currentmodel.requestweekdata { (data) in
            self.tabledata = data
           self.weekweather.reloadData()
        }
    }
    //生活建议
    fileprivate func loadadvicedata(){
        currentmodel.requestshenghuodata { (data) in
            self.huanglidata = data
            self.collectiondata = data
            self.advice.reloadData()
        }
    }
    //黄历数据
    fileprivate func lodahuanglidata(){
        currentmodel.requesthuanglidata { (data) in
            
        }
    }
}


//http://api.avatardata.cn/Weather/Query?key=7fdd18a26632413982d69f58977ec744&cityname=海安
