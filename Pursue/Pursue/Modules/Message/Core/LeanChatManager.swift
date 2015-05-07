//
//  LeanChatManager.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/5/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

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
    
    func openSessionWithClientId(clientId: String, completion: AVIMBooleanResultBlock){
        selfClientId = clientId
        if(leanClient.status.value == AVIMClientStatusNone.value){
            self.leanClient.openWithClientId(clientId, callback: completion)
        }else{
            self.leanClient.closeWithCallback({ (success, error) -> Void in
                self.leanClient.openWithClientId(clientId, callback: completion)
            })
        }
    }
    
    func createConversationsWithClientIds(clientIds: [String], conversationType: ConversationType, completion: (success: Bool, conversation:AVIMConversation?) -> Void){
        createConversationsWithClientIds(clientIds, conversationType: conversationType.rawValue, completion: completion)
    }
    
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

    
    //MARK: - AVIMClientDelegate
    
    func conversation(conversation: AVIMConversation!, didReceiveCommonMessage message: AVIMMessage!) {
        delegate?.didReceiveCommonMessageCompletion(conversation, message: message)
    }
    
    func conversation(conversation: AVIMConversation!, didReceiveTypedMessage message: AVIMTypedMessage!) {
        delegate?.didReceiveTypedMessageCompletion(conversation, message: message)
        
    }
    
}