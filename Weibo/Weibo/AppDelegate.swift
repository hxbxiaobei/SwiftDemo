//
//  AppDelegate.swift
//  Weibo
//
//  Created by HuangXiaoBei on 16/4/11.
//  Copyright © 2016年 huangxiaobei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 1.创建窗口
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        window?.frame = UIScreen.mainScreen().bounds
        
        // 2.添加根控制器
        window?.rootViewController = MainTabBarController()
        
        // 3.显示窗口
        window?.makeKeyAndVisible()
        
        return true
    }

    
}

