//
//  CommentTableViewCell.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/7/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "TTTAttributedLabel.h"
#import "UIColor+Util.h"
#import <Masonry.h>


@interface CommentTableViewCell()

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) TTTAttributedLabel *summaryLabel;

@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    _userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"default_user_avatar"]];
    _userImageView.frame = CGRectMake(14, 14, 62, 62);
    [_userImageView.layer setCornerRadius:CGRectGetHeight([_userImageView bounds]) / 2];
    _userImageView.layer.masksToBounds = YES;
    [self addSubview:_userImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"匿名用户";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor lightColor];
    [self addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImageView.mas_top);
        make.left.equalTo(_userImageView.mas_right).offset(14);
    }];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.text = @"2015-3-6 10:22";
    _dateLabel.font = [UIFont systemFontOfSize:14];
    _dateLabel.textColor = [UIColor textColor];
    [self addSubview:_dateLabel];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_top);
        make.left.equalTo(_titleLabel.mas_right).offset(14);
    }];
    
    _summaryLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _summaryLabel.font = [UIFont systemFontOfSize:12];
    _summaryLabel.numberOfLines = 3;
    _summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _summaryLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    _summaryLabel.textColor = [UIColor textColor];
    _summaryLabel.text = @"情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述";
    [self addSubview:_summaryLabel];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).offset(4);
        make.right.equalTo([super mas_right]).offset(-14);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
