//
//  Animation2ViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/7.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "Animation2ViewController.h"
#import "CircleAnimationViewController.h"
#import "WaveViewController.h"

#import "Menu3DViewController.h"

@interface Animation2ViewController ()

@end

@implementation Animation2ViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //波浪动画
    UIButton * waveButton = [self creatNormalBUttonWithName:@"波浪动画" frame: CGRectMake(80, 100, 100, 40)];
    [waveButton addTarget: self action:@selector(waveAnimation) forControlEvents: UIControlEventTouchUpInside];
    
    UIButton * flipButton = [self creatNormalBUttonWithName:@"3D动画" frame: CGRectMake(80, 160, 100, 40)];
    [flipButton addTarget: self action:@selector(flipAnimation) forControlEvents: UIControlEventTouchUpInside];
    
    UIButton * circleButton = [self creatNormalBUttonWithName:@"旋转动画" frame: CGRectMake(80, 220, 100, 60)];
    [circleButton addTarget: self action:@selector(circleAnimation) forControlEvents: UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events
- (void)waveAnimation {
    WaveViewController * VC = [WaveViewController new];
    [self.navigationController pushViewController: VC animated: true];
    
}

- (void)flipAnimation {
    Menu3DViewController * VC = [Menu3DViewController new];
    [self.navigationController pushViewController: VC animated: true];
    
}




- (void)circleAnimation {
    CircleAnimationViewController * circleVC = [CircleAnimationViewController new];
    [self.navigationController pushViewController: circleVC animated: true];
    
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
