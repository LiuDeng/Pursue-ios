//
//  PursueUser.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/7.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "PursueUser.h"
#import "Current.h"

@implementation PursueUser

+ (void) registeAnonymous: (AVBooleanResultBlock)block;
{
    PursueUser *user = [PursueUser user];
    user.username = [Current IDFV];
    user.password = @"findmylove";
    user.displayName = @"匿名用户";
    [user signUpInBackgroundWithBlock: block];
}

@end
