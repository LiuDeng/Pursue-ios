//
//  RecordInfoDetailViewController.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/24.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "RecordInfoDetailViewController.h"
#import "MatchingTableViewController.h"
#import "CommentTableViewController.h"
#import <Masonry.h>
#import "UIColor+Util.h"
#import <Foundation/Foundation.h>


@interface RecordInfoDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *RecordUserImageView;
@property (nonatomic, strong) UILabel *RecordUserNameLabel;
@property (nonatomic, strong) UILabel *RecordUserSexLabel;
@property (nonatomic, strong) UILabel *RecordUserBirthdayLabel;
@property (nonatomic, strong) UILabel *RecordUserLostTimeLabel;
@property (nonatomic, strong) UILabel *RecordUserLostLocationLabel;
@property (nonatomic, strong) UILabel *RecordUserFeatureLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation RecordInfoDetailViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];

    [self initSubviews];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - about subviews
- (void)initSubviews {
    
    double screenWidth = [UIScreen mainScreen].bounds.size.width;    
    _scrollView = self.mainScrollView;//[[UIScrollView alloc] initWithFrame: CGRectZero];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
    }];
    
    _RecordUserImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"image_placeholder"]];
    [_scrollView addSubview:_RecordUserImageView];
    
    [_RecordUserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.offset(screenWidth - 28);
        make.height.offset(screenWidth - 28);
//        make.top.offset(74);
    }];
    
    _RecordUserNameLabel = [[UILabel alloc] init];
    _RecordUserNameLabel.text = @"路边人";
    _RecordUserNameLabel.font = [UIFont systemFontOfSize:16];
    _RecordUserNameLabel.textColor = [UIColor lightColor];
    [_scrollView addSubview:_RecordUserNameLabel];
    
    [_RecordUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_RecordUserImageView.mas_bottom).offset(14);
        make.left.equalTo(_RecordUserImageView.mas_left);
    }];
    
    
    _RecordUserSexLabel = [[UILabel alloc] init];
    _RecordUserSexLabel.text = @"男";
    _RecordUserSexLabel.font = [UIFont systemFontOfSize:14];
    _RecordUserSexLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:_RecordUserSexLabel];
    
    [_RecordUserSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(_RecordUserNameLabel.mas_baseline);
        make.left.equalTo(_RecordUserNameLabel.mas_right).offset(14);
    }];
    
