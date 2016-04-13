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
        
        // 1.获取 JSON 文件的路径
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        // 2.通过文件路径创建 NSData
        if let jsonPath = path {
            let jsonPath = NSData(contentsOfFile: jsonPath)
            
            do {
                // 有可能发生异常的代码放到这里
                // 3.序列化 JSON 数据 --> Array
                // try : 发生异常会跳到 catch 中继续执行
                // try! : 发生异常程序直接崩溃
                let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonPath!, options: NSJSONReadingOptions.MutableContainers)
                // 4.遍历数组，动态创建控制器和设置数据
                // 在 Swift 中，如果需要遍历一个数组，必须明确数据的类型
                for dict in dictArr as! [[String : String]] {
                    
                    // 报错的原因是因为 addChildViewController 参数必须有值，但是字典的返回值是可选类型
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, image: dict["imageName"]!)
                }
            }catch {
                
                // 发生异常之后会执行的代码
                print(error)
                
                // 从本地创建控制器
                addChildViewController("HomeTableViewController", title: "首页", image: "tabbar_home")
                addChildViewController("MessageTableViewController", title: "消息", image: "tabbar_message_center")
                addChildViewController("DiscoverTableViewController", title: "广场", image: "tabbar_discover")
                addChildViewController("ProfileTableViewController", title: "我", image: "tabbar_profile")
            }
        }
        

        
    }

    /**
     初始化子控制器
     
     - parameter childController: 需要初始化的子控制器
     - parameter title:           子控制器的标题
     - parameter image:           子控制器的图片
     */
//    private func addChildViewController(childController: UIViewController, title: String, image: String) {
     private func addChildViewController(childController: String, title: String, image: String) {
     
        /*
        print(childController)
        <Weibo.HomeTableViewController: 0x7fa8414754f0>
        Weibo 是命名空间
        */
        
        // 动态获取命名空间
        let spaceName = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        // 将字符串转为类
        // 默认情况下命名空间就是项目的名称，但是命名空间名称是可以修改的
        let cls: AnyClass? = NSClassFromString(spaceName + "." + childController)
        // 将 AnyClass 转换为指定的类型
        let vcCls = cls as! UIViewController.Type
        // 通过类创建一个对象
        let vc = vcCls.init()
        
        // 1.创建首页对应的数据
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        vc.title = title
        
        // 2.给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        
        // 3.将导航控制器添加到当前控制器上
        addChildViewController(nav)
    }

}
