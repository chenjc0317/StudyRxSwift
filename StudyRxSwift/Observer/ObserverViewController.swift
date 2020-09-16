//
//  ObserverViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/15.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 #Observer：观察者，监听事件Event，对事件作出响应
 当我们点击按钮，弹出一个提示框。那么这个“弹出一个提示框”就是观察者 Observer<Void>
 */
class ObserverViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Observer"
        SubscribeOrBind()
    }
    ///# 在subscribe、bind 方法中创建观察者
    func SubscribeOrBind(){
        ///# 创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述当事件发生时，需要如何做出响应
        let observable01 = Observable.of("A","B","C")
        observable01.subscribe(onNext: { element in
            print("element=\(element)")
        }, onError: { error in
            print("Error=\(error)")
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onCompleted")
        })
        
        ///# 创建一个定时生成索引数的 Observable 序列，并将索引数不断显示在 label 标签上
        let observable02 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        observable02.map{
            "当前索引数：\($0 )"
        }.bind{ [weak self](text) in
            //收到发出的索引数后显示到label上
            self?.myLabel.text = text
        }.disposed(by: disposeBag)
        
    }
    ///# 使用 AnyObserver 创建观察者
    func AnyObserver(){
        /**
         # AnyObserver可以用来描叙任意一种观察者
         */
        //        let observable03 : AnyObserver<String> = AnyObserver{ event in
        //
        //        }
        //        
        //        //观察者
        //        let observer: AnyObserver<String> = AnyObserver { (event) in
        //            switch event {
        //            case .next(let data):
        //                print(data)
        //            case .error(let error):
        //                print(error)
        //            case .completed:
        //                print("completed")
        //            }
        //        }
    }
}
