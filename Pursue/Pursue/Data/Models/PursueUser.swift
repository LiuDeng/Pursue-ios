//
//  PursueUser.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/14.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class PursueUser{
    
    class var sharedInstance: PursueUser {
        struct Static {
            // 定义静态的常量属性
            static let instance: PursueUser = PursueUser()
        }
        return Static.instance
    }
    
    init(){
        
        if(AVUser.currentUser() == nil){
            var userName: AnyObject? = TMCache.sharedCache().objectForKey("CurrentUserName")
            if(userName == nil){
                userName = "111111"
            }
            
            var password = SSKeychain.passwordForService("PursueUser", account: userName as! String)
            if(password == nil){
                password = "111111"
            }
            login(userName as! String, password: password)
        }else{
            var u = AVUser.currentUser()
            println(u.username)
        }
    }
    
    var avUser: AVUser{
        get{
            return AVUser.currentUser()
        }
    }
    
    //登录
    func login(userName: String, password: String ){
        AVUser.logInWithUsernameInBackground(userName, password: password) { (user: AVUser?, error) -> Void in
            if((user) != nil){
                TMCache.sharedCache().setObject(userName, forKey: "CurrentUserName")
                SSKeychain.setPassword(password, forService: "PursueUser", account: userName)

                var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                delegate.toMainView()
                
            }else{

//                NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [errorAlertView show];
            }
        }
    }
}