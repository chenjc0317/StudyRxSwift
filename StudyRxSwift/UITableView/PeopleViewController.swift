//
//  PeopleViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/14.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PeopleViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    /// viewModel
    let peopleViewModel = PeopleViewModel()
    /// RxSwift垃圾袋
    let disppseBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "table"
        initTableView()
    }
    
    func initTableView(){
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        /**
         #为tableview注册cell，并通过闭包赋值给cell
         #.disposed 自动回收
         */
        peopleViewModel.data.bind(to: myTableView.rx.items(cellIdentifier: "myCell")){_,model,cell in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = String(model.age)
        }.disposed(by: disppseBag)
        /**
        #model选择 选择了哪个model
        #.disposed 自动回收
        */
        myTableView.rx.modelSelected(PeopleModel.self).subscribe(onNext:{ people in
            print("选择了\(people)")
        }).disposed(by: disppseBag)
        /**
        #tableViewItem选择 
        #.disposed 自动回收
        */
        myTableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.myTableView.deselectRow(at: indexPath, animated: true)
            print("选择了\(indexPath.row)行")
        }).disposed(by: disppseBag)
    }
}
