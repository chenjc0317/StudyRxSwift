//
//  MessageKitVC.swift
//  StudyRxSwift
//
//  Created by 亿龙iOS on 2020/10/28.
//  Copyright © 2020 亿龙iOS. All rights reserved.
//

import UIKit
import MessageKit
import Messages
import MessageUI

class MessageKitVC: UIViewController {

    var messagesCollectionView = MessagesCollectionView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(messagesCollectionView)
        
        messagesCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
