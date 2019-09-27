//
//  Animation1ViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/2/26.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "Animation1ViewController.h"
#import "YLMicrophoneViewController.h"
#import "YLVoiceAnimationViewController.h"
#import "YLVoiceCircleViewController.h"

@interface Animation1ViewController ()

@end

@implementation Animation1ViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //测试语音输入动画
    UIButton * testVioceButton = [self creatNormalBUttonWithName:@"语音动画" frame: CGRectMake(80, 100, 100, 40)];
    [testVioceButton addTarget: self action:@selector(voiceAnimation) forControlEvents: UIControlEventTouchUpInside];
    //测试语音输入动画
    UIButton * micphoneButton = [self creatNormalBUttonWithName:@"micphone动画" frame: CGRectMake(80, 160, 100, 40)];
    [micphoneButton addTarget: self action:@selector(voiceMicphoneAnimation) forControlEvents: UIControlEventTouchUpInside];
    //测试语音输入动画
    UIButton * circleButton = [self creatNormalBUttonWithName:@"circle动画" frame: CGRectMake(80, 220, 100, 60)];
    [circleButton addTarget: self action:@selector(voiceCircleAnimation) forControlEvents: UIControlEventTouchUpInside];
    //[circleButton setBackgroundImage:[UIImage imageNamed:@"goods_upload_image"] forState: UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events

#pragma mark - 语音动画
- (void)voiceAnimation {
    YLVoiceAnimationViewController * vc = [YLVoiceAnimationViewController new];
    [self.navigationController pushViewController:vc animated:true];

    
}

- (void)voiceMicphoneAnimation {
    YLMicrophoneViewController * vc = [YLMicrophoneViewController new];
    [self.navigationController pushViewController:vc animated:true];
    
}
- (void)voiceCircleAnimation {
    YLVoiceCircleViewController * vc = [YLVoiceCircleViewController new];
    [self.navigationController pushViewController:vc animated:true];
//    [self presentViewController: vc animated: true completion:^{
//        
//    }];
    
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
