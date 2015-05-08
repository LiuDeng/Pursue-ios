//
//  Current.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/18.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class Current{
    
    /// 当前系统版本
    static let SystemVersion : Double = (UIDevice.currentDevice().systemVersion as NSString).doubleValue
    
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
            static var instance: PursueUser {
                get {
                    
                    /**
                    *  没有用户登录
                    */
                    if(AVUser.currentUser() == nil){
                        //登录为匿名用户
                        var idfvPwd = SSKeychain.passwordForService("PursueUser", account: Current.IDFV)
                        if(idfvPwd != nil){
                            PursueUser.logInWithUsername(Current.IDFV, password: Current.IDFV, error: nil)
                        }else{
                            var user = PursueUser()
                            user.username = Current.IDFV
                            user.password = Current.IDFV
                            if(user.signUp(nil)){
                                PursueUser.logInWithUsername(Current.IDFV, password: Current.IDFV, error: nil)
                            }else{
                                println("注册失败")
                            }
                        }
                        println("登录匿名")
                    }else{
                        println("已经登录")
                    }
                    return AVUser.currentUser() as! PursueUser
                }
            }
        }
        
        return Static.instance
    }
}