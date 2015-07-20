//
//  XLFormValidator+Util.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/9.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "XLFormValidator+Util.h"
#import "XLFormValidator.h"
#import "XLFormRegexValidator.h"

@implementation XLFormValidator (Util)

#pragma mark - Validators


+(XLFormValidator *)emailValidatorCn
{
    return [XLFormRegexValidator formRegexValidatorWithMsg:NSLocalizedString(@"邮箱格式不正确", nil) regex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

+(XLFormValidator *)phoneValidatorCn
{
    return [XLFormRegexValidator formRegexValidatorWithMsg:NSLocalizedString(@"手机号码格式不正确", nil) regex:@"1[1-9]+[0-9]{9}"];
}

@end
