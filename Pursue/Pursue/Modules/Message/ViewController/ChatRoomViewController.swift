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

    override func viewDidLoad() {
        super.viewDidLoad()
        LeanChatManager.sharedInstance.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func openConversation(clientIds: [String], completion: (success: Bool, conversation:AVIMConversation?) -> Void){
        println("\(Current.User.objectId)打开会话")
        LeanChatManager.sharedInstance.createConversationsWithClientIds(clientIds, conversationType: ConversationType.Single, completion: { (success, conversation) -> Void in
            self.conversation = conversation
            completion(success: success, conversation: conversation)
        })
    }
    
    func didReceiveCommonMessageCompletion(conversation: AVIMConversation, message: AVIMMessage){
//        var message = self.displayMessageByAVIMTypedMessage(message)
//        self.messages.addObject(message!)
        var new_message = self.displayMessageByAVIMTypedMessage(message as! AVIMTextMessage)
        self.messages.addObject(new_message!)
        println(new_message)
        self.messageTableView.reloadData()
        scrollToBottomAnimated(true)
    }
    
    func didReceiveTypedMessageCompletion(conversation: AVIMConversation, message: AVIMTypedMessage){
        var new_message = self.displayMessageByAVIMTypedMessage(message)
        self.messages.addObject(new_message!)
        println("收到富媒体消息")
        self.messageTableView.reloadData()
        scrollToBottomAnimated(true)
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
                self.scrollToBottomAnimated(true)
                self.finishSendMessageWithBubbleMessageType(XHBubbleMessageMediaType.Text)
            }else{
                println("消息发送错误")
                println(error)
            }
        })
    }
    
    override func shouldLoadMoreMessagesScrollToTop() -> Bool {
        return true
    }
    
    override func shouldPreventScrollToBottomWhileUserScrolling() -> Bool {
        return true
    }
}