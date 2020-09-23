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
    
    lazy var updateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("更新", for: .normal)
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(updateBtnChick), for: .touchUpInside)
        btn.backgroundColor = .blue
        return btn
    }()
    lazy var resetButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("复位", for: .normal)
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(resetBtnChick), for: .touchUpInside)
        btn.backgroundColor = .blue
        return btn
    }()
    ///DiffableDataSource类型的数据源
    private var dataSource : UITableViewDiffableDataSource<DiffableDataSourceSection,DiffableDataSourceModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.myTableView.delegate = self
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
        
        let dataSoyrceList = [dataSourceList01,dataSourceList02]
        self.dataSource = getDataSource()
        updateData(dataSoyrceList)
        
        self.view.addSubview(updateButton)
        updateButton.snp.makeConstraints { (make) in
            make.width.equalTo((UIScreen.main.bounds.width - 50 ) * 0.5)
            make.height.equalTo(40)
            make.bottom.equalTo(-100)
            make.right.equalTo(-15)
        }
        self.view.addSubview(resetButton)
        resetButton.snp.makeConstraints { (make) in
            make.width.equalTo((UIScreen.main.bounds.width - 50 ) * 0.5)
            make.height.equalTo(40)
            make.bottom.equalTo(-100)
            make.left.equalTo(15)
        }

        myTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.refreshUpdate()
        })
    }
    
    func getDataSource() -> UITableViewDiffableDataSource<DiffableDataSourceSection, DiffableDataSourceModel>? {
        return UITableViewDiffableDataSource(tableView: self.myTableView) { (tableView, indexPath, note) -> UITableViewCell? in
            let cell = UITableViewCell()
            cell.textLabel?.text = note.content
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
    
    @objc func updateBtnChick(){
        let dataSourceList01 = [
            DiffableDataSourceModel(id: 2, content: "iPhone8"),
            DiffableDataSourceModel(id: 3, content: "iPhone8 plus"),
            DiffableDataSourceModel(id: 4, content: "iPhone X")]
        let dataSourceList02 = [
            DiffableDataSourceModel(id: 6, content: "iPhone 11"),
            DiffableDataSourceModel(id: 7, content: "iPhone 11 Pro"),
            DiffableDataSourceModel(id: 8, content: "iPhone 11 ProMax")]
        
        let dataSoyrceList = [dataSourceList01,dataSourceList02]
        updateData(dataSoyrceList)
        
    }
    @objc func resetBtnChick(){
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
        
        let dataSoyrceList = [dataSourceList01,dataSourceList02]
        updateData(dataSoyrceList)
        
    }
    
    func refreshUpdate(){
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
        
        let dataSoyrceList = [dataSourceList01,dataSourceList02]
        updateData(dataSoyrceList)
        
        myTableView.mj_header?.endRefreshing()
    }
}

extension DiffableDataSourceViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let section = dataSource.itemIdentifier(for: indexPath){
            print("选择了",section.content)
        }
        print("section",indexPath.section)
        print("row",indexPath.row)
    }
}
