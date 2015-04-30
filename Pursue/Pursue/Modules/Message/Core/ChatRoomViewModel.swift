//
//  ChatRoomViewModel.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/24.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ChatRoomViewModel{
    
    var isLoading: Bool = false
    var sender: PursueUser
    var users = [PursueUser]()
    var messages = [ChatMessage]()
    
    init(sender: PursueUser){
        self.sender = sender
    }
    
    /**
    从服务器加载消息
    
    :param: block 回调
    */
    func loadMessagesWithBlock(block: (objects: [AnyObject]!, error: NSError!)->()) {
        if isLoading == false {
            isLoading = true
            var lastMessage = messages.last
            var query = AVQuery(className: RemoteObjectDefined.ChatMessage)
            if(lastMessage != nil){
                query.whereKey("createdAt", greaterThan: lastMessage!.date())
            }
            query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error: NSError!) -> Void in
                block(objects: objects, error: error)
                self.isLoading = false
            })
        }
    }
    
    /**
    保存消息
    
    :param: message 消息对象
    :param: block   回调
    */
    func saveMessage(message: ChatMessage, block: (success: Bool, error: NSError!)->()){
        var avObject = AVObject(className: RemoteObjectDefined.ChatMessage)
        avObject.setObject(message.text(), forKey: "content")
        avObject.setObject(message.senderId(), forKey: "senderId")
        avObject.setObject("\(message.date())", forKey: "createdAt")
        avObject.saveInBackgroundWithBlock(block)
    }
}