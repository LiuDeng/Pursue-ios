//
//  Current.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/18.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class Current{
    
    class var User: PursueUser {
        struct Static {
            // 定义静态的常量属性
            static let instance: PursueUser = PursueUser()
        }
        
        Static.instance.initUnregisteredUser()
        return Static.instance
    }
}