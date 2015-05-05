//
//  Current.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/18.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class Current{
    
    class var IDFV: String{
        get{
            var idfv = SSKeychain.passwordForService(NSBundle.mainBundle().bundleIdentifier, account: "IDFV")
            if(idfv == nil)
            {
                idfv = UIDevice.currentDevice().identifierForVendor.UUIDString
                SSKeychain.setPassword(idfv, forService: NSBundle.mainBundle().bundleIdentifier, account: "IDFV")
            }
            return idfv;
        }
    }
    
    class var User: PursueUser {
        struct Static {
            // 定义静态的常量属性
            static let instance: PursueUser = PursueUser()
        }
        
        Static.instance.initUser()
        return Static.instance
    }
}