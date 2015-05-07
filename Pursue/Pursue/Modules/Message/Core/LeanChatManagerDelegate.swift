//
//  LeanChatManagerDelegate.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/5/7.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

protocol LeanChatManagerDelegate{
    func didReceiveCommonMessageCompletion(conversation: AVIMConversation, message: AVIMMessage)
    func didReceiveTypedMessageCompletion(conversation: AVIMConversation, message: AVIMTypedMessage)
}