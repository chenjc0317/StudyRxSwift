//
//  tabBarViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/14.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarViewController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let v1 = PeopleViewController()
        let v2 = PeopleViewController()
        let v3 = PeopleViewController()
        let v4 = PeopleViewController()
        
        v1.tabBarItem = ESTabBarItem.init(title: "首页", image: UIImage(named: "icon_Outline_shouye"), selectedImage: UIImage(named: "Icon_Filled_Home"))
        v2.tabBarItem = ESTabBarItem.init(title: "教学", image: UIImage(named: "icon_Outline_jiaoxue"), selectedImage: UIImage(named: "Icon_Filled_jiaoxue"))
        v3.tabBarItem = ESTabBarItem.init(title: "教研", image: UIImage(named: "icon_Outline_jiaoyan"), selectedImage: UIImage(named: "Icon_Filled_jiaoyan"))
        v4.tabBarItem = ESTabBarItem.init(title: "我的", image: UIImage(named: "icon_Outline_xingbie"), selectedImage: UIImage(named: "Icon_Filled_Teacher"))
        
        self.addChild(v1)
        self.addChild(v2)
        self.addChild(v3)
        self.addChild(v4)
        // let vc = ViewController()
        // self.addChildVC(childVC: v1, childTitle: "首页", imageName: "icon_Outline_shouye", selectedImageName: "Icon_Filled_Home")
        
    }
    
    /// 添加子控制器
    
    private func addChildVC(childVC: UIViewController, childTitle: String, imageName: String, selectedImageName:String)
    {
        
        let navigation = UINavigationController(rootViewController: childVC)
        //item 字体颜色
        navigation.navigationBar.tintColor = UIColor.black
        // 背景颜色
        navigation.navigationBar.barTintColor = UIColor.white
        
        childVC.title = childTitle
        childVC.tabBarItem.tag = 1
        childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        self.addChild(navigation)
    }
    
}
