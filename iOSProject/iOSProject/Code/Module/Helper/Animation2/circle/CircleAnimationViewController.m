//
//  CircleAnimationViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/7.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "CircleAnimationViewController.h"

@interface CircleAnimationViewController ()

@end

@implementation CircleAnimationViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * waveButton = [self creatNormalBUttonWithName:@"开始动画" frame: CGRectMake(120, 100, 60, 50)];
    [waveButton addTarget: self action:@selector(waveAnimation) forControlEvents: UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events
- (void)waveAnimation {
    
    
}

#pragma mark - Private Methods
-(UIButton *)creatNormalBUttonWithName:(NSString *)name frame:(CGRect)frame {
    
    UIButton * button = [UIButton new];
    button.frame = frame;
    [self.view addSubview: button];
    button.titleLabel.textColor = [UIColor blackColor];
    [button setTitle: name forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    
    return button;
    
}

#pragma mark - Extension Delegate or Protocol

@end
