//
//  wechatshare.swift
//  wechatshare
//
//  Created by AirBook on 2017/5/22.
//  Copyright © 2017年 AirBook. All rights reserved.
//

import UIKit
//微信分享封装
extension WXApi{
    //分享文本
    class func sharetext(text:String,insence:WXScene){
        let req = SendMessageToWXReq()
        req.text = text
        req.bText = true
        req.scene = Int32(insence.rawValue)
        WXApi.send(req)
    }
    //分享图片
    class func shareimage(image:UIImage,insence:WXScene){
        let ext = WXImageObject()
        ext.imageData = UIImagePNGRepresentation(image)
        
        let message = WXMediaMessage()
        message.title = nil
        message.description = nil
        message.mediaObject = ext
        message.mediaTagName = "mypic"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.draw(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage!)
        
        let req=SendMessageToWXReq()
        req.text=nil
        req.message=message
        req.bText=false
        req.scene = Int32(insence.rawValue)
        WXApi.send(req)
    }
    //分享音乐
    class func sharemusic(title:String,description:String, musicurl:String,ThumbImage:UIImage,musicdataurl:String,insence:WXScene){
        let message =  WXMediaMessage()
        
        message.title = title
        message.description = description
        message.setThumbImage(ThumbImage)
        
        let ext =  WXMusicObject()
        ext.musicUrl = musicurl
        ext.musicDataUrl = musicdataurl
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(insence.rawValue)
        WXApi.send(req)
    }
    //分享链接
    class func shareurl(title:String,description:String, webpageurl:String,ThumbImage:UIImage,insence:WXScene){
        let message =  WXMediaMessage()
        
        message.title = title
        message.description = description
        message.setThumbImage(ThumbImage)
        
        let ext =  WXWebpageObject()
        ext.webpageUrl = webpageurl
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(insence.rawValue)
        WXApi.send(req)
    }
    //分享视频
    class func sharevideo(title:String,description:String, videourl:String,ThumbImage:UIImage,insence:WXScene){
        let message =  WXMediaMessage()
        message.title = title
        message.description = description
        message.setThumbImage(ThumbImage)
        
        let ext =  WXVideoObject()
        ext.videoUrl = videourl
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(insence.rawValue)
        WXApi.send(req)

    }
    //分享文件
}

