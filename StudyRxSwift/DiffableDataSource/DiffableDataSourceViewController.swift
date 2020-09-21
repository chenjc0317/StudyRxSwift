//
//  DiffableDataSourceViewController.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/9/21.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import MJRefresh

class DiffableDataSourceViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    lazy var myButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("更新", for: .normal)
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(dataUpdate), for: .touchUpInside)
        btn.backgroundColor = .blue
        return btn
    }()
    ///DiffableDataSource类型的数据源
    private var dataSource : UITableViewDiffableDataSource<DiffableDataSourceSection,DiffableDataSourceModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let dataSourceList01 = [
            DiffableDataSourceModel(id: 2, content: "2"),
            DiffableDataSourceModel(id: 3, content: "3"),
            DiffableDataSourceModel(id: 4, content: "4"),
            DiffableDataSourceModel(id: 5, content: "5")]
        let dataSourceList02 = [
            DiffableDataSourceModel(id: 6, content: "6"),
            DiffableDataSourceModel(id: 7, content: "7"),
            DiffableDataSourceModel(id: 8, content: "8"),
            DiffableDataSourceModel(id: 9, content: "9")]
        //        let dataSourceList01 = [
        //            DiffableDataSourceModel(id: 1, content: "1"),
        //            DiffableDataSourceModel(id: 2, content: "2"),
        //            DiffableDataSourceModel(id: 3, content: "3"),
        //            DiffableDataSourceModel(id: 4, content: "4"),
        //            DiffableDataSourceModel(id: 5, content: "5")]
        //        let dataSourceList02 = [
        //            DiffableDataSourceModel(id: 6, content: "6"),
        //            DiffableDataSourceModel(id: 7, content: "7"),
        //            DiffableDataSourceModel(id: 8, content: "8"),
        //            DiffableDataSourceModel(id: 9, content: "9"),
        //            DiffableDataSourceModel(id: 10, content: "10")]
        
        let dataSoyrceList = [dataSourceList01,dataSourceList02]
        self.dataSource = getDataSource()
        updateData(dataSoyrceList)
        
        self.view.addSubview(myButton)
        myButton.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.bottom.equalTo(-100)
            make.centerX.equalToSuperview()
        }
        myTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.dataUpdate()
        })
    }
    
    func getDataSource() -> UITableViewDiffableDataSource<DiffableDataSourceSection, DiffableDataSourceModel>? {
        return UITableViewDiffableDataSource(tableView: self.myTableView) { (tableView, indexPath, note) -> UITableViewCell? in
            let cell = UITableViewCell()
            cell.backgroundColor = .lightGray
            cell.textLabel?.text = note.content
            cell.detailTextLabel?.text = String(note.id)
            return cell
        }
    }
    
    func updateData(_ noteList: [[DiffableDataSourceModel]]) {
        var snapshot = NSDiffableDataSourceSnapshot<DiffableDataSourceSection, DiffableDataSourceModel>()
        snapshot.appendSections([.today])
        snapshot.appendItems(noteList[0],toSection: .today)
        
        snapshot.appendSections([.new])
        snapshot.appendItems(noteList[1],toSection: .new)
        self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    @objc func dataUpdate(){
        let dataSourceList01 = [
            DiffableDataSourceModel(id: 1, content: "1"),
            DiffableDataSourceModel(id: 2, content: "2"),
            DiffableDataSourceModel(id: 3, content: "3"),
            DiffableDataSourceModel(id: 4, content: "4"),
            DiffableDataSourceModel(id: 5, content: "5")]
        let dataSourceList02 = [
            DiffableDataSourceModel(id: 6, content: "6"),
            DiffableDataSourceModel(id: 7, content: "7"),
            DiffableDataSourceModel(id: 8, content: "8"),
            DiffableDataSourceModel(id: 9, content: "9"),
            DiffableDataSourceModel(id: 10, content: "10")]
        
        //        let dataSourceList01 = [
        //            DiffableDataSourceModel(id: 2, content: "2"),
        //            DiffableDataSourceModel(id: 3, content: "3"),
        //            DiffableDataSourceModel(id: 4, content: "4"),
        //            DiffableDataSourceModel(id: 5, content: "5")]
        //        let dataSourceList02 = [
        //            DiffableDataSourceModel(id: 6, content: "6"),
        //            DiffableDataSourceModel(id: 7, content: "7"),
        //            DiffableDataSourceModel(id: 8, content: "8"),
        //            DiffableDataSourceModel(id: 9, content: "9")]
        
        let dataSoyrceList = [dataSourceList01,dataSourceList02]
        updateData(dataSoyrceList)
        
        myTableView.mj_header?.endRefreshing()
    }
}
