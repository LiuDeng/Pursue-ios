//
//  ViewController.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/3.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "SwipableViewController.h"
#import "OptionButton.h"
#import "UIView+Util.h"
#import "Current.h"
#import "Utils.h"
#import <RESideMenu/RESideMenu.h>
#import "SearchViewController.h"
#import "RecordViewController.h"
#import "CDConvsVC.h"
#import "ProfileViewController.h"
#import "SearchInfoEditViewController.h"
#import "RecordInfoEditViewController.h"
#import "PursueUser.h"
#import "CDFriendListVC.h"

#import "CDCommon.h"
#import "CDCacheManager.h"

#import "CDUtils.h"
#import "CDAddRequest.h"
#import "CDIMService.h"
#import "LZPushManager.h"


@interface MainViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIView *dimView;
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, assign) BOOL isPressed;
@property (nonatomic, strong) NSMutableArray *optionButtons;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGGlyph length;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SearchViewController *searchViewController1 = [[SearchViewController alloc]  init];
    SearchViewController *searchViewController2 = [[SearchViewController alloc]  init];
    
    RecordViewController *recordViewController1 = [[RecordViewController alloc]  init];
    RecordViewController *recordViewController2 = [[RecordViewController alloc]  init];
    
//    NewsViewController *hotNewsViewCtl = [[NewsViewController alloc]  initWithNewsListType:NewsListTypeAllTypeWeekHottest];
//    BlogsViewController *blogViewCtl = [[BlogsViewController alloc] initWithBlogsType:BlogTypeLatest];
//    BlogsViewController *recommendBlogViewCtl = [[BlogsViewController alloc] initWithBlogsType:BlogTypeRecommended];
//    
//    TweetsViewController *newTweetViewCtl = [[TweetsViewController alloc] initWithTweetsType:TweetsTypeAllTweets];
//    TweetsViewController *hotTweetViewCtl = [[TweetsViewController alloc] initWithTweetsType:TweetsTypeHotestTweets];
//    TweetsViewController *myTweetViewCtl = [[TweetsViewController alloc] initWithTweetsType:TweetsTypeOwnTweets];
//    
//    newsViewCtl.needCache = YES;
//    hotNewsViewCtl.needCache = YES;
//    blogViewCtl.needCache = YES;
//    recommendBlogViewCtl.needCache = YES;
//    
//    newTweetViewCtl.needCache = YES;
//    hotTweetViewCtl.needCache = YES;
//    myTweetViewCtl.needCache = YES;
    
    SwipableViewController *searchSVC = [[SwipableViewController alloc] initWithTitle:@"寻人"
                                                                       andSubTitles:@[@"最新", @"附近"]
                                                                     andControllers:@[searchViewController1, searchViewController2]
                                                                        underTabbar:YES];
    
    SwipableViewController *recordSVC = [[SwipableViewController alloc] initWithTitle:@"随拍"
                                                                         andSubTitles:@[@"最新", @"附近"]
                                                                       andControllers:@[recordViewController1, recordViewController2]
                                                                          underTabbar:YES];
    
    CDConvsVC *messageSVC = [[CDConvsVC alloc] init];
    messageSVC.title = @"消息";
    
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    profileVC.title = @"我的资料";

    
    self.tabBar.translucent = NO;
    self.viewControllers = @[
                             [self addNavigationItemForViewController:searchSVC],
                             [self addNavigationItemForViewController:recordSVC],
                             [UIViewController new],
                             [self addNavigationItemForViewController:messageSVC],
                             [[UINavigationController alloc] initWithRootViewController:profileVC]
                             ];
    
    NSArray *titles = @[@"寻人", @"随拍", @"", @"消息", @"我"];
    NSArray *images = @[@"search", @"record", @"", @"message", @"profile"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
    }];
    [self.tabBar.items[2] setEnabled:NO];
    
    [self addCenterButtonWithImage:[UIImage imageNamed:@"add"]];
    
    [self.tabBar addObserver:self
                  forKeyPath:@"selectedItem"
                     options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                     context:nil];
    
    // 功能键相关
    _optionButtons = [NSMutableArray new];
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    _screenWidth  = [UIScreen mainScreen].bounds.size.width;
    _length = 60;        // 圆形按钮的直径
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    NSArray *buttonTitles = @[@"寻人", @"随拍"];
    NSArray *buttonImages = @[@"search", @"record"];
    int buttonColors[] = {0xe69961, 0x61b644};
    
    for (int i = 0; i < 2; i++) {
        OptionButton *optionButton = [[OptionButton alloc] initWithTitle:buttonTitles[i]
                                                                   image:[UIImage imageNamed:buttonImages[i]]
                                                                andColor:[UIColor colorWithHex:buttonColors[i]]];
        
        optionButton.frame = CGRectMake((_screenWidth/6 * (i%3*2+1) - (_length+16)/2),
                                        _screenHeight + 150 + i/3*100,
                                        _length + 16,
                                        _length + [UIFont systemFontOfSize:14].lineHeight + 24);
        [optionButton.button setCornerRadius:_length/2];

        optionButton.tag = i;
        optionButton.userInteractionEnabled = YES;
        [optionButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOptionButton:)]];
        
        [self.view addSubview:optionButton];
        [_optionButtons addObject:optionButton];
    }
}


