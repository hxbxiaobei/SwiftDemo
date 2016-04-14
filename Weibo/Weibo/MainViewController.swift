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
        
        // 添加子控制器
        addChildViewControllers()
        
        // 从 iOS7 开始就不推荐在 viewDidLoad 中设置 frame
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 添加中间的加号按钮
        setupComposeBtn()
    }
    
    /**
     监听加号按钮点击
     注意：监听按钮点击的方法不能是私有方法
     */
    func composeBtnClick() {
        print(__FUNCTION__)
    }
    
    // MARK: - 内部控制方法
    private func setupComposeBtn() {
        
        // 添加加号按钮
        tabBar.addSubview(composeBtn)
        // 调整加号按钮的位置
        let width = UIScreen.mainScreen().bounds.size.width / CGFloat(viewControllers!.count)
        let rect = CGRect(x: 0, y: 0, width: width, height: 49)
        
        /*
        第一个参数：是 frame 的大小
        第二个参数：是 x 方向偏移的大小
        第三个参数：是 y 方向偏移的大小
        */
        composeBtn.frame = CGRectOffset(rect, 2 * width, 0)
    }
    
    /**
     添加所有的子控制器
     */
    private func addChildViewControllers() {
        
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
                
                // 在添加一个占位控制器
                addChildViewController("NullViewController", title: "", image: "")
                
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
    
    // MARK: - 懒加载
    private lazy var composeBtn: UIButton = {
        let btn = UIButton()
        
        // 设置前景图片
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        // 设置背景图片
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        // 添加监听事件
        btn.addTarget(self, action: "composeBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()

}
