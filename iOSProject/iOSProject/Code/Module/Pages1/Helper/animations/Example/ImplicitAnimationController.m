//
//  ImplicitAnimationController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/22.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ImplicitAnimationController.h"



#define angle2radion(angle) ((angle) / 180.0 * M_PI)

@interface ImplicitAnimationController ()
@property (weak, nonatomic) UIView *redView;
@property (weak, nonatomic) CALayer *blueLayer;

@end

@implementation ImplicitAnimationController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.blueLayer.position = CGPointMake(200, 150);
    
    self.blueLayer.anchorPoint = CGPointZero;
    
    self.blueLayer.bounds = CGRectMake(0, 0, 80, 80);
    
    self.blueLayer.backgroundColor = [UIColor greenColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 旋转
    self.blueLayer.transform = CATransform3DMakeRotation(angle2radion(arc4random_uniform(360) + 1), 0, 0, 1);
    self.blueLayer.position = CGPointMake(arc4random_uniform(200) + 20, arc4random_uniform(400) + 50);
    self.blueLayer.cornerRadius = arc4random_uniform(50);
    self.blueLayer.backgroundColor = [UIColor RandomColor].CGColor;
    self.blueLayer.borderWidth = arc4random_uniform(10);
    self.blueLayer.borderColor = [UIColor RandomColor].CGColor;
    
}


- (UIView *)redView
{
    if(!_redView)
    {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 150, 200)];
        [self.view addSubview:redView];
        _redView = redView;
        redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (CALayer *)blueLayer
{
    if(!_blueLayer)
    {
        CALayer *blueLayer = [CALayer layer];
        [self.view.layer addSublayer:blueLayer];
        blueLayer.backgroundColor = [UIColor blueColor].CGColor;
        _blueLayer = blueLayer;
        blueLayer.frame = CGRectMake(50, 350, 100, 70);
        
    }
    return _blueLayer;
}

#pragma mark - Extension Delegate or Protocol

@end
