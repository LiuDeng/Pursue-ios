//
//  AppDelegate.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/3.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MainViewController.h"
#import "UIView+Util.h"
#import "UIColor+Util.h"
#import "SideMenuViewController.h"
#import <RESideMenu/RESideMenu.h>
#import "CDCommon.h"
#import "CDBaseTabC.h"
#import "CDBaseNavC.h"
#import "CDConvsVC.h"
#import "CDFriendListVC.h"
#import "CDAbuseReport.h"
#import "CDCacheManager.h"
#import "PursueUser.h"
#import "LoginViewController.h"

#import "CDUtils.h"
#import "CDAddRequest.h"
#import "CDIMService.h"
#import "LZPushManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AVOSCloud setApplicationId: AVOSAppID clientKey: AVOSAppKey];
    
    MainViewController *tabBarController = [MainViewController new];
//    tabBarController.delegate = self;

    RESideMenu *sideMenuTabBarViewController = [[RESideMenu alloc] initWithContentViewController:tabBarController
                                                                          leftMenuViewController:[SideMenuViewController new]
                                                                         rightMenuViewController:nil];
    sideMenuTabBarViewController.scaleContentView = YES;
    sideMenuTabBarViewController.contentViewScaleValue = 0.95;
    sideMenuTabBarViewController.scaleMenuView = NO;
    sideMenuTabBarViewController.contentViewShadowEnabled = YES;
    sideMenuTabBarViewController.contentViewShadowRadius = 4.5;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = sideMenuTabBarViewController;
    [self.window makeKeyAndVisible];
    
//    [self loadCookies];
    
    /************ 控件外观设置 **************/
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor lightColor]];
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    [[UITabBar appearance] setTintColor:[UIColor lightColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithHex:0xE1E1E1]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightColor]} forState:UIControlStateSelected];
    
    
    [UISearchBar appearance].tintColor = [UIColor lightColor];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setCornerRadius:14.0];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAlpha:0.6];
    
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor colorWithHex:0xDCDCDC];
    pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    
    [[UITextField appearance] setTintColor:[UIColor nameColor]];
    [[UITextView appearance]  setTintColor:[UIColor nameColor]];
    
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    [menuController setMenuVisible:YES animated:YES];
    [menuController setMenuItems:@[
                                   [[UIMenuItem alloc] initWithTitle:@"复制" action:NSSelectorFromString(@"copyText:")],
                                   [[UIMenuItem alloc] initWithTitle:@"删除" action:NSSelectorFromString(@"deleteObject:")]
                                   ]];
    
    /************ 检测通知 **************/
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    [CDAddRequest registerSubclass];
    [CDAbuseReport registerSubclass];
    [PursueUser registerSubclass];
#if USE_US
    [AVOSCloud useAVCloudUS];
#endif
    [AVOSCloud setApplicationId:AVOSAppID clientKey:AVOSAppKey];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [[LZPushManager manager] registerForRemoteNotification];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)openChatConnect:(AVIMBooleanResultBlock) callback{
    [[CDCacheManager manager] registerUsers:@[[PursueUser currentUser]]];
    WEAKSELF
    [CDChatManager manager].userDelegate = [CDIMService service];
    
#ifdef DEBUG
#warning 使用开发证书来推送，方便调试
    //[CDChatManager manager].useDevPushCerticate = YES;
#endif
    
    [[CDChatManager manager] openWithClientId:[AVUser currentUser].objectId callback: callback];

}

- (void)toFirstViewController{
    RESideMenu *menu = self.window.rootViewController;
    UITabBarController *tabbar = menu.contentViewController;
    [tabbar setSelectedIndex:0];
}
@end
