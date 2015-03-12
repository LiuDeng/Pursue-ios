//
//  MessageViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class MessageViewController: UIViewController {
    
    @IBOutlet weak var messageListTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "联系人", style: UIBarButtonItemStyle.Done, target: self, action: nil)
    }
    
}