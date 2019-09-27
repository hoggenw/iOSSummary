//
//  YLVoiceCircleViewController.m
//  YLAudioFrequecy
//
//  Created by 王留根 on 2018/2/6.
//  Copyright © 2018年 ios-mac. All rights reserved.
//

#import "YLVoiceCircleViewController.h"
#import "YLVoiceCircleView.h"

@interface YLVoiceCircleViewController ()

@property (nonatomic,strong)YLVoiceCircleView * circleVoiceView;

@end

@implementation YLVoiceCircleViewController


#pragma mark - Override Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _circleVoiceView = [[YLVoiceCircleView alloc] initWithFrame:CGRectZero];
    
    
    //测试语音开始动画
    UIButton * testVioceButton = [self creatNormalBUttonWithName:@"语音动画" frame: CGRectMake(40, ScreenHeight - 60, 100, 40)];
    [testVioceButton addTarget: self action:@selector(voiceAnimation) forControlEvents: UIControlEventTouchUpInside];
    
    //测试语音结束动画
    UIButton * testVioceStopButton = [self creatNormalBUttonWithName:@"结束动画" frame: CGRectMake(ScreenWidth/2 + 40, ScreenHeight - 60, 100, 40)];
    [testVioceStopButton addTarget: self action:@selector(stopVoiceAnimation) forControlEvents: UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ( self.circleVoiceView.backGroundView != nil) {
        [self.circleVoiceView stopArcAnimation];
        [self.circleVoiceView.backGroundView removeFromSuperview];
        self.circleVoiceView.backGroundView = nil;
        self.circleVoiceView = nil;
    }
}

#pragma mark - Public Methods


#pragma mark - Events

- (void)voiceAnimation {
    [self.circleVoiceView startAnimation];
}

- (void)stopVoiceAnimation {
    [self.circleVoiceView stopArcAnimation];
    [self.circleVoiceView.backGroundView removeFromSuperview];
    self.circleVoiceView.backGroundView = nil;
    self.circleVoiceView = nil;
}

- (YLVoiceCircleView *)circleVoiceView {
    if (_circleVoiceView == nil) {
        _circleVoiceView = [[YLVoiceCircleView alloc] initWithFrame:CGRectZero];
    }
    return _circleVoiceView;
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
