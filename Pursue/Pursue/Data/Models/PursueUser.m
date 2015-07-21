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

/**
 *  昵称
 */
@dynamic displayName;
/**
 *  性别,0-未知,1-男,2-女
 */
@dynamic sex;
/**
 *  签名
 */
@dynamic signature;
/**
 *  头像
 */
@dynamic avatar;

/**
 *  积分
 */
@dynamic credits;
/**
 *  收藏数量
 */
@dynamic collection;
/**
 *  寻人数量
 */
@dynamic search;
/**
 *  随拍数量
 */
@dynamic record;

+ (NSString *)parseClassName {
    return @"_User";
}

+ (void) registeAnonymous: (AVBooleanResultBlock)block;
{
    PursueUser *user = [PursueUser user];
    user.username = [Current IDFV];
    user.password = @"findmylove";
    user.displayName = @"匿名用户";
    [user signUpInBackgroundWithBlock: block];
}

@end
