//
//  SideMenuViewController.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/3.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "SideMenuViewController.h"
#import "PursueUser.h"
//#import "Config.h"
#import "Utils.h"
#import "SwipableViewController.h"
//#import "PostsViewController.h"
//#import "BlogsViewController.h"
//#import "SoftwareCatalogVC.h"
//#import "SoftwareListVC.h"
#import "SettingsPage.h"
//#import "MyInfoViewController.h"
//#import "LoginViewController.h"

#import <RESideMenu.h>
#import <MBProgressHUD.h>
#import <AFNetworking.h>
#import <ReactiveCocoa.h>

@interface SideMenuViewController ()

@property (nonatomic, strong) UIViewController *reservedViewController;

@property (nonatomic, strong) NSArray *menuIcons;
@property (nonatomic, strong) NSArray *menuTitles;

@end

@implementation SideMenuViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"userRefresh" object:nil];
    
    self.tableView.bounces = NO;
    
    _menuIcons = @[@"sidemenu-settings",@"sidemenu-settings"];
    _menuTitles = @[@"鸣谢",@"设置"];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"menu-background(%dx%d)", (int)screenSize.width, (int)screenSize.height]];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:image];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    NSArray *usersInformation = [Config getUsersInformation];
    UIImage *portrait = nil;
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *portraitView = [UIImageView new];
    portraitView.contentMode = UIViewContentModeScaleAspectFit;
    [portraitView setCornerRadius:30];
    portraitView.userInteractionEnabled = YES;
    portraitView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:portraitView];
    
    if (portrait == nil) {
        portraitView.image = [UIImage imageNamed:@"default_user_avatar"];
    } else {
        portraitView.image = portrait;
    }
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = [PursueUser currentUser].displayName;
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    nameLabel.textColor = [UIColor colorWithHex:0x696969];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:nameLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(portraitView, nameLabel);
    NSDictionary *metrics = @{@"x": @([UIScreen mainScreen].bounds.size.width / 4 - 15)};
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[portraitView(60)]-10-[nameLabel]-15-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-x-[portraitView(60)]" options:0 metrics:metrics views:views]];
    
    portraitView.userInteractionEnabled = YES;
    nameLabel.userInteractionEnabled = YES;
    [portraitView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushLoginPage)]];
    [nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushLoginPage)]];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuTitles.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    cell.backgroundColor = [UIColor clearColor];
    UIView *selectedBackground = [UIView new];
    selectedBackground.backgroundColor = [UIColor colorWithHex:0xCFCFCF];
    [cell setSelectedBackgroundView:selectedBackground];
    cell.imageView.image = [UIImage imageNamed:_menuIcons[indexPath.row]];
    cell.textLabel.text = _menuTitles[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHex:0x555555];
    cell.textLabel.font = [UIFont systemFontOfSize:19];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 1: {
            SettingsPage *settingPage = [SettingsPage new];
            [self setContentViewController:settingPage];
            
            break;
        }
        default: break;
    }
}


- (void)setContentViewController:(UIViewController *)viewController
{
    viewController.hidesBottomBarWhenPushed = YES;
    UINavigationController *nav = (UINavigationController *)((UITabBarController *)self.sideMenuViewController.contentViewController).selectedViewController;
    UIViewController *vc = nav.viewControllers[0];
    vc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [nav pushViewController:viewController animated:NO];
    
    [self.sideMenuViewController hideMenuViewController];
}


#pragma mark - 点击登录

- (void)pushLoginPage
{
//    if ([Config getOwnID] == 0) {
//        [self setContentViewController:[LoginViewController new]];
//    } else {
//        return;
//    }
}

- (void)reload
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


@end
