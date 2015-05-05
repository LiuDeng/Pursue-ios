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
    var chatRoom: ChatRoom
    
    init(chatRoom: ChatRoom ){
        self.chatRoom = chatRoom
        self.chatRoom.save { (success, error) -> () in
            println("保存成功")
        }
        self.sender = Current.User
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
}