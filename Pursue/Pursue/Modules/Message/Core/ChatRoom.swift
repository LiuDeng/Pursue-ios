//
//  ChatRoom.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/4/30.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

enum ConversationType : Int{
    case Single = 0
    case Group
}

class ChatRoom: NSObject {
    
    /**
    *  唯一编号
    */
    var id = ""
    
    /**
    *  房间名称
    */
    var displayName = "聊天"
    
    /**
    *  用户
    */
    var users = [AVUser]()
    
    /**
    *  单聊还是群聊
    */
    var roomType = ConversationType.Single
    
    /**
    创建单聊
    
    :param: from 发起人
    :param: to   聊天对象
    
    :returns: 房间对象
    */
    init(from: PursueUser, to: PursueUser){
        roomType = ConversationType.Single
        
        //判断是否已经创建了聊天房间
        
        //
        users.append(from)
        users.append(to)
    }
    
    
    func save(block: (success: Bool, error: NSError!)->()){
//        var avObject = AVObject(className: RemoteObjectDefined.ChatRoom)
//        avObject.setObject(id, forKey: "id")
//        avObject.setObject(displayName, forKey: "displayName")
//        avObject.setObject(roomType.rawValue, forKey: "roomType")
//        var relation = avObject.relationforKey("users")
//        for u in users{
//            relation.addObject(u)
//        }
//        avObject.saveInBackgroundWithBlock(block)
    }
    
}