//
//  CircleAnimationViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/7.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "CircleAnimationViewController.h"
#import "CircleView.h"

@interface CircleAnimationViewController ()

@property (nonatomic, strong) CircleView * circleView;

@end

@implementation CircleAnimationViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * waveButton = [self creatNormalBUttonWithName:@"开始动画" frame: CGRectMake(ScreenWidth/2 -40, kNavigationHeight + 10, 80, 50)];
    [waveButton addTarget: self action:@selector(waveAnimation) forControlEvents: UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
    _circleView =  [[CircleView alloc] initWithFrame:CGRectMake(100, 200, 80, 80)];//(frame: CGRect(x: 100, y: 200, width: 80, height: 80))
    _circleView.center = self.view.center;
    [self.view addSubview: _circleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events
- (void)waveAnimation {
    [_circleView beginAnimation];
    
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