-(void)addCenterButtonWithImage:(UIImage *)buttonImage
{
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGPoint origin = [self.view convertPoint:self.tabBar.center toView:self.tabBar];
    CGSize buttonSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 6, self.tabBar.frame.size.height - 4);
    
    _centerButton.frame = CGRectMake(origin.x - buttonSize.height/2, origin.y - buttonSize.height/2, buttonSize.height, buttonSize.height);

    [_centerButton setCornerRadius:buttonSize.height/2];
    [_centerButton setBackgroundColor:[UIColor lightColor]];
    [_centerButton setImage:buttonImage forState:UIControlStateNormal];
    [_centerButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:_centerButton];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedItem"]) {
        if(self.isPressed) {[self buttonPressed];}
    }
}


- (void)buttonPressed
{
    [self changeTheButtonStateAnimatedToOpen:_isPressed];
    
    _isPressed = !_isPressed;
}


- (void)changeTheButtonStateAnimatedToOpen:(BOOL)isPressed
{
    if (isPressed) {
        [self removeBlurView];
        
        [_animator removeAllBehaviors];
        for (int i = 0; i < 2; i++) {
            UIButton *button = _optionButtons[i];
            
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:button
                                                                         attachedToAnchor:CGPointMake(_screenWidth/6 * (i%3*2+1),
                                                                                                      _screenHeight + 200 + i/3*100)];
            attachment.damping = 0.65;
            attachment.frequency = 4;
            attachment.length = 1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC * (6 - i)), dispatch_get_main_queue(), ^{
                [_animator addBehavior:attachment];
            });
        }
    } else {
        [self addBlurView];
        
        [_animator removeAllBehaviors];
        for (int i = 0; i < 2; i++) {
            UIButton *button = _optionButtons[i];
            [self.view bringSubviewToFront:button];
            
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:button
                                                                         attachedToAnchor:CGPointMake(_screenWidth/6 * (i%3*2+1),
                                                                                                      _screenHeight - 200 + i/3*100)];
            attachment.damping = 0.65;
            attachment.frequency = 4;
            attachment.length = 1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.02 * NSEC_PER_SEC * (i + 1)), dispatch_get_main_queue(), ^{
                [_animator addBehavior:attachment];
            });
        }
    }
}

