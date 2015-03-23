//
//  ContactDetailViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/19.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ContactDetailViewController: UIViewController{
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        var rootController = self.tabBarController?.childViewControllers[2] as! UINavigationController
        
        var nav = rootController
        var controller = ChatRoomViewController()
        controller.hidesBottomBarWhenPushed = true
//        [[CDSessionManager sharedInstance] addChatWithPeerId:self.user.username];
//        controller.otherId = self.user.username;
//        controller.type = CDChatRoomTypeSingle;
        self.tabBarController?.selectedIndex = 2;
        nav.popToRootViewControllerAnimated(false)
        
        rootController.pushViewController(controller, animated: true)
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
}