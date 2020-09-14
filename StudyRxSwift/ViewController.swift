//
//  ViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/10.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct DataModel {
    let name : String
    init(name: String) {
        self.name = name
    }
}
struct DataViewModel {
    let data = Observable.just([
        DataModel(name: "UITableView"),
        DataModel(name: "Observable"),
        DataModel(name: "Subscribe")
    ])
}

class ViewController: UIViewController {
    
    lazy var myTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let listModel = DataViewModel()
    /// RxSwift垃圾袋
    let disppseBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initTableView()
    }
    func initTableView(){
        self.view.addSubview(myTableView)
        myTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        /**
         #为tableview注册cell，并通过闭包赋值给cell
         #.disposed 自动回收
         */
        listModel.data.bind(to: myTableView.rx.items(cellIdentifier: "myCell")){_,model,cell in
            cell.textLabel?.text = model.name
        }.disposed(by: disppseBag)
        
        /**
         #tableViewItem选择
         #.disposed 自动回收
         */
        myTableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.myTableView.deselectRow(at: indexPath, animated: true)
            let row = indexPath.row
            print("选择了\(indexPath.row)行")
            switch row {
            case 0:
                let vc = PeopleViewController()
                self.pushVC(vc)
                break
            case 1:
                let vc = ObservableViewController()
                self.pushVC(vc)
                break
            case 2:
                let vc = SubscribeViewController()
                self.pushVC(vc)
                break
            default:
                break
            }
            
        }).disposed(by: disppseBag)
    }
}

