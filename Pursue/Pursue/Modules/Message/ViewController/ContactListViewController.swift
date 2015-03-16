//
//  ContactListViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/15.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "联系人"
        
        
    }
    
}