//    _RecordUserBirthdayLabel = [[UILabel alloc] init];
//    _RecordUserBirthdayLabel.text = @"生于2012-10-1";
//    _RecordUserBirthdayLabel.font = [UIFont systemFontOfSize:14];
//    _RecordUserBirthdayLabel.textColor = [UIColor textColor];
//    [_scrollView addSubview:_RecordUserBirthdayLabel];
    
    [_RecordUserBirthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(_RecordUserNameLabel.mas_baseline);
        make.left.equalTo(_RecordUserSexLabel.mas_right).offset(14);
    }];
    
    //丢失时间
    UILabel *lostTimeTagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    lostTimeTagLabel.text = @"时间：";
    lostTimeTagLabel.font = [UIFont systemFontOfSize:14];
    lostTimeTagLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:lostTimeTagLabel];
    
    [lostTimeTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_RecordUserNameLabel.mas_bottom).offset(14);
        make.left.equalTo(_RecordUserNameLabel.mas_left);
    }];
    
    _RecordUserLostTimeLabel = [[UILabel alloc] init];
    _RecordUserLostTimeLabel.text = @"2014-4-18";
    _RecordUserLostTimeLabel.font = [UIFont systemFontOfSize:14];
    _RecordUserLostTimeLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:_RecordUserLostTimeLabel];
    
    [_RecordUserLostTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(lostTimeTagLabel.mas_baseline);
        make.left.equalTo(lostTimeTagLabel.mas_right).offset(10);
    }];
    
    //丢失地点
    UILabel *lostLocationTagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    lostLocationTagLabel.text = @"地点：";
    lostLocationTagLabel.font = [UIFont systemFontOfSize:14];
    lostLocationTagLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:lostLocationTagLabel];
    
    [lostLocationTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lostTimeTagLabel.mas_bottom).offset(8);
        make.left.equalTo(lostTimeTagLabel.mas_left);
    }];
    
    _RecordUserLostLocationLabel = [[UILabel alloc] init];
    _RecordUserLostLocationLabel.text = @"杭州市拱墅区运河广场";
    _RecordUserLostLocationLabel.font = [UIFont systemFontOfSize:14];
    _RecordUserLostLocationLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:_RecordUserLostLocationLabel];
    
    [_RecordUserLostLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(lostLocationTagLabel.mas_baseline);
        make.left.equalTo(lostLocationTagLabel.mas_right).offset(10);
    }];
    
    //走失人特征
    UILabel *featureTagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    featureTagLabel.text = @"特征：";
    featureTagLabel.font = [UIFont systemFontOfSize:14];
    featureTagLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:featureTagLabel];
    
    [featureTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lostLocationTagLabel.mas_bottom).offset(8);
        make.left.equalTo(lostTimeTagLabel.mas_left);
        make.right.equalTo(lostTimeTagLabel.mas_right);
    }];
    
    _RecordUserFeatureLabel = [[UILabel alloc] init];
    _RecordUserFeatureLabel.text = @"脸上有疤，左手手背有黑痣，身高110cm，高鼻梁，有两颗虎牙，双眼皮";
    _RecordUserFeatureLabel.font = [UIFont systemFontOfSize:14];
    _RecordUserFeatureLabel.textColor = [UIColor textColor];
    _RecordUserFeatureLabel.numberOfLines = 5;
    _RecordUserFeatureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_scrollView addSubview:_RecordUserFeatureLabel];
    
    [_RecordUserFeatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(featureTagLabel.mas_top);
        make.left.equalTo(featureTagLabel.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-14);
    }];
    
    //走失过程
    UILabel *descriptionTagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    descriptionTagLabel.text = @"描述：";
    descriptionTagLabel.font = [UIFont systemFontOfSize:14];
    descriptionTagLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:descriptionTagLabel];
    
    [descriptionTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_RecordUserFeatureLabel.mas_bottom).offset(8);
        make.left.equalTo(lostTimeTagLabel.mas_left);
        make.right.equalTo(lostTimeTagLabel.mas_right);
    }];
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.text = @"昨天是我今年来最难忘的日子，如果2008年最难忘的是雪灾，那么09年就是小佳的出走。\n    昨天15；00我象往常一样做家务，收被子，扫院子，大约在15；30分，小佳看到出租房里的叔叔要上街，他也想跟去，被我看到了我就拦了下来，我就接着扫我的地，之后我又淘米，洗菜之类的活，在这中间，小佳说过他要去买泡泡糖上街，我当时没把这话放在心里，在我认为他还那么小，肯定不可能一个人上街的，可是等我把家务都做好时发现他不见了。";
    _descriptionLabel.font = [UIFont systemFontOfSize:14];
    _descriptionLabel.textColor = [UIColor textColor];
    _descriptionLabel.numberOfLines = 10;
    _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_scrollView addSubview:_descriptionLabel];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descriptionTagLabel.mas_top);
        make.left.equalTo(descriptionTagLabel.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-14);
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    [self setOffset: CGPointMake(0, _descriptionLabel.frame.origin.y + _descriptionLabel.frame.size.height - 20)];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
    [self setOffset: CGPointMake(0, _descriptionLabel.frame.origin.y + _descriptionLabel.frame.size.height - 20)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - pager

- (NSUInteger)numberOfTabsForViewPager:(DetailViewController *)viewPager
{
    return 2;
}

- (UIView *)viewPager:(DetailViewController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    UILabel* label = [UILabel new];
    label.text = index == 0 ? @"疑似匹配(2)" : @"评论(14)";
    [label sizeToFit];
    return label;
}

- (UIViewController *)viewPager:(DetailViewController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    if(index == 0){
        return [[MatchingTableViewController alloc] init];
    }else{
        return [[CommentTableViewController alloc] init];
    }
}
@end
