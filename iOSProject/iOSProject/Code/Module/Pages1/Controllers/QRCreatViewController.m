//
//  QRCreatViewController.m
//  iOSProject
//
//  Created by 王留根 on 2018/11/22.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import "QRCreatViewController.h"
#import "YLScanViewManager.h"

@interface QRCreatViewController ()

@end

@implementation QRCreatViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    YLScanViewManager * manager = [YLScanViewManager sharedInstance];
    UIView *codeView = [manager produceQRcodeView:CGRectMake((self.view.bounds.size.width - 200)/2, (self.view.bounds.size.width - 200)/2, 200, 200) logoIconName:@"device_scan" codeMessage:@"wlg's test Message"];
    [self.view addSubview:codeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods


#pragma mark - Extension Delegate or Protocol

@end
