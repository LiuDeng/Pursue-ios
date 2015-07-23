//
//  LoginViewController.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/7.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "CDEntryBottomButton.h"
#import "CDEntryActionButton.h"
#import "CDBaseNavC.h"
#import "Current.h"
#import "AppDelegate.h"
#import "PursueUser.h"

@interface LoginViewController () <CDEntryVCDelegate>

@property (nonatomic, strong) UIBarButtonItem *cancelBarButtonItem;
@property (nonatomic, strong) CDEntryActionButton *loginButton;
@property (nonatomic, strong) CDEntryBottomButton *registerButton;
@property (nonatomic, strong) CDEntryBottomButton *forgotPasswordButton;

@end

@implementation LoginViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = self.cancelBarButtonItem;
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.forgotPasswordButton];
}

- (UIBarButtonItem *)cancelBarButtonItem {
    if (_cancelBarButtonItem == nil) {
        UIImage *image = [UIImage imageNamed:@"cancel"];
        UIImage *selectedImage = [UIImage imageNamed:@"cancel_selected"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:selectedImage forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _cancelBarButtonItem;
}

- (void)cancel:(id)sender {
    //显示 tab 页首页
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate toFirstViewController];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.usernameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERNAME];
    [self changeButtonState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Propertys

- (CDResizableButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [[CDEntryActionButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.usernameField.frame), CGRectGetMaxY(self.passwordField.frame) + kEntryVCVerticalSpacing, CGRectGetWidth(self.usernameField.frame), CGRectGetHeight(self.usernameField.frame))];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.enabled = NO;
        [_loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [[CDEntryBottomButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - kEntryVCTextFieldHeight - 64, CGRectGetWidth(self.view.frame) / 2, kEntryVCTextFieldHeight)];
        [_registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(toRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)forgotPasswordButton {
    if (_forgotPasswordButton == nil) {
        _forgotPasswordButton = [[CDEntryBottomButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) - kEntryVCTextFieldHeight - 64, CGRectGetWidth(self.view.frame) / 2, kEntryVCTextFieldHeight)];
        [_forgotPasswordButton setTitle:@"找回密码" forState:UIControlStateNormal];
        [_forgotPasswordButton addTarget:self action:@selector(toFindPassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotPasswordButton;
}

#pragma mark - Actions
- (void)login:(id)sender {
    if (![CDUtils validEmail:self.usernameField.text]) {
        
        [self showHUDText:@"邮箱格式不正确，请填写有效邮箱！"];
        
        return;
    }
    
    [PursueUser logOut];
    [PursueUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text block: ^(AVUser *user, NSError *error) {
        if (error) {
            [self showHUDText:error.localizedDescription];
        }
        else {
            
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [delegate openChatConnect:^(BOOL succeeded, NSError *error) {
                [[NSUserDefaults standardUserDefaults] setObject:self.usernameField.text forKey:KEY_USERNAME];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }];
}

- (void)toRegister:(id)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    CDBaseNavC *nav = [[CDBaseNavC alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)changeButtonState {
    if (self.usernameField.text.length >= USERNAME_MIN_LENGTH && self.passwordField.text.length >= PASSWORD_MIN_LENGTH) {
        self.loginButton.enabled = YES;
    }
    else {
        self.loginButton.enabled = NO;
    }
}

- (void)toFindPassword:(id)sender {
    [self showHUDText:@"鞭打工程师中..."];
}

- (void)didPasswordTextFieldReturn:(CDTextField *)passwordField {
    if (self.registerButton.enabled) {
        [self login:nil];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    [self changeButtonState];
}

@end
