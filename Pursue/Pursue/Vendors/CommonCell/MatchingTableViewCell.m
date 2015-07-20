//
//  MatchingTableViewCell.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/7/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "MatchingTableViewCell.h"
#import "TTTAttributedLabel.h"
#import "UIColor+Util.h"
#import <Masonry.h>
#import <QuartzCore/QuartzCore.h>

@interface MatchingTableViewCell()

@property (nonatomic, strong) MatchingData *matchingData;

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) TTTAttributedLabel *summaryLabel;

@property (nonatomic, strong) UILabel *matchingDegreeLabel;
@property (nonatomic, strong) UIView *matchView;


@property (nonatomic, strong) CAShapeLayer *arcLayer;

@end

@implementation MatchingTableViewCell

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
    double screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    _userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"default_user_avatar"]];
    _userImageView.frame = CGRectMake(14, 14, 62, 62);
    [self addSubview:_userImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"走失人";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor lightColor];
    [self addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userImageView.mas_top);
        make.left.equalTo(_userImageView.mas_right).offset(14);
    }];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.text = @"2015-3-6 走失";
    _dateLabel.font = [UIFont systemFontOfSize:14];
    _dateLabel.textColor = [UIColor textColor];
    [self addSubview:_dateLabel];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_top);
        make.left.equalTo(_titleLabel.mas_right).offset(14);
    }];
    
    //右侧匹配数值
    
    _matchView = [[UIView alloc] init];
    [self addSubview:_matchView];
    
    [_matchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(62);
        make.height.offset(62);
        make.top.equalTo([super mas_top]).offset(14);
        make.left.equalTo([super mas_left]).offset(screenWidth - 76);
    }];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextMoveToPoint(context, 0, 90);
    CGContextAddCurveToPoint(context,  193, 320, 100, 370, 100, 370);
    CGContextStrokePath(context);
    
    /*
     * 灰色边框圆
     */
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 1.0f ;
    solidLine.strokeColor = [UIColor colorWithHex:0xEEEEEE].CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(0.0f,  0.0f, 60.0f, 60.0f));
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [_matchView.layer addSublayer:solidLine];
    
    _matchingDegreeLabel = [[UILabel alloc] init];
    _matchingDegreeLabel.text = @"50%";
    _matchingDegreeLabel.font = [UIFont systemFontOfSize:14];
    _matchingDegreeLabel.textColor = [UIColor lightColor];
    [_matchView addSubview:_matchingDegreeLabel];
    
    [_matchingDegreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_matchView.mas_centerX);
        make.centerY.equalTo(_matchView.mas_centerY).offset(-7);
    }];
    
    UILabel *matchingLabel = [[UILabel alloc] init];
    matchingLabel.text = @"匹配度";
    matchingLabel.font = [UIFont systemFontOfSize:12];
    matchingLabel.textColor = [UIColor textColor];
    [_matchView addSubview:matchingLabel];
    
    [matchingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_matchView.mas_centerX);
        make.centerY.equalTo(_matchView.mas_centerY).offset(7);
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
        make.right.equalTo(_matchView.mas_left).offset(-14);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMatchingData:(MatchingData*)matchingData {
    _matchingData = matchingData;
    _matchingData.matchingDegree = arc4random() % 100; //测试随机数
    _matchingDegreeLabel.text = [NSString stringWithFormat:@"%ld%%", (long)_matchingData.matchingDegree];
}


-(void) showAnimation{
    
    [_arcLayer removeFromSuperlayer];
    
    //画半圆
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path addArcWithCenter:CGPointMake(30, 30) radius:30 startAngle: -M_PI_2 endAngle:(M_PI_2 * 4 * _matchingData.matchingDegree / 100 - M_PI_2) clockwise:YES];
    _arcLayer = [CAShapeLayer layer];
    _arcLayer.path = path.CGPath;//46,169,230
    _arcLayer.fillColor = [UIColor clearColor].CGColor;
    _arcLayer.strokeColor=[UIColor orangeColor].CGColor;
    _arcLayer.lineWidth = 1.0f ;
    _arcLayer.frame = _matchView.frame;
    [_matchView.layer addSublayer:_arcLayer];

    //执行画圆动画
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = 1;
    bas.delegate = self;
    bas.fromValue = [NSNumber numberWithInteger:0];
    bas.toValue = [NSNumber numberWithInteger:1];
    [_arcLayer addAnimation:bas forKey:@"key"];
}

@end
