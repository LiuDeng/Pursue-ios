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
        searchViewController.tabBarItem = searchBarItem
        
        //随拍
        var recordBarItem = UITabBarItem(title: "随拍", image: nil, selectedImage: nil)
        var recordViewController = UINavigationController(rootViewController: RecordViewController(nibName: "RecordView", bundle: nil))
        recordViewController.tabBarItem = recordBarItem
        
        //消息
        var messageBarItem = UITabBarItem(title: "消息", image: nil, selectedImage: nil)
        var messageViewController = UINavigationController(rootViewController: MessageViewController(nibName: "RecordView", bundle: nil))
//        messageBarItem.badgeValue = "3"
        messageViewController.tabBarItem = messageBarItem
        
        //我的资料
        var profileBarItem = UITabBarItem(title: "我的资料", image: nil, selectedImage: nil)
        var profileViewController = UINavigationController(rootViewController: ProfileViewController(nibName: "RecordView", bundle: nil))
        profileViewController.tabBarItem = profileBarItem
        
        self.viewControllers = [searchViewController, recordViewController, messageViewController, profileViewController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
}