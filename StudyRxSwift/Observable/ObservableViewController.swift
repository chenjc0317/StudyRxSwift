//
//  ObservableViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/14.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import RxSwift

/**
 #Observable:可观察序列
 #下面是创建Observable的几种方法
 */

class ObservableViewController: UIViewController {

    /// RxSwift垃圾袋
    let disppseBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Observable"
        
        // 1. just()该方法需要传入默认值
        let observable01 = Observable.just("5")
        observable01.subscribe{ ob in
            print("observable01=\(ob)")
        }.disposed(by: disppseBag)
        
        // 2. of()该方法可以接受可变数量的参数（必需要是同类型的）
        let observable02 = Observable.of("1","2","3")
        observable02.subscribe{ ob in
            print("observable02=\(ob)")
        }.disposed(by: disppseBag)

        // 3. from()该方法需要一个数组参数
        let observable03 = Observable.from(["3","2","1"])
        observable03.subscribe{ ob in
            print("observable03=\(ob)")
        }.disposed(by: disppseBag)

        // 4. empty()该方法创建一个空内容的 Observable 序列
        let observable04 = Observable<String>.empty()
        observable04.subscribe{ ob in
            print("observable04=\(ob)")
        }.disposed(by: disppseBag)
        
        // 5. never()该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
        let observable05 = Observable<String>.never()
        observable05.subscribe{ ob in
            print("observable05=\(ob)")
        }.disposed(by: disppseBag)
        
        // 6. error()该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列。
        let observable06 = Observable<String>.error(MyError.A)
        observable06.subscribe{ ob in
            print("observable06=\(ob)")
        }.disposed(by: disppseBag)
        
        // 7. range()该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的 Observable 序列。
        // 相当于 Observable.of("1","2","3","4","5")
        let observable07 = Observable.range(start: 1, count: 5)
        observable07.subscribe{ ob in
            print("observable07=\(ob)")
        }.disposed(by: disppseBag)

        // 8. repeatElement()该方法创建一个可以无限发出给定元素的 Event 的 Observable 序列（永不终止）。
        let observable08 = Observable.repeatElement(1)
        // FIXME:这里的注释不能打开
        //        observable08.subscribe{ ob in
        //            print("observable08=\(ob)")
        //        }.disposed(by: disppseBag)

        // 9. generate()该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。
        // initialState:初始状态 condition:条件 iterate:迭代
        // 相当于 Observable.of(0 , 2 ,4 ,6 ,8 ,10)
        let observable09 = Observable.generate(
            initialState: 0,
            condition: {$0 <= 10},
            iterate: {$0 + 2})
        observable09.subscribe{ ob in
            print("observable09=\(ob)")
        }.disposed(by: disppseBag)

        // 10. create()该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理。
        // 这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        let observable10 = Observable<String>.create { observer in
            //对订阅者发出了.next事件，且携带了一个数据"hello"
            observer.onNext("hello")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
        
        //订阅测试
        observable10.subscribe {
            print($0)
        }.disposed(by: disppseBag)
        
        // 11.deferred()该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable 序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。
        //用于标记是奇数、还是偶数
        var isOdd = true
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let observable11 : Observable<Int> = Observable.deferred{    //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
             
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        // 第一次订阅
        observable11.subscribe{ event in
            print("第一次订阅", event)
        }.disposed(by: disppseBag)
        // 第二次订阅
        observable11.subscribe{ event in
            print("第二次订阅", event)
        }.disposed(by: disppseBag)
        
        
        // 12.interval()这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。
        // 下面方法让其每 1 秒发送一次，并且是在主线程（MainScheduler）发送。
        let observable12 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        // 13. timer()
        // 这个方法有两种用法，一种是创建的 Observable 序列在经过设定的一段时间后，产生唯一的一个元素。
        //5秒种后发出唯一的一个元素0
        let observable13 = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        observable13.subscribe { event in
            print("observable13",event)
        }.disposed(by: disppseBag)
        
        // 另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素。
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable14 = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        observable14.subscribe { event in
            print("observable14",event)
        }.disposed(by: disppseBag)
    }
    
}

enum MyError: Error {
    case A
    case B
}
