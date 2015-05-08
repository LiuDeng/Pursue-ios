//
//  ContactListViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/15.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ContactListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contactViewModel: ContactViewModel = ContactViewModel()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "联系人"
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        contactViewModel.startFetchContactList { () -> () in
            self.contactsTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.contactsTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactViewModel.contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = contactViewModel.contacts[indexPath.row].username
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(ContactDetailViewController(nibName: "ContactDetailView", bundle: nil), animated: true)
    }
    
}