//
//  ProfileViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let UserInfoCellIdentifier = "Profile User Info Cell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var stretchView: UIView!
    var stretchableTableHeaderView:HFStretchableTableHeaderView?
    
    //  MARK: 初始化
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //  MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
        basicSetup()
    }
    
    //  MARK: 界面绘制
    private func buildUI() {
        self.navigationItem.title = "我的资料"
        
        stretchableTableHeaderView = HFStretchableTableHeaderView()
        stretchableTableHeaderView?.stretchHeaderForTableView(self.tableView, withView: stretchView)
    }
    
    //  MARK: 基本设置
    private func basicSetup() {
        tableView.registerNib(UINib(nibName: "ProfileUserInfoTableViewCell", bundle: nil),
            forCellReuseIdentifier: UserInfoCellIdentifier)
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //  MARK: 响应方法
    
    
    //  MARK: - Table View Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier(UserInfoCellIdentifier, forIndexPath: indexPath) as! ProfileUserInfoTableViewCell
            cell.accessoryType = .DisclosureIndicator
            return cell
        } else {
            let CellIdentifier = "Cell"
            var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! UITableViewCell?
            
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
            }
            
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0:break
                case 1:
                    cell?.textLabel?.text = "我的寻人"
                case 2:
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
    }
    
    //  MARK:Table View Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 80
        } else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let userInfoVC = UserInfoViewController(nibName: "UserInfoViewController", bundle: nil)
                self.navigationController?.pushViewController(userInfoVC, animated: true)
            case 1:
                println("我的寻人")
            case 2:
                println("我的随拍")
            default: break
            }
        } else {
            switch indexPath.row {
            case 0:
                println("分享一下")
            case 1:
                println("关于")
            default: break
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        stretchableTableHeaderView?.scrollViewDidScroll(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        stretchableTableHeaderView?.resizeView()
    }
    
}