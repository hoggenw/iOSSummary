//
//  MineViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/9/3.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "MineViewController.h"
#import <WebKit/WebKit.h>

@interface MineViewController ()

@end

@implementation MineViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //构造WKWebView
    UIWebView *wk = [[UIWebView alloc] init];
    wk.scalesPageToFit = true;
    [self.view addSubview: wk];
    [wk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //获取文件（本地）
    NSString *path = [[NSBundle mainBundle] pathForResource:@"王留根个人简历" ofType:@"docx"];//需要在线预览的文件
    NSURL *pathUrl = [NSURL fileURLWithPath:path];
    //加载
    NSURLRequest *request = [NSURLRequest requestWithURL:pathUrl];
    [wk loadRequest:request];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods


#pragma mark - Extension Delegate or Protocol

@end
