//
//  SessionManager.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/16.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

enum ChatRoomType: Int{
    case Single = 1
    case Group
}

class SessionManager:NSObject, AVSessionDelegate, AVSignatureDelegate, AVGroupDelegate {
    
    class var sharedInstance: SessionManager {
        struct Static {
            // 定义静态的常量属性
            static let instance: SessionManager = SessionManager()
        }
        return Static.instance
    }
    
    var session: AVSession
    var chatRooms: NSMutableArray
    
    private override init(){
        chatRooms = NSMutableArray()
        session = AVSession()
        super.init()
        
        PursueDatabase.createTable("messages", createSql: "create table \"messages\" (\"from_id\" text, \"to_id\" text, \"type\" text, \"message\" text, \"object\" text, \"time\" integer)", overWrite: true)
        PursueDatabase.createTable("sessions", createSql: "create table \"sessions\" (\"type\" integer, \"self_id\" text, \"other_id\" text)", overWrite: true)
        
        session.sessionDelegate = self
        session.signatureDelegate = self
        
        AVGroup.setDefaultDelegate(self)
        session.openWithPeerId(Current.User.userName)
        
        loadSessionsFromDb()
        
    }
    
    func loadSessionsFromDb(){
        var results = PursueDatabase.FMDB.executeQuery("select type, self_id, other_id from sessions ", withArgumentsInArray: [])
        var peerIds = NSMutableArray();
        while(results.next()){
            var type = results.intForColumn("type").hashValue
            var otherId = results.stringForColumn("other_id")
            
            var dic = NSMutableDictionary()
            dic.setObject(type, forKey: "type")
            dic.setObject(otherId, forKey: "otherId")
            
            if (type == ChatRoomType.Single.rawValue) {
                peerIds.addObject(otherId)
            } else if (type == ChatRoomType.Group.rawValue) {
                var group = AVGroup.getGroupWithGroupId(otherId, session: session)
                group.delegate = self
                group.join()
            }
            
            chatRooms.addObject(dic)
        }
        
        session.watchPeerIds(peerIds as [AnyObject], callback: { (success, error) -> Void in
            println(success)
        })
    }
    
    
    //pragma mark - AVSessionDelegate
    func sessionOpened(session: AVSession!) {
        
    }
    
    func sessionPaused(session: AVSession!) {
        
    }
    
    func sessionResumed(session: AVSession!) {
        
    }
    
    func sessionFailed(session: AVSession!, error: NSError!) {
        
    }
    
    func session(session: AVSession!, didReceiveMessage message: AVMessage!) {
        
    }
    
    func session(session: AVSession!, messageSendFinished message: AVMessage!) {
        
    }
    
    func session(session: AVSession!, messageSendFailed message: AVMessage!, error: NSError!) {
        
    }
    
    func session(session: AVSession!, messageArrived message: AVMessage!) {
        
    }
    
    func session(session: AVSession!, didReceiveStatus status: AVPeerStatus, peerIds: [AnyObject]!) {
        
    }
    
    //pragma mark - AVGroupDelegate
    func group(group: AVGroup!, didReceiveMessage message: AVMessage!) {
        
    }
    
    func group(group: AVGroup!, didReceiveEvent event: AVGroupEvent, peerIds: [AnyObject]!) {
        
    }
    
    func group(group: AVGroup!, messageSendFinished message: AVMessage!) {
        
    }
    
    func group(group: AVGroup!, messageSendFailed message: AVMessage!, error: NSError!) {
        
    }
    
    func session(session: AVSession!, group: AVGroup!, messageSent message: String!, success: Bool) {
        
    }
    
    func signatureForPeerWithPeerId(peerId: String!, watchedPeerIds: [AnyObject]!, action: String!) -> AVSignature! {
        return nil
    }
    
    func signatureForGroupWithPeerId(peerId: String!, groupId: String!, groupPeerIds: [AnyObject]!, action: String!) -> AVSignature! {
        return nil
    }
    
    
    
}