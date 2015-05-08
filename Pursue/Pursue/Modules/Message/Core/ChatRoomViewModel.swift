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
    var messages = [AVIMMessage]()
    var chatRoom: ChatRoom
    
    init(chatRoom: ChatRoom ){
        self.chatRoom = chatRoom
        self.chatRoom.save { (success, error) -> () in
            println("保存成功")
        }
        self.sender = Current.User
    }
    
    /**
    从本地加载消息
    
    :param: block 回调
    */
    func loadMessagesWithBlock(block: (objects: [AnyObject]!, error: NSError!)->()) {
        
    }
}