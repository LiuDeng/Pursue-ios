//
//  PursueUser.h
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/7.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface PursueUser : AVUser<AVSubclassing>


/**
 *  昵称
 */
@property (retain) NSString *displayName;
/**
 *  性别,0-未知,1-男,2-女
 */
@property (nonatomic) NSInteger sex;
/**
 *  签名
 */
@property (retain) NSString *signature;
/**
 *  头像
 */
@property (retain) AVFile *avatar;

/**
 *  积分
 */
@property (nonatomic) NSInteger credits;
/**
 *  收藏数量
 */
@property (nonatomic) NSInteger collection;
/**
 *  寻人数量
 */
@property (nonatomic) NSInteger search;
/**
 *  随拍数量
 */
@property (nonatomic) NSInteger record;

+ (void) registeAnonymous: (AVBooleanResultBlock)block;

@end
