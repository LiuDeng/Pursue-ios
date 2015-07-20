//
//  OSLicensePage.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/3.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "OSLicensePage.h"

@implementation OSLicensePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"开源组件";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.scrollView.bounces = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"OSLicense" ofType:@"html"] isDirectory:NO]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
