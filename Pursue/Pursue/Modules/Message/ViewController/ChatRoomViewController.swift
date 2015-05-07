//
//  ChatRoomViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/19.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ChatRoomViewController: XHMessageTableViewController {
//    var clientIds: [String] = []
//    var conversation: AVIMConversation?
//    var conversationType: ConversationType = ConversationType.Single
//    
//   init(clientIds: [String]){
//        super.init(nibName: nil, bundle: nil)
//        self.clientIds = clientIds
//        if(self.clientIds.count > 1){
//            self.conversationType = ConversationType.Group
//        }
//        LeanChatManager.sharedInstance.delegate = self
//        allowsSendVoice = true
//        allowsSendMultiMedia = true
//        allowsSendFace = true
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //创建一个会话
//        LeanChatManager.sharedInstance.openSessionWithClientId(Current.IDFV, completion: { (success, error) -> Void in
//            println(error)
//
//            if(success){
//                LeanChatManager.sharedInstance.createConversationsWithClientIds(["111111"], conversationType: ConversationType.Single, completion: { (success, conversation) -> Void in
//                    self.conversation = conversation
//                })
//            }
//        })
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//    
//    func didReceiveCommonMessageCompletion(conversation: AVIMConversation, message: AVIMMessage){
////        var message = self.displayMessageByAVIMTypedMessage(message)
////        self.messages.addObject(message!)
//        println(message)
//    }
//    
//    func didReceiveTypedMessageCompletion(conversation: AVIMConversation, message: AVIMTypedMessage){
//        var message = self.displayMessageByAVIMTypedMessage(message)
//        self.messages.addObject(message!)
//    }
//    
//    
//    func displayMessageByAVIMTypedMessage(typedMessage: AVIMTypedMessage) -> XHMessage?{
//        var msgType = typedMessage.mediaType
//        var message: XHMessage?
//        var timestamp = NSDate(timeIntervalSince1970: NSTimeInterval(typedMessage.sendTimestamp / 1000))
//        var displayName = "Luce"
//        
//        switch(msgType){
//            case kAVIMMessageMediaTypeText:
//                var receiveTextMessage = typedMessage as! AVIMTextMessage
//                message = XHMessage(text: receiveTextMessage.text, sender: displayName, timestamp: timestamp)
//                break
//            default:break
//        }
//        
//        return message
//    }
//
//    
//    override func didSendTextAction(text: String!) {
//        
//        var sendTextMessage = AVIMTextMessage(text: text, attributes: nil)
//        self.conversation?.sendMessage(sendTextMessage, callback: { (success, error) -> Void in
//            if(error == nil){
//                var message = self.displayMessageByAVIMTypedMessage(sendTextMessage)
//                self.messages.addObject(message!)
//                println(message)
//                self.messageTableView.reloadData()
//            }else{
//                println("错误")
//                println(error)
//            }
//        })
//        
//
////        messageTableView.reloadData()
////        WEAKSELF
////        [self.conversation sendMessage:sendTextMessage callback:^(BOOL succeeded, NSError *error) {
////            if([weakSelf filterError:error]){
////            [weakSelf insertAVIMTypedMessage:sendTextMessage];
////            [weakSelf finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
////            }
////            }];
//    }
}