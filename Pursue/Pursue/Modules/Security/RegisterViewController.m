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

@property (nonatomic, strong) UIBarButtonItem *cancelBarButtonItem;
@property (nonatomic, strong) CDEntryActionButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.navigationItem.leftBarButtonItem = self.cancelBarButtonItem;
    [self.view addSubview:self.registerButton];
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

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerAVUser:(id)sender {
    PursueUser *user = [PursueUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
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