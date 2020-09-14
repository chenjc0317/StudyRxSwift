//
//  PeopleViewModel.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/14.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import Foundation
import RxSwift

struct PeopleViewModel {
    let data  = Observable.just([
        PeopleModel(name: "张三", age: 19),
        PeopleModel(name: "李四", age: 21),
        PeopleModel(name: "王五", age: 22),
    ])
}