- (void)addBlurView
{
    _centerButton.enabled = NO;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect cropRect = CGRectMake(0, screenSize.height - 270, screenSize.width, screenSize.height);
    
    UIImage *originalImage = [self.view updateBlur];
    UIImage *croppedBlurImage = [originalImage cropToRect:cropRect];
    
    _blurView = [[UIImageView alloc] initWithImage:croppedBlurImage];
    _blurView.frame = cropRect;
    _blurView.userInteractionEnabled = YES;
    [self.view addSubview:_blurView];
    
    _dimView = [[UIView alloc] initWithFrame:self.view.bounds];
    _dimView.backgroundColor = [UIColor blackColor];
    _dimView.alpha = 0.4;
    [self.view insertSubview:_dimView belowSubview:self.tabBar];
    
    [_blurView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed)]];
    [_dimView  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed)]];
    
    [UIView animateWithDuration:0.25f
                     animations:nil
                     completion:^(BOOL finished) {
                         if (finished) {_centerButton.enabled = YES;}
                     }];
}


- (void)removeBlurView
{
    _centerButton.enabled = NO;
    
    self.view.alpha = 1;
    [UIView animateWithDuration:0.25f
                     animations:nil
                     completion:^(BOOL finished) {
                         if(finished) {
                             [_dimView removeFromSuperview];
                             _dimView = nil;
                             
                             [self.blurView removeFromSuperview];
                             self.blurView = nil;
                             _centerButton.enabled = YES;
                         }
                     }];
}



#pragma mark - 处理点击事件

- (void)onTapOptionButton:(UIGestureRecognizer *)recognizer
{
    switch (recognizer.view.tag) {
        case 0: {
            SearchInfoEditViewController *searchEditVC = [SearchInfoEditViewController new];
            UINavigationController *searchEditNav = [[UINavigationController alloc] initWithRootViewController:searchEditVC];
            [self.selectedViewController presentViewController:searchEditNav animated:YES completion:nil];
            break;
        }
        case 1: {
            RecordInfoEditViewController *recordEditVC = [RecordInfoEditViewController new];
            UINavigationController *recordEditNav = [[UINavigationController alloc] initWithRootViewController:recordEditVC];
            [self.selectedViewController presentViewController:recordEditNav animated:YES completion:nil];
            break;
        }
        default: break;
    }
    
    [self buttonPressed];
}


#pragma mark -

- (UINavigationController *)addNavigationItemForViewController:(UIViewController *)viewController
{
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    viewController.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar-sidebar"]
                                                                                        style:UIBarButtonItemStylePlain
                                                                                       target:self action:@selector(onClickMenuButton)];
    if([[NSString stringWithFormat:@"%@", viewController.class]  isEqual: @"CDConvsVC"]){
        
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact_face_group_icon"]
                                                                                            style:UIBarButtonItemStylePlain
                                                                                           target:self action:@selector(pushFriendListViewController)];
        
    }else{
       
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar-search"]
                                                                                        style:UIBarButtonItemStylePlain
                                                                                       target:self action:@selector(pushSearchViewController)];
    
    }
    
    return navigationController;
}

- (void)onClickMenuButton
{
    [self.sideMenuViewController presentLeftMenuViewController];
}


#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (self.selectedIndex <= 1 && self.selectedIndex == [tabBar.items indexOfObject:item]) {
        SwipableViewController *swipeableVC = (SwipableViewController *)((UINavigationController *)self.selectedViewController).viewControllers[0];
//        OSCObjsViewController *objsViewController = (OSCObjsViewController *)swipeableVC.viewPager.childViewControllers[swipeableVC.titleBar.currentIndex];
//        
//        [UIView animateWithDuration:0.1 animations:^{
//            [objsViewController.tableView setContentOffset:CGPointMake(0, -objsViewController.refreshControl.frame.size.height)];
//        } completion:^(BOOL finished) {
//            [objsViewController.refreshControl beginRefreshing];
//        }];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [objsViewController refresh];
//        });
    }
}

#pragma mark - 处理左右navigationItem点击事件

- (void)pushSearchViewController
{
//    [(UINavigationController *)self.selectedViewController pushViewController:[CDFriendListVC new] animated:YES];
}

- (void)pushFriendListViewController
{
    [(UINavigationController *)self.selectedViewController pushViewController:[CDFriendListVC new] animated:YES];
}

@end
