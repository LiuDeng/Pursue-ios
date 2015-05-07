//
//  MessageViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageListTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK:初始化
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "contact"), style: UIBarButtonItemStyle.Done, target: self, action: "toContactListView:")
        
        messageListTableView.delegate = self
        messageListTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messageListTableView.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sessionUpdated:", name: "NOTIFICATION_SESSION_UPDATED", object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //  MARK:TableView 代理
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//SessionManager.sharedInstance.chatRooms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //  MARK:业务方法
    func sessionUpdated(notification: NSNotification){
        messageListTableView.reloadData()
    }
    
    func toContactListView(sender: AnyObject?){
        self.navigationController?.pushViewController(ContactListViewController(nibName: "ContactListView", bundle: nil), animated: true)
    }
    
}