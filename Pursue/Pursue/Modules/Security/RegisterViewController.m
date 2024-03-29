//
//  RegisterViewController.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/8.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "RegisterViewController.h"
#import "CDEntryActionButton.h"
#import "PursueUser.h"

@interface RegisterViewController () <CDEntryVCDelegate>

@property (nonatomic, strong) CDEntryActionButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self.view addSubview:self.registerButton];
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [[CDEntryActionButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.usernameField.frame), CGRectGetMaxY(self.passwordField.frame) + kEntryVCVerticalSpacing, CGRectGetWidth(self.usernameField.frame), CGRectGetHeight(self.usernameField.frame))];
        _registerButton.enabled = NO;
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerAVUser:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

#pragma mark - Actions

- (void)registerAVUser:(id)sender {
    if (![CDUtils validEmail:self.usernameField.text]) {
        
        [self showHUDText:@"邮箱格式不正确，请填写有效邮箱！"];
        
        return;
    }
    
    PursueUser *user = [PursueUser user];
    user.username = self.usernameField.text;
    user.displayName = [user.username componentsSeparatedByString:@"@"][0];
    user.password = self.passwordField.text;
    user.email = self.usernameField.text;
    user.collection = 0;
    
    [user setFetchWhenSave:YES];
    WEAKSELF
    [user signUpInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
        if ([weakSelf filterError:error]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.usernameField.text forKey:KEY_USERNAME];
            [weakSelf dismissViewControllerAnimated:NO completion: ^{
                //                CDAppDelegate *delegate = (CDAppDelegate *)[UIApplication sharedApplication].delegate;
                //                [delegate toMain];
            }];
        }
    }];
}

- (void)changeButtonState {
    if (self.usernameField.text.length >= USERNAME_MIN_LENGTH && self.passwordField.text.length >= PASSWORD_MIN_LENGTH) {
        self.registerButton.enabled = YES;
    }
    else {
        self.registerButton.enabled = NO;
    }
}

- (void)didPasswordTextFieldReturn:(CDTextField *)passwordField {
    if (self.registerButton.enabled) {
        [self registerAVUser:nil];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    [self changeButtonState];
}

@end