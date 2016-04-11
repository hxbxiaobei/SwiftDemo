//
//  MainTabBarController.swift
//  Weibo
//
//  Created by HuangXiaoBei on 16/4/11.
//  Copyright © 2016年 huangxiaobei. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置当前控制器对应 tabbar 的颜色
        // 注意：在iOS7以前如果设置了 tintColor 只有文字会变，而图片不会变
        tabBar.tintColor = UIColor.orangeColor()
        
        /*
        // 1.创建首页
        let home = HomeTableViewController()
        // 1.1设置首页 tabbar 对应的数据
        home.tabBarItem.image = UIImage(named: "tabbar_home")
        home.tabBarItem.selectedImage = UIImage(named: "tabbar_home_highlighted")
        // 1.2设置导航条对应的数据
        home.title = "首页"
        
        // 2.给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(home)
        
        // 3.将导航控制器添加到当前控制器上
        addChildViewController(nav)
        */
        
        addChildViewController(HomeTableViewController(), title: "首页", image: "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "消息", image: "tabbar_message_center")
        addChildViewController(DiscoverTableViewController(), title: "广场", image: "tabbar_discover")
        addChildViewController(ProfileTableViewController(), title: "我", image: "tabbar_profile")
        
    }

    /**
     初始化子控制器
     
     - parameter childController: 需要初始化的子控制器
     - parameter title:           子控制器的标题
     - parameter image:           子控制器的图片
     */
    private func addChildViewController(childController: UIViewController, title: String, image: String) {
        
        // 1.创建首页
        let childController = HomeTableViewController()
        childController.tabBarItem.image = UIImage(named: image)
        childController.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        childController.title = title
        
        // 2.给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(childController)
        
        // 3.将导航控制器添加到当前控制器上
        addChildViewController(nav)
    }

}
