//
//  WaveViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/11.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "WaveViewController.h"

#import "WaveAnimationView.h"

@interface WaveViewController ()

@end

@implementation WaveViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WaveAnimationView * waveView = [[WaveAnimationView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    waveView.center = self.view.center;
    waveView.backgroundColor = [UIColor colorWithRed: 200/255 green:20/255 blue:20/255 alpha:1];
    waveView.layer.cornerRadius = 50;
    waveView.clipsToBounds = true;
    [self.view addSubview: waveView];
    [waveView animationBegin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods


#pragma mark - Extension Delegate or Protocol

@end
