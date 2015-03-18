//
//  PursueUser.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/14.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class PursueUser{
    
    var avUser: AVUser?
    
    var userName: String {
        get{
            if(avUser == nil){
                return ""
            }
            return avUser!.username
        }
    }
    
    /**
    基于 UUID 创建一个未注册认证的用户
    
    :returns: PursueUser
    */
    func initUnregisteredUser(){
        
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
            avUser = AVUser.currentUser()
            println(avUser!.username)
        }
    }
    
    /**
    登录 此逻辑之后需要移动到用户登录模块
    
    :param: userName <#userName description#>
    :param: password <#password description#>
    */
    func login(userName: String, password: String ){
        AVUser.logInWithUsernameInBackground(userName, password: password) { (user: AVUser?, error) -> Void in
            if((user) != nil){
                TMCache.sharedCache().setObject(userName, forKey: "CurrentUserName")
                SSKeychain.setPassword(password, forService: "PursueUser", account: userName)
                
                self.avUser = AVUser.currentUser()
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