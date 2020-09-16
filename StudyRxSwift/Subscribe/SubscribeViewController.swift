//
//  SubscribeViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/14.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import RxSwift

/**
 #subscribe的功能就是订阅Observabel，接收Event
 */
class SubscribeViewController: UIViewController {
    /// RxSwift垃圾袋
    let disppseBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Subscribe"
        /// 序列对象
        let observabel = Observable<String>.of("0","1","2")
        ///# 方法1：我们使用subscribe()订阅一个Observable对象，该方法的 block 的回调参数就是被发出的 event 事件，我们将其直接打印出来。
        observabel.subscribe{ event in
            print(event)
        }.disposed(by: disppseBag)
        
        ///# 获取到这个事件里的数据，可以通过 event.element 得到
        observabel.subscribe{ event in
            print(event.element)
        }.disposed(by: disppseBag)
        
        ///# 方法2：分类打印数据 通过不同的block回调处理不同类型的Event事件
        observabel.subscribe(onNext: { event in
            print(event)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        }).disposed(by: disppseBag)
        
        observabel.subscribe(onNext: {event in
            print(event)
        })
    }
    
}
