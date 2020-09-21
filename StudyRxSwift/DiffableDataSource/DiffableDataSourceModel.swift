//
//  DiffableDataSourceModel.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/21.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import Foundation

enum DiffableDataSourceSection {
    case today
    case new
}
/// Hashable必须是该类型的
struct DiffableDataSourceModel: Hashable {
    var id : Int
    var content : String
}
