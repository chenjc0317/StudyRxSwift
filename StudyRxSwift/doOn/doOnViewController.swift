//
//  doOnViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/15.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class doOnViewController: UIViewController {
    
    /**
     #doOn：监听事件的生命周期，会在每一个事件发送前调用
     和 subscribe一样会有不同的block处理不同类型的Event
     do(onNext:) 方法就是在 subscribe(onNext:) 前调用
     do(onCompleted:) 方法则会在 subscribe(onCompleted:) 前面调用
     */
    /// RxSwfit垃圾袋
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "DoOn"
        doOn()
    }
    func doOn(){
        let observable = Observable.of("A","B","C")
        
        observable.do(onNext: { element in
            print("Intercepted Next：", element)
        }, onError: { error in
            print("Intercepted Error：", error)
        }, onCompleted: {
            print("Intercepted Completed")
        }, onDispose: {
            print("Intercepted Disposed")
        })
            .subscribe(onNext: { element in
                print(element)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            }).disposed(by: disposeBag)
        
    }
}
