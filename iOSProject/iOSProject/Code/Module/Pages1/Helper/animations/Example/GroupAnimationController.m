//
//  GroupAnimationController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/23.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "GroupAnimationController.h"
#import "TestImage.h"

@interface GroupAnimationController ()
@property(nonatomic, strong)UIImageView * showImage;
@end

@implementation GroupAnimationController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    TestImage * model = [TestImage new];
    
    self.showImage = [UIImageView new];
    
    self.showImage.image = [model resultImage];
    self.showImage.frame = CGRectMake(0, 0, 300, 300);
    [self.view addSubview: self.showImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 同时缩放，平移，旋转
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @0.5;
    
    CABasicAnimation *rotation = [CABasicAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.toValue = @(arc4random_uniform(M_PI));
    
    CABasicAnimation *position = [CABasicAnimation animation];
    position.keyPath = @"position";
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(200), arc4random_uniform(200))];
    
    group.animations = @[scale,rotation,position];
    
    [self.showImage.layer addAnimation:group forKey:nil];
}

#pragma mark - Events


#pragma mark - Private Methods


#pragma mark - Extension Delegate or Protocol

@end
