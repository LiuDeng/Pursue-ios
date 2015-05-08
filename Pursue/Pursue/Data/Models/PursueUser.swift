//
//  PursueUser.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/14.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class PursueUser: AVUser, AVSubclassing {
    
    static func parseClassName() -> String! {
        return "_User"
    }
    
    /// 昵称
    var displayName: String?
    
    /// 签名
    var signature: String?
    
    /// 头像
    var avatar: AVFile?
    
    /// 匿名用户
    var isAnonymous: Bool? = true
    
//    init(objectId: String){
//        super.init()
//        
//        self.objectId = objectId
//        
//        refresh()
//    }

}