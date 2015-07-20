//
//  AppDelegate.h
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/3.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloudIM/AVIMCommon.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)openChatConnect:(AVIMBooleanResultBlock) callback;

@end

