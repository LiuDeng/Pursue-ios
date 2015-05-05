//
//  ChatUser.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/5/4.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

/**
*  聊天用户对象，在不同的房间，对象不同
*/
class ChatUser: AVObject{
    
    var chatRoomId = ""
    
    /**
    *  显示名字
    */
    var displayName = "追寻人"
    
    /**
    *  最后阅读时间
    */
    var lastReadTime = NSDate()
    
    /**
    *  未读消息数
    */
    var unreadCount = 0
    
    /**
    *  对应的 app 用户
    */
//    var user: PursueUser
    var userName = ""
    
    
    init(pursueUser:PursueUser){
//        user = pursueUser
        userName = pursueUser.userName
        super.init()
    }
    
}