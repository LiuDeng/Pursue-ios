//
//  ProfileViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let UserInfoCellIdentifier = "Profile User Info Cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    //  MARK:初始化
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //  MARK:生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
        basicSetup()
    }
    
    //  MARK:界面绘制
    func buildUI() {
        self.navigationItem.title = "我的资料"
    }
    
    //  MARK:基本设置
    func basicSetup() {
        self.tableView.registerNib(UINib(nibName: "ProfileUserInfoCell", bundle: nil),
            forCellReuseIdentifier: UserInfoCellIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    //  MARK: - Table View Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
        }
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "我的寻人"
            case 1:
                cell?.textLabel?.text = "我的随拍"
            default:break
            }
        } else {
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "分享一下"
            case 1:
                cell?.textLabel?.text = "关于"
            default:
                break
            }
        }
        
        cell?.accessoryType = .DisclosureIndicator
        
        return cell!
    }
    
    //  MARK:Table View Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
}