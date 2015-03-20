//
//  Message.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/19.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class Message : NSObject {//JSQMessageData
    var text_: String
    var sender_: String
    var date_: NSDate
    var imageUrl_: String?
    
    convenience init(text: String?, sender: String?) {
        self.init(text: text, sender: sender, imageUrl: nil)
    }
    
    init(text: String?, sender: String?, imageUrl: String?) {
        self.text_ = text!
        self.sender_ = sender!
        self.date_ = NSDate()
        self.imageUrl_ = imageUrl
    }
    
    func senderId() -> String! {
        return sender_;
    }
    
    func senderDisplayName() -> String! {
        return sender_;
    }
    
    func text() -> String! {
        return text_;
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
    func hash() -> Int?{
        return nil
    }
    
    func isMediaMessage() -> Bool{
        return false
    }
    
//    func media() -> JSQMessageMediaData? {
//        return nil
//    }
}