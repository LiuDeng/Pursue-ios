//
//  PursueIO.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/16.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class PursueIO {
    class var sharedInstance: PursueIO {
        struct Static {
            // 定义静态的常量属性
            static let instance: PursueIO = PursueIO()
        }
        return Static.instance
    }
    
    let fileManager: NSFileManager = NSFileManager()
    
    /// 沙盒根目录
    let home = NSHomeDirectory()
    
    /// 临时目录
    let tmp = NSTemporaryDirectory()
    
    /// document目录
    var document: String {
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths[0] as! String
    }
    
    /// 模板文件路径
    var templateRoot: String{
        return "\(document)/Templates"
    }
    
    /// 缓存目录
    var cache: NSString {
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths[0] as! NSString
    }
    
    /**
    判断目录是否存在
    
    :param: path     路径
    :param: rootPath 上级目录位置，nil则在document目录
    
    :returns: 是否存在
    */
    class func directoryExist(path: String, rootPath: NSString? = nil) -> Bool{
        
        var r = sharedInstance.document
        if(rootPath != nil){
            r = rootPath! as String
        }
        
        var isDir = ObjCBool(true)
        return sharedInstance.fileManager.fileExistsAtPath(r + "/" + path, isDirectory: &isDir)
    }
    
    /**
    创建目录
    
    :param: dir      目录名称
    :param: rootPath 上级目录位置，nil则在document目录
    */
    class func createDirectory(dir: String, rootPath: NSString? = nil){
        if(!directoryExist(dir, rootPath: rootPath))
        {
            var r = sharedInstance.document
            if(rootPath != nil){
                r = rootPath! as String
            }
            
            sharedInstance.fileManager.createDirectoryAtPath(r + "/" + dir, withIntermediateDirectories: true, attributes: nil, error: nil)
        }
    }
    
    /**
    判断文件是否存在
    
    :param: path     路径
    :param: rootPath 上级目录位置，nil则在document目录
    
    :returns: 是否存在
    */
    class func fileExist(path: String, rootPath: NSString? = nil) -> Bool{
        
        var r = sharedInstance.document
        if(rootPath != nil){
            r = rootPath! as String
        }
        
        var isDir = ObjCBool(false)
        return sharedInstance.fileManager.fileExistsAtPath(r + "/" + path, isDirectory: &isDir)
    }
    
    /**
    加载文件
    
    :param: path     路径
    :param: rootPath 上级目录位置，nil则在document目录
    
    :returns: 文件NSData数据
    */
    class func loadFile(path: String, rootPath: NSString? = nil) -> NSData {
        var r = sharedInstance.document
        if(rootPath != nil){
            r = rootPath! as String
        }
        
        var filePath = r.stringByAppendingString(path)
        return NSData(contentsOfFile: filePath)!
    }
}