
//
//  alertview.swift
//  alertview
//
//  Created by swift on 2017/5/24.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit
class JASharebtn:UIButton{
    //定义属性
    var iconimageview:UIImageView!
    var namelabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconimageview = UIImageView()
        iconimageview.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        iconimageview.layer.cornerRadius = 5
        self.addSubview(iconimageview)
        
        namelabel = UILabel()
        namelabel.frame = CGRect(x: 0, y: 55, width: 60, height: 20)
        namelabel.textAlignment = .center
        namelabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(namelabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//代理
protocol shareviewdelegate{
    func sharebtnclick(index:Int)
}
class JAShareview: UIView {
    //定义属性
    var shareview:UIView!
    var shareviewbackground:UIView!
    var count:Int = 0
    var sepwidth:CGFloat!
    var windows:UIWindow!
    var delegate:shareviewdelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shareview = UIView()
        shareview.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240)
        shareview.backgroundColor = UIColor.white
        self.addSubview(shareview)
        
        //        shareviewbackground = UIView()
        //        shareviewbackground.frame = UIScreen.main.bounds
        //        shareviewbackground.backgroundColor = UIColor.blue
        //        shareviewbackground.addGestureRecognizer(UIGestureRecognizer.init(target: self, action: #selector(JAShareview.hidden)))
        
        
        let canclebtn = UIButton()
        canclebtn.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 40)
        canclebtn.setTitle("取消分享", for: .normal)
        canclebtn.backgroundColor = UIColor.cyan
        canclebtn.setTitleColor(UIColor.black, for: .normal)
        canclebtn.addTarget(self, action: #selector(JAShareview.hidden), for: .touchUpInside)
        self.addSubview(canclebtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func additem(title:String,withimage:UIImage){
        count+=1
        sepwidth = 20 + ((UIScreen.main.bounds.width - 280)/3 + 60)*(CGFloat(count - 1))
        
        let sharebtn = JASharebtn()
        sharebtn.frame = CGRect(x: 0+sepwidth, y: 10, width: 60, height: 80)
        sharebtn.iconimageview.image = withimage
        sharebtn.namelabel.text = title
        sharebtn.addTarget(self, action: #selector(JAShareview.sharebtn(btn:)), for: .touchUpInside)
        sharebtn.tag = 1000+count
        if count>4{
            sepwidth = 20 + ((UIScreen.main.bounds.width - 280)/3 + 60)*(CGFloat(count - 5))
            sharebtn.frame = CGRect(x: 0+sepwidth, y: 90, width: 60, height: 80)
        }
        shareview.addSubview(sharebtn)
    }
    
    func show(){
        windows = UIWindow()
        windows.windowLevel = UIWindowLevelAlert+1
        windows.backgroundColor = UIColor.clear
        windows.isHidden = true
        windows.isUserInteractionEnabled = true
        //windows.addSubview(shareviewbackground)
        windows.addSubview(self)
        windows.isHidden = false
        UIView.animate(withDuration: 0.2) {
            //  self.shareviewbackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-240, width: UIScreen.main.bounds.width, height: 240)
        }
    }
    func hidden(){
        UIView.animate(withDuration: 0.2, animations: {
            //  self.shareviewbackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 240)
        }) { (finshed) in
            self.windows = nil
        }
        
    }
    func sharebtn(btn:UIButton){
        delegate.sharebtnclick(index: btn.tag-1001)
        hidden()
    }
}

