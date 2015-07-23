//
//  SettingsPage.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/3.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "SettingsPage.h"
#import "Utils.h"
//#import "Config.h"
//#import "MyInfoViewController.h"
#import "AboutPage.h"
#import "OSLicensePage.h"
#import "LCUserFeedbackViewController.h"
#import "CDSettingVC.h"
#import "PursueUser.h"
#import "CDBaseNavC.h"

#import <RESideMenu.h>
#import <MBProgressHUD.h>
#import <AFNetworking.h>
#import <SDImageCache.h>

@interface SettingsPage () <UIAlertViewDelegate>

@end

@implementation SettingsPage

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.backgroundColor = [UIColor themeColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 2;
        case 1: return 4;
            
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    NSArray *titles = @[
                        @[@"清除缓存", @"消息通知"],
                        @[@"意见反馈", @"给应用评分", @"关于", @"开源许可"],
                        ];
    cell.textLabel.text = titles[indexPath.section][indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section, row = indexPath.row;
    
    if (section == 0) {
        if (row == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定要清除缓存的图片和文件？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];

        } else if (row == 1){
            [self.navigationController pushViewController:[CDSettingVC new] animated:YES];
        }
    } else if (section == 1) {
        if (row == 0) {
//            [self.navigationController pushViewController:[LCUserFeedbackViewController new] animated:YES];
            LCUserFeedbackViewController *feedbackViewController = [[LCUserFeedbackViewController alloc] init];
            feedbackViewController.feedbackTitle = [PursueUser currentUser].username;
            feedbackViewController.contact = [AVUser currentUser].objectId;
            CDBaseNavC *navigationController = [[CDBaseNavC alloc] initWithRootViewController:feedbackViewController];
            [self presentViewController:navigationController animated:YES completion: ^{
            }];
//            [self performSelector:@selector(loadDataSource) withObject:nil afterDelay:1];
            
            
        } else if (row == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/kai-yuan-zhong-guo/id524298520?mt=8"]];
        } else if (row == 2) {
            [self.navigationController pushViewController:[AboutPage new] animated:YES];
        } else if (row == 3) {
            [self.navigationController pushViewController:[OSLicensePage new] animated:YES];
        }
    }
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        return;
    } else {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
    }
}





@end
