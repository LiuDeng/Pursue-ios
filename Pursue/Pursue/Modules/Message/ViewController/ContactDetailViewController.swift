//
//  ContactDetailViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/19.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ContactDetailViewController: UIViewController{
    
    var userId: String
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(userId: String ,nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.userId = userId
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
//        LeanChatManager.sharedInstance.openSessionWithClientId(Current.IDFV, completion: { (success, error) -> Void in
//            println(error)
//            
//            if(success){
//                LeanChatManager.sharedInstance.createConversationsWithClientIds(["111111"], conversationType: ConversationType.Single, completion: { (success, conversation) -> Void in
//                    
//                })
//            }
//        })
        
        
        var rootController = self.tabBarController?.childViewControllers[2] as! UINavigationController
        
        var nav = rootController
        var controller = ChatRoomViewController()
        controller.openConversation([self.userId], completion: { (success, conversation) -> Void in
            if(success){
                controller.hidesBottomBarWhenPushed = true
                self.tabBarController?.selectedIndex = 2;
                nav.popToRootViewControllerAnimated(false)
                
                rootController.pushViewController(controller, animated: true)
                self.navigationController?.popToRootViewControllerAnimated(false)
            }
        })
    }
}