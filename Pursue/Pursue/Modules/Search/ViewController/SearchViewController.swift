//
//  SearchViewController.swift
//  Pursue
//
//  Created by LiGuicai on 15/5/8.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "pen"), style: UIBarButtonItemStyle.Done,target: self, action:"rightBarButtonPressed:");
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        
        self.title = "寻人";

        initUI();
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        // FIX:版本差异
        var searchBarVC = UISearchBar(frame: CGRectMake(0, 64, self.view.frame.width, 44));
        self.view.addSubview(searchBarVC);
        
        tableView.frame = CGRectMake(0, 108, self.view.frame.width, self.view.frame.height - 108 - 44);
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "SearchInfoCell", bundle: nil), forCellReuseIdentifier: "searchInfoCell")
        
        self.view.addSubview(tableView);
    }
    
//pragma mark - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: SearchInfoCell = tableView.dequeueReusableCellWithIdentifier("searchInfoCell", forIndexPath: indexPath) as! SearchInfoCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 20))
        headerView.backgroundColor = UIColor(red:0.92, green:0.94, blue:0.94, alpha:1)
        return headerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//pragma mark - 发布
    func rightBarButtonPressed(sender:AnyObject) {
        
    }
}
