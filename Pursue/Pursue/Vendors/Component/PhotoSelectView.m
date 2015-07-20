//
//  PhotoSelectView.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/7/12.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "PhotoSelectView.h"

@implementation PhotoSelectView

NSString *_tipInfo;

- (instancetype)initWithTipInfo:(NSString *)tipInfo;
{
    self = [super init];
    _tipInfo = tipInfo;
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView
{
    UIImageView *btnAddImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnAddImage"]];
    btnAddImage.frame = CGRectMake(10, 10, 60, 60);
    [self addSubview:btnAddImage];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 8, 40, 20)];
    tipLabel.text = _tipInfo;
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:tipLabel];
}

@end
