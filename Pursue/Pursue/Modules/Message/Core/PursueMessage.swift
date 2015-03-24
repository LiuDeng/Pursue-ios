//
//  PursueMessage.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/19.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class PursueMessage : NSObject, JSQMessageData {
    var _text : String
    var _senderId : String
    var _senderDisplayName : String
    var _date : NSDate
    var _isMediaMessage : Bool
    
    var _imageUrl : String?
    
    convenience init(text: String?, senderId: String?, senderDisplayName : String?, isMediaMessage : Bool) {
        self.init(text: text, senderId: senderId, senderDisplayName: senderDisplayName,  isMediaMessage : isMediaMessage, imageUrl: nil)
    }
    
    init(text: String?, senderId: String?, senderDisplayName : String?, isMediaMessage : Bool, imageUrl: String?) {
        self._text = text!
        self._senderId = senderId!
        self._date = NSDate()
        self._imageUrl = imageUrl
        self._senderDisplayName = senderDisplayName!
        self._isMediaMessage = isMediaMessage
        
    }
    
    func text() -> String! {
        return _text
    }
    
    func senderId() -> String! {
        return _senderId
    }
    
    func senderDisplayName() -> String! {
        return _senderDisplayName
    }
    
    func date() -> NSDate! {
        return _date
    }
    
    func isMediaMessage() -> Bool {
        return _isMediaMessage
    }
    
    func messageHash() -> UInt {
        return UInt(super.hash)
    }
}