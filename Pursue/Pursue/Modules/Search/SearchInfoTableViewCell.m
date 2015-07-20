//
//  SearchInfoTableViewCell.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/24.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "SearchInfoTableViewCell.h"
#import "TTTAttributedLabel.h"
#import "UIColor+Util.h"
#import <Masonry.h>

@interface SearchInfoTableViewCell()

@property (nonatomic, strong) UIImageView *searchUserImageView;
@property (nonatomic, strong) UILabel *searchUserNameLabel;
@property (nonatomic, strong) UILabel *searchUserSexLabel;
@property (nonatomic, strong) UILabel *searchUserBirthdayLabel;
@property (nonatomic, strong) TTTAttributedLabel *summaryLabel;
@property (nonatomic, strong) UILabel *commentCountLabel;
@property (nonatomic, strong) UILabel *matchingCountLabel;
@property (nonatomic, strong) UILabel *lostDateLabel;

@end

@implementation SearchInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (NSInteger) cellHeight
{
    return 200;
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
    _searchUserImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"image_placeholder"]];
    _searchUserImageView.frame = CGRectMake(14, 14, 120, 120);
    [self addSubview:_searchUserImageView];
    
    _searchUserNameLabel = [[UILabel alloc] init];
    _searchUserNameLabel.text = @"走失人";
    _searchUserNameLabel.font = [UIFont systemFontOfSize:16];
    _searchUserNameLabel.textColor = [UIColor lightColor];
    [self addSubview:_searchUserNameLabel];
    
    [_searchUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchUserImageView.mas_top);
        make.left.equalTo(_searchUserImageView.mas_right).offset(14);
    }];
    
    
    _searchUserSexLabel = [[UILabel alloc] init];
    _searchUserSexLabel.text = @"男";
    _searchUserSexLabel.font = [UIFont systemFontOfSize:14];
    _searchUserSexLabel.textColor = [UIColor textColor];
    [self addSubview:_searchUserSexLabel];
    
    [_searchUserSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(_searchUserNameLabel.mas_baseline);
        make.left.equalTo(_searchUserNameLabel.mas_right).offset(10);
    }];
    
    _searchUserBirthdayLabel = [[UILabel alloc] init];
    _searchUserBirthdayLabel.text = @"2012-10-1生";
    _searchUserBirthdayLabel.font = [UIFont systemFontOfSize:14];
    _searchUserBirthdayLabel.textColor = [UIColor textColor];
    [self addSubview:_searchUserBirthdayLabel];
    
    [_searchUserBirthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(_searchUserNameLabel.mas_baseline);
        make.left.equalTo(_searchUserSexLabel.mas_right).offset(10);
    }];
    
    _summaryLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _summaryLabel.font = [UIFont systemFontOfSize:14];
    _summaryLabel.numberOfLines = 6;
    _summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _summaryLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    _summaryLabel.textColor = [UIColor textColor];
    _summaryLabel.text = @"情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述情况概述";
    [self addSubview:_summaryLabel];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchUserNameLabel.mas_left);
        make.right.equalTo([super mas_right]).offset(-14);
        make.top.equalTo(_searchUserNameLabel.mas_bottom).offset(14);
        make.height.equalTo([super mas_height]).offset(-104);
    }];
    
    
    
    //底部
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHex:0xe7f3ff];
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40.0);
        make.width.equalTo([super mas_width]);
        make.baseline.equalTo([super mas_baseline]);
    }];
    
    double screenWidth = [UIScreen mainScreen].bounds.size.width;
    double blockWidth = screenWidth / 3;
    
    UIImageView *commentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location" ]];
    [bottomView addSubview:commentImage];
    
    [commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.offset((blockWidth / 2) - (commentImage.frame.size.width / 2) - 20);
    }];
    
    _commentCountLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    _commentCountLabel.text = @"6条";
    _commentCountLabel.font = [UIFont systemFontOfSize:12];
    _commentCountLabel.textColor = [UIColor textColor];
    [bottomView addSubview:_commentCountLabel];
    
    [_commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(commentImage.mas_right);
    }];
    
    UIImageView *matchingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matching" ]];
    [bottomView addSubview:matchingImage];
    
    [matchingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.offset((blockWidth / 2) - (matchingImage.frame.size.width / 2) - 50 + blockWidth);
    }];
    
    _matchingCountLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    _matchingCountLabel.text = @"疑似匹配 16";
    _matchingCountLabel.font = [UIFont systemFontOfSize:12];
    _matchingCountLabel.textColor = [UIColor textColor];
    [bottomView addSubview:_matchingCountLabel];
    
    [_matchingCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(matchingImage.mas_right);
    }];
    
    _lostDateLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    _lostDateLabel.text = @"2015-4-10 走失";
    _lostDateLabel.font = [UIFont systemFontOfSize:12];
    _lostDateLabel.textColor = [UIColor textColor];
    [bottomView addSubview:_lostDateLabel];
    
    [_lostDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.centerX.equalTo(bottomView.mas_left).offset(blockWidth * 2.5);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
