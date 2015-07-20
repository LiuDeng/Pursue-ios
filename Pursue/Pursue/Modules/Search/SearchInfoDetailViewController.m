//
//  SearchInfoDetailViewController.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/24.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "SearchInfoDetailViewController.h"
#import "MatchingTableViewController.h"
#import "CommentTableViewController.h"
#import <Masonry.h>
#import "UIColor+Util.h"
#import <Foundation/Foundation.h>


@interface SearchInfoDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *searchUserImageView;
@property (nonatomic, strong) UILabel *searchUserNameLabel;
@property (nonatomic, strong) UILabel *searchUserSexLabel;
@property (nonatomic, strong) UILabel *searchUserBirthdayLabel;
@property (nonatomic, strong) UILabel *searchUserLostTimeLabel;
@property (nonatomic, strong) UILabel *searchUserLostLocationLabel;
@property (nonatomic, strong) UILabel *searchUserFeatureLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation SearchInfoDetailViewController

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
    
    _searchUserImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"image_placeholder"]];
    [_scrollView addSubview:_searchUserImageView];
    
    [_searchUserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.offset(screenWidth - 28);
        make.height.offset(screenWidth - 28);
//        make.top.offset(74);
    }];
    
    _searchUserNameLabel = [[UILabel alloc] init];
    _searchUserNameLabel.text = @"走失人";
    _searchUserNameLabel.font = [UIFont systemFontOfSize:16];
    _searchUserNameLabel.textColor = [UIColor lightColor];
    [_scrollView addSubview:_searchUserNameLabel];
    
    [_searchUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchUserImageView.mas_bottom).offset(14);
        make.left.equalTo(_searchUserImageView.mas_left);
    }];
    
    
    _searchUserSexLabel = [[UILabel alloc] init];
    _searchUserSexLabel.text = @"男";
    _searchUserSexLabel.font = [UIFont systemFontOfSize:14];
    _searchUserSexLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:_searchUserSexLabel];
    
    [_searchUserSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(_searchUserNameLabel.mas_baseline);
        make.left.equalTo(_searchUserNameLabel.mas_right).offset(14);
    }];
    
    _searchUserBirthdayLabel = [[UILabel alloc] init];
    _searchUserBirthdayLabel.text = @"生于2012-10-1";
    _searchUserBirthdayLabel.font = [UIFont systemFontOfSize:14];
    _searchUserBirthdayLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:_searchUserBirthdayLabel];
    
    [_searchUserBirthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(_searchUserNameLabel.mas_baseline);
        make.left.equalTo(_searchUserSexLabel.mas_right).offset(14);
    }];
    
    //丢失时间
    UILabel *lostTimeTagLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    lostTimeTagLabel.text = @"时间：";
    lostTimeTagLabel.font = [UIFont systemFontOfSize:14];
    lostTimeTagLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:lostTimeTagLabel];
    
    [lostTimeTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchUserNameLabel.mas_bottom).offset(14);
        make.left.equalTo(_searchUserNameLabel.mas_left);
    }];
    
    _searchUserLostTimeLabel = [[UILabel alloc] init];
    _searchUserLostTimeLabel.text = @"2014-4-18";
    _searchUserLostTimeLabel.font = [UIFont systemFontOfSize:14];
    _searchUserLostTimeLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:_searchUserLostTimeLabel];
    
    [_searchUserLostTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _searchUserLostLocationLabel = [[UILabel alloc] init];
    _searchUserLostLocationLabel.text = @"杭州市拱墅区运河广场";
    _searchUserLostLocationLabel.font = [UIFont systemFontOfSize:14];
    _searchUserLostLocationLabel.textColor = [UIColor textColor];
    [_scrollView addSubview:_searchUserLostLocationLabel];
    
    [_searchUserLostLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _searchUserFeatureLabel = [[UILabel alloc] init];
    _searchUserFeatureLabel.text = @"脸上有疤，左手手背有黑痣，身高110cm，高鼻梁，有两颗虎牙，双眼皮";
    _searchUserFeatureLabel.font = [UIFont systemFontOfSize:14];
    _searchUserFeatureLabel.textColor = [UIColor textColor];
    _searchUserFeatureLabel.numberOfLines = 5;
    _searchUserFeatureLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_scrollView addSubview:_searchUserFeatureLabel];
    
    [_searchUserFeatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(_searchUserFeatureLabel.mas_bottom).offset(8);
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
