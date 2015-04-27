//
//  MainViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/5.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class MainViewController: UITabBarController {
    
    func createView(){
        
        //关注
//        var focusBarItem = UITabBarItem(title: "关注", image: nil, selectedImage: nil)
//        var focusViewController = UINavigationController(rootViewController: FocusViewController(nibName: "FocusView", bundle: nil))
//        focusViewController.tabBarItem = focusBarItem

        //寻人
        var searchBarItem = UITabBarItem(title: "寻人", image: nil, selectedImage: nil)
        var searchViewController = UINavigationController(rootViewController: SearchViewController(nibName: "SearchViewController", bundle: nil))
        setNavigationBarStyle(searchViewController.navigationBar)
        searchViewController.tabBarItem = searchBarItem
        
        //随拍
        var recordBarItem = UITabBarItem(title: "随拍", image: nil, selectedImage: nil)
        var recordViewController = UINavigationController(rootViewController: RecordViewController(nibName: "RecordView", bundle: nil))
        setNavigationBarStyle(recordViewController.navigationBar)
        recordViewController.tabBarItem = recordBarItem
        
        //消息
        var messageBarItem = UITabBarItem(title: "消息", image: nil, selectedImage: nil)
        var messageViewController = UINavigationController(rootViewController: MessageViewController(nibName: "MessageView", bundle: nil))
        setNavigationBarStyle(messageViewController.navigationBar)
//        messageBarItem.badgeValue = "3"
        messageViewController.tabBarItem = messageBarItem
        
        //我的资料
        var profileBarItem = UITabBarItem(title: "我的资料", image: nil, selectedImage: nil)
        var profileViewController = UINavigationController(rootViewController: ProfileViewController(nibName: "ProfileViewController", bundle: nil))
        setNavigationBarStyle(profileViewController.navigationBar)
        profileViewController.tabBarItem = profileBarItem
        
        self.viewControllers = [searchViewController, recordViewController, messageViewController, profileViewController]
    }
    
    func setNavigationBarStyle(bar: UINavigationBar){
        //标题样式
        var titleAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        bar.barTintColor = CommonConfig.BaseColor
        bar.tintColor = UIColor.whiteColor()
        bar.titleTextAttributes = titleAttributes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
}