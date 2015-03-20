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
                for user in objects {
                    self.contacts.append(PursueUser(avUser: user as! AVUser))
                }
                block()
            }else{
                println(error)
            }
        }
        
    }
}