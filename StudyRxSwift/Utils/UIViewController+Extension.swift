//
//  UIViewController+Extension.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/14.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import Foundation
public extension UIViewController{
    /// 将视图控制器推到接收器的堆栈上并更新显示
    /// - Parameters:
    ///   - vc: 视图控制器
    ///   - animated: 是否有动画, 默认有
    func pushVC(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }

    /// 从导航堆栈中弹出顶层视图控制器并更新显示
    /// - Parameter animated: 是否有动画, 默认有
    func popVC(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
}

