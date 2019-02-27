//
//  YLMicrophoneViewController.m
//  YLAudioFrequecy
//
//  Created by 王留根 on 2018/2/6.
//  Copyright © 2018年 ios-mac. All rights reserved.
//

#import "YLMicrophoneViewController.h"
#import "YLMicphoneVoiceView.h"

@interface YLMicrophoneViewController ()
@property (nonatomic,strong)YLMicphoneVoiceView * micphoneVoiceView;
@end

@implementation YLMicrophoneViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _micphoneVoiceView = [[YLMicphoneVoiceView alloc] initWithFrame:CGRectZero];
    
    
    //测试语音开始动画
    UIButton * testVioceButton = [self creatNormalBUttonWithName:@"语音动画" frame: CGRectMake(40, 380, 100, 40)];
    [testVioceButton addTarget: self action:@selector(voiceAnimation) forControlEvents: UIControlEventTouchUpInside];
    
    //测试语音结束动画
    UIButton * testVioceStopButton = [self creatNormalBUttonWithName:@"结束动画" frame: CGRectMake(180, 380, 100, 40)];
    [testVioceStopButton addTarget: self action:@selector(stopVoiceAnimation) forControlEvents: UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events

- (void)voiceAnimation {
    [self.voiceView startAnimation];
}

- (void)stopVoiceAnimation {
    [self.micphoneVoiceView stopArcAnimation];
    [self.micphoneVoiceView removeFromSuperview];
    self.micphoneVoiceView = nil;
}

- (YLMicphoneVoiceView *)voiceView {
    if (_micphoneVoiceView == nil) {
        _micphoneVoiceView = [[YLMicphoneVoiceView alloc] initWithFrame:CGRectZero];
    }
    return _micphoneVoiceView;
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
