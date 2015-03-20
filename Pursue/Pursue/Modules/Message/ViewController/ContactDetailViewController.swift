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
//        self.tabBarController?.childViewControllers.first?.popToRootViewControllerAnimated(false)

//        CDChatRoomController *controller = [[CDChatRoomController alloc] init];
//        [[CDSessionManager sharedInstance] addChatWithPeerId:self.user.username];
//        controller.otherId = self.user.username;
//        controller.type = CDChatRoomTypeSingle;
//        self.tabBarController.selectedIndex = 0;
//        [nav popToRootViewControllerAnimated:NO];
//        
//        [self.tabBarController.childViewControllers.firstObject pushViewController:controller animated:YES];
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        self.navigationController?.popToRootViewControllerAnimated(false)
//        self.tabBarController?.childViewControllers.first?.pushViewController(ChatRoomViewController(), animated: true)
        
        self.navigationController?.pushViewController(ChatRoomViewController(), animated: true)
    }
}