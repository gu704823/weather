//
//  AppDelegate.swift
//  weather
//
//  Created by swift on 2017/5/1.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        WXApi.registerApp("wx071d40ff7fcf3e61")
        
        return true
    }
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate:self)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate:self)
    }
    func onReq(_ req: BaseReq!) {
        
    }
    func onResp(_ resp: BaseResp!) {
        
    }

  


}

