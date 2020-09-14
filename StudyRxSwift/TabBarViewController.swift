//
//  tabBarViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/14.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = ViewController()
        self.addChildVC(childVC: vc, childTitle: "首页", imageName: "", selectedImageName: "")
        
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
