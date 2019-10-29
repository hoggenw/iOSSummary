//
//  ImageDealController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/22.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ImageDealController.h"
#import "TestImage.h"

@interface ImageDealController ()
@property(nonatomic, strong)UIImageView * showImage;
@end

@implementation ImageDealController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    TestImage * model = [TestImage new];
    
    self.showImage = [UIImageView new];
    
    self.showImage.image = [model resultImage];
    self.showImage.frame = CGRectMake(0, 0, 300, 300);
    [self.view addSubview: self.showImage];
    if (_animation) {
         self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"动画1" style:UIBarButtonItemStylePlain target:self action:@selector(animation1)],[[UIBarButtonItem alloc] initWithTitle:@"动画2" style:UIBarButtonItemStylePlain target:self action:@selector(animation2)]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events
-(void)animation1{
    [UIView beginAnimations:@"Animate 2" context:nil];
    //配置动画的执行属性
    [UIView setAnimationDelay:0.5];//延迟时间
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(willStart)];//监听开始的事件
    [UIView setAnimationDidStopSelector:@selector(didStop)];//监听结束的事件
    [UIView setAnimationDuration:2.0];//执行时间
    [UIView setAnimationRepeatAutoreverses:YES];//自动复原
    [UIView setAnimationRepeatCount:2.5];//重复次数
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//执行的加速过程（加速开始，减速结束）
    [UIView setAnimationBeginsFromCurrentState:YES];//是否由当前动画状态开始执行（处理同一个控件上一次动画还没有结束，这次动画就要开始的情况）
    //实际执行的动画
    self.showImage.center = self.view.center;
    self.showImage.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(M_PI), CGAffineTransformMakeScale(2.0, 2.0));
    self.showImage.alpha = 0.5;
    //提交动画
    [UIView commitAnimations];
}

-(void)animation2{
    self.showImage.center = self.view.center;
    self.showImage.transform = CGAffineTransformMakeScale(0.2,0.2);
    self.showImage.alpha = 0.0;
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.showImage.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         self.showImage.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [UIView animateWithDuration:1.0
                                                   delay:2.0
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                  self.showImage.center = CGPointMake(self.showImage.center.x + CGRectGetWidth(self.view.frame), self.showImage.center.y);
                                              }
                                              completion:^(BOOL finished) {
                                                  [self.showImage removeFromSuperview];
                                                  TestImage * model = [TestImage new];
                                                  
                                                  self.showImage = [UIImageView new];
                                                  
                                                  self.showImage.image = [model resultImage];
                                                  self.showImage.frame = CGRectMake(0, 0, 300, 300);
                                                  [self.view addSubview: self.showImage];
                                              }];
                         }
                     }];
}


-(void)willStart{
    NSLog(@"will start");
}
//这个有点问题
-(void)didStop{
    NSLog(@"did stop");
    self.showImage.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(0), CGAffineTransformMakeScale(1, 1));
    self.showImage.alpha = 1;
}

#pragma mark - Private Methods


#pragma mark - Extension Delegate or Protocol

@end
