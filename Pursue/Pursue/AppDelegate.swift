//
//  AppDelegate.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/3.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        
        AVOSCloud.setApplicationId(CommonConfig.AVOSCloudApplicationId, clientKey: CommonConfig.AVOSCloudKey)
        
        toMainView()
        
        //注册消息推送
        if(Current.SystemVersion < 8.0){
            application.registerForRemoteNotificationTypes(.Badge | .Alert | .Sound)
        }else{
            let types: UIUserNotificationType = .Badge | .Sound | .Alert
            let pushSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(pushSettings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        //聊天接收推送消息必需
        var currentInstallation = AVInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackgroundWithBlock { (successed, error) -> Void in
            if(error != nil){
                println("开启推送失败")
            }
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        if (application.applicationState == UIApplicationState.Active) {
            // 转换成一个本地通知，显示到通知栏
            var localNotification = UILocalNotification()
            localNotification.userInfo = userInfo
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.alertBody = ""//[[userInfo objectForKey"aps"] objectForKey"alert"];
            localNotification.fireDate = NSDate()
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        } else {
            //可选 通过统计功能追踪通过提醒打开应用的行为
            AVAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
        
    }

    
    func toLoginView(){
        
    }
    
    func toMainView(){
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var nvc = UINavigationController(rootViewController: MainViewController())
        nvc.navigationBarHidden = true
        self.window!.rootViewController = nvc
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
    }

}

