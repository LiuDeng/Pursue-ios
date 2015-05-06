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

//    - (void)createConversationsWithClientIDs:(NSArray *)clientIDs
//    conversationType:(ConversationType)conversationType
//    completion:(void (^)(BOOL succeeded, AVIMConversation *createConversation))completion {
//    NSMutableArray *targetClientIDs = [[NSMutableArray alloc] initWithArray:clientIDs];
//    [targetClientIDs insertObject:self.selfClientID atIndex:0];
//    [self createConversationsOnClientIDs:targetClientIDs conversationType:conversationType completion:completion];
//    }
//    
//    - (void)createConversationsOnClientIDs:(NSArray *)clientIDs
//    conversationType:(int)conversationType
//    completion:(void (^)(BOOL, AVIMConversation *))completion {
//    AVIMConversationQuery *query = [self.leanClient conversationQuery];
//    NSMutableArray *queryClientIDs = [[NSMutableArray alloc] initWithArray:clientIDs];
//    [queryClientIDs insertObject:self.selfClientID atIndex:0];
//    [query whereKey:kAVIMKeyMember containsAllObjectsInArray:queryClientIDs];
//    [query whereKey:AVIMAttr(@"type") equalTo:[NSNumber numberWithInt:conversationType]];
//    [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
//    if (error) {
//    // 出错了，请稍候重试
//    if (completion) {
//    completion(NO, nil);
//    }
//    } else if (!objects || [objects count] < 1) {
//    // 新建一个对话
//    [self.leanClient createConversationWithName:nil
//    clientIds:queryClientIDs
//    attributes:@{@"type":[NSNumber numberWithInt:conversationType]}
//    options:AVIMConversationOptionNone
//    callback:^(AVIMConversation *conversation, NSError *error) {
//    BOOL succeeded = YES;
//    if (error) {
//    succeeded = NO;
//    }
//    if (completion) {
//    completion(succeeded, conversation);
//    }
//    }];
//    } else {
//    // 已经有一个对话存在，继续在这一对话中聊天
//    AVIMConversation *conversation = [objects lastObject];
//    if (completion) {
//    completion(YES, conversation);
//    }
//    }
//    }];
//    }

    
    //MARK: - AVIMClientDelegate
    
    func conversation(conversation: AVIMConversation!, didReceiveCommonMessage message: AVIMMessage!) {
        
    }
    
    func conversation(conversation: AVIMConversation!, didReceiveTypedMessage message: AVIMTypedMessage!) {
        
    }
    
}