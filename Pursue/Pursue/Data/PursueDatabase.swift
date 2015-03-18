//
//  PursueDatabase.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/16.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

/**
*  本地数据库操作类
*/
class PursueDatabase{
    class var sharedInstance: PursueDatabase {
        struct Static {
            // 定义静态的常量属性
            static let instance: PursueDatabase = PursueDatabase()
        }
        return Static.instance
    }

    /**
    创建本地数据表
    
    :param: tableName 表名
    :param: createSql 创建的 sql 语句
    :param: overWrite 是否覆盖原来的表
    */
    static func createTable(tableName: String, createSql: String, overWrite: Bool = false){
        if(overWrite){
            sharedInstance.db.executeUpdate("drop table \(tableName);", withArgumentsInArray: [])
            sharedInstance.db.executeUpdate(createSql, withArgumentsInArray: [])
        }else{
            if(!sharedInstance.db.tableExists(tableName)){
                sharedInstance.db.executeUpdate(createSql, withArgumentsInArray: [])
            }
        }
        
    }
    
    
    var db: FMDatabase
    
    private init(){
        if(!PursueIO.directoryExist("Core")){
            PursueIO.createDirectory("Core")
        }
        
        var dbPath = PursueIO.sharedInstance.document.stringByAppendingString("/Core/pursue.db")
        if(PursueIO.fileExist(dbPath)){
            db = FMDatabase(path: dbPath)
            db.open()
        }else{
            db = FMDatabase(path: dbPath)
            db.open()
            createTableStructure()
        }

    }
    
    /**
    创建公共表结构
    */
    private func createTableStructure(){
        
    }
}
