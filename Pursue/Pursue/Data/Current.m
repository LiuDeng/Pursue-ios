//
//  Current.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/13.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "Current.h"
#import <SSKeychain/SSKeychain.h>
#import "UIKit/UIKit.h"

@implementation Current

+ (NSString *) IDFV
{
    NSString *idfv = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:@"IDFV"];
    if(idfv == nil)
    {
        idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
        [SSKeychain setPassword:idfv forService:[NSBundle mainBundle].bundleIdentifier account:@"IDDF"];
    }
    return idfv;
}

@end
