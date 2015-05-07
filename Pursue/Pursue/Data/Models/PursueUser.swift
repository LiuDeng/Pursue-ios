//
//  PursueUser.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/14.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class PursueUser: NSObject {
    
    var avUser: AVUser?
    
    var userName: String {
        get{
            if(avUser == nil){
                return ""
            }
            return avUser!.username
        }
    }
    
    var avatar: JSQMessagesAvatarImage = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "profile_blank"), diameter: 30)
    
    override init(){
        super.init()
    }
    
    init(avUser user:AVUser){
        super.init()
        avUser = user
    }
    
    init(userName: String){
        super.init()
        avUser = loadUser(userName)
    }
    
    func loadUser(userName: String) -> AVUser?{
        var query = AVUser.query()
        query.whereKey("username", equalTo: userName)
        var user = query.getFirstObject()
        return user as? AVUser
    }
    
    
    /**
    加载用户
    */
    func initUser(){
        AVUser.logOut()
        if(AVUser.currentUser() == nil){
            loginWithAnonymous()
        }else{
            avUser = AVUser.currentUser()
            println(avUser!.username)
        }
    }
    
    /**
    登录为未注册的匿名帐号，未做异常处理
    */
    func loginWithAnonymous(){
        //判断用户是否存在
        var query = AVUser.query()
        query.whereKey(Current.IDFV, equalTo: "userName")
        var user = query.getFirstObject() as? AVUser
        if(user != nil){
            login(Current.IDFV, password: Current.IDFV)
        }else{
            user = AVUser()
            user!.username = Current.IDFV
            user!.password = Current.IDFV
            if(user!.signUp(nil)){
                login(Current.IDFV, password: Current.IDFV)
            }
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
                println(self.avUser?.username)
            }else{

//                NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [errorAlertView show];
            }
        }
    }
}