//
//  LeanChatManager.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/5/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

protocol LeanChatManagerDelegate{
    func didReceiveCommonMessageCompletion(conversation: AVIMConversation, message: AVIMMessage)
    func didReceiveTypedMessageCompletion(conversation: AVIMConversation, message: AVIMTypedMessage)
}

class LeanChatManager : NSObject, AVIMClientDelegate{
    
    class var sharedInstance: LeanChatManager {
        struct Static {
            // 定义静态的常量属性
            static let instance: LeanChatManager = LeanChatManager()
        }
        return Static.instance
    }
    
    var leanClient: AVIMClient
    var selfClientId: String?
    var delegate: LeanChatManagerDelegate?
    
    override init(){
        self.leanClient = AVIMClient()
        super.init()
        self.leanClient.delegate = self
    }
    
    //MARK: 会话处理
    
    /**
    打开当前用户的聊天连接
    
    :param: completion 回调
    */
    func openSessionWithClientId(completion: AVIMBooleanResultBlock){
        selfClientId = Current.User.objectId
        if(leanClient.status.value == AVIMClientStatusNone.value){
            self.leanClient.openWithClientId(selfClientId, callback: completion)
        }else{
            self.leanClient.closeWithCallback({ (success, error) -> Void in
                self.leanClient.openWithClientId(self.selfClientId, callback: completion)
            })
        }
    }
    
    /**
    创建会话
    
    :param: clientIds        参与人
    :param: conversationType 会话类型
    :param: completion       回调
    */
    func createConversationsWithClientIds(clientIds: [String], conversationType: ConversationType, completion: (success: Bool, conversation:AVIMConversation?) -> Void){
        createConversationsWithClientIds(clientIds, conversationType: conversationType.rawValue, completion: completion)
    }
    
    /**
    创建会话
    
    :param: clientIds        参与人
    :param: conversationType 会话类型
    :param: completion       回调
    */
    func createConversationsWithClientIds(clientIds: [String], conversationType: Int, completion: (success: Bool, conversation:AVIMConversation?) -> Void){
        var query = self.leanClient.conversationQuery()
        var queryClientIds = NSMutableArray(array: clientIds)
        queryClientIds.insertObject(self.selfClientId!, atIndex: 0)
        query.whereKey(kAVIMKeyMember, containsAllObjectsInArray: queryClientIds as [AnyObject])
        query.whereKey("attr.type", equalTo: conversationType)
        query.findConversationsWithCallback { (objects, error) -> Void in
            if(error != nil){
                //出错了，请稍候重试
                completion(success: false, conversation: nil)
            }else if(objects == nil || objects.count < 1 ){
                // 新建一个对话
                self.leanClient.createConversationWithName("聊天", clientIds: queryClientIds as [AnyObject], attributes: ["type": conversationType], options: AVIMConversationOptionNone, callback: { (conversation, error) -> Void in
                    var success = true
                    if(error != nil){
                        success = false
                    }
                    completion(success: success, conversation: conversation)
                })
            }else{
                // 已经有一个对话存在，继续在这一对话中聊天
                var conversation = objects.last as! AVIMConversation
                completion(success: true, conversation: conversation)
            }
        }
    }
    
    /**
    加载历史会话
    
    :param: block 回调
    */
    func findRecentConversationsWithBlock(block: AVIMArrayResultBlock){
        var query = self.leanClient.conversationQuery()
        query.whereKey(kAVIMKeyMember, containedIn: [self.selfClientId!])
        query.limit = 1000
        query.findConversationsWithCallback(block)
    }
    
    //MARK: - AVIMClientDelegate
    /**
    收到消息
    
    :param: conversation 会话对象
    :param: message      消息对象
    */
    func conversation(conversation: AVIMConversation!, didReceiveCommonMessage message: AVIMMessage!) {
        delegate?.didReceiveCommonMessageCompletion(conversation, message: message)
    }
        
    /**
    收到多媒体消息
    
    :param: conversation 会话对象
    :param: message      消息对象
    */
    func conversation(conversation: AVIMConversation!, didReceiveTypedMessage message: AVIMTypedMessage!) {
        delegate?.didReceiveTypedMessageCompletion(conversation, message: message)
        
    }
    
}