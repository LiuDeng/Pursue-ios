//
//  ChatRoomViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/19.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ChatRoomViewController: XHMessageTableViewController, LeanChatManagerDelegate {
    var clientIds: [String] = []
    var conversation: AVIMConversation?
    var conversationType: ConversationType = ConversationType.Single

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
    override func viewDidLoad() {
        super.viewDidLoad()
        LeanChatManager.sharedInstance.delegate = self
        
        //创建一个会话
        LeanChatManager.sharedInstance.openSessionWithClientId({ (success, error) -> Void in
            println(error)

            if(success){
                println("\(Current.User.objectId)打开会话")
                LeanChatManager.sharedInstance.createConversationsWithClientIds(["55473c54e4b0f83f4d8fddc5"], conversationType: ConversationType.Single, completion: { (success, conversation) -> Void in
                    self.conversation = conversation
                    println(conversation)
                })
            }
        })
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func didReceiveCommonMessageCompletion(conversation: AVIMConversation, message: AVIMMessage){
//        var message = self.displayMessageByAVIMTypedMessage(message)
//        self.messages.addObject(message!)
        var new_message = self.displayMessageByAVIMTypedMessage(message as! AVIMTextMessage)
        self.messages.addObject(new_message!)
        println(new_message)
        self.messageTableView.reloadData()
    }
    
    func didReceiveTypedMessageCompletion(conversation: AVIMConversation, message: AVIMTypedMessage){
        var new_message = self.displayMessageByAVIMTypedMessage(message)
        self.messages.addObject(new_message!)
        println("收到富媒体消息")
        self.messageTableView.reloadData()
    }
    
    
    func displayMessageByAVIMTypedMessage(typedMessage: AVIMTypedMessage) -> XHMessage?{
        var msgType = typedMessage.mediaType
        var message: XHMessage?
        var timestamp = NSDate(timeIntervalSince1970: NSTimeInterval(typedMessage.sendTimestamp / 1000))
        var displayName = "Luce"
        
        switch(msgType){
            case kAVIMMessageMediaTypeText:
                var receiveTextMessage = typedMessage as! AVIMTextMessage
                message = XHMessage(text: receiveTextMessage.text, sender: displayName, timestamp: timestamp)
                break
            default:break
        }
        
        return message
    }

    
    override func didSendTextAction(text: String!) {
        
        var sendTextMessage = AVIMTextMessage(text: text, attributes: nil)
        println(sendTextMessage)
        self.conversation?.sendMessage(sendTextMessage, callback: { (success, error) -> Void in
            if(error == nil){
                println("消息发送成功")
                var message = self.displayMessageByAVIMTypedMessage(sendTextMessage)
                self.messages.addObject(message!)
                println(message)
                self.messageTableView.reloadData()
            }else{
                println("消息发送错误")
                println(error)
            }
        })
        

//        messageTableView.reloadData()
//        WEAKSELF
//        [self.conversation sendMessage:sendTextMessage callback:^(BOOL succeeded, NSError *error) {
//            if([weakSelf filterError:error]){
//            [weakSelf insertAVIMTypedMessage:sendTextMessage];
//            [weakSelf finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
//            }
//            }];
    }
    
    override func shouldLoadMoreMessagesScrollToTop() -> Bool {
        return true
    }
    
    override func shouldPreventScrollToBottomWhileUserScrolling() -> Bool {
        return true
    }
}