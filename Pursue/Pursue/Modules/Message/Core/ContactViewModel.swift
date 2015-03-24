//
//  ContactViewModel.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/18.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ContactViewModel {
    
    var contacts: [PursueUser] = []
    
    func startFetchContactList(block:()->()) {
        var query = AVUser.query()
        query.cachePolicy = AVCachePolicy.IgnoreCache
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if(error == nil){
                for item in objects {
                    var user = item as! AVUser
                    if(user.username != Current.User.userName){
                        self.contacts.append(PursueUser(avUser: user))
                    }
                }
                block()
            }else{
                println(error)
            }
        }
        
    }
}