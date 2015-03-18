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
        
        PursueDatabase.createTable("messages", createSql: "create table \"messages\" (\"fromid\" text, \"toid\" text, \"type\" text, \"message\" text, \"object\" text, \"time\" integer)")
        PursueDatabase.createTable("sessions", createSql: "create table \"sessions\" (\"type\" integer, \"otherid\" text)")
        
        session.sessionDelegate = self
        session.signatureDelegate = self
        
        AVGroup.setDefaultDelegate(self)
        session.openWithPeerId(PursueUser.currentUser.userName)
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