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
    
    var conversations = []
    
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
        loadData()
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
    
    func loadData(){
        LeanChatManager.sharedInstance.findRecentConversationsWithBlock { (objects, error) -> Void in
            if(error == nil){
                self.conversations = objects
                self.messageListTableView.reloadData()
            }
        }
    }
    
    //  MARK:TableView 代理
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = (self.conversations[indexPath.row] as! AVIMConversation).members.first as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var userId = (self.conversations[indexPath.row] as! AVIMConversation).members.first as! String
    
        var controller = ChatRoomViewController()
        controller.openConversation([userId], completion: { (success, conversation) -> Void in
            if(success){
                controller.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(controller, animated: true)            }
        })
    }
    
    //  MARK:业务方法
    func sessionUpdated(notification: NSNotification){
        
    }
    
    func toContactListView(sender: AnyObject?){
        self.navigationController?.pushViewController(ContactListViewController(nibName: "ContactListView", bundle: nil), animated: true)
    }
    
}