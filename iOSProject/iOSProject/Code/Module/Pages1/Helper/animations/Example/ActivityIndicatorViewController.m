//
//  ActivityIndicatorViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/23.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ActivityIndicatorViewController.h"

@interface ActivityIndicatorViewController ()
@property (weak, nonatomic) UIView *redView;
@property (weak, nonatomic) CALayer *blueLayer;

@end

@implementation ActivityIndicatorViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
    // 1.创建一个复制图层对象，设置复制层的属性
     CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
     
     // 1.1.设置复制图层中子层总数：这里包含原始层
     replicatorLayer.instanceCount = 8;
     // 1.2.设置复制子层偏移量，不包含原始层，这里是相对于原始层的x轴的偏移量
     replicatorLayer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
     // 1.3.设置复制层的动画延迟事件
     replicatorLayer.instanceDelay = 0.1;
     // 1.4.设置复制层的背景色，如果原始层设置了背景色，这里设置就失去效果
     replicatorLayer.instanceColor = [UIColor greenColor].CGColor;
     // 1.5.设置复制层颜色的偏移量
     replicatorLayer.instanceGreenOffset = -0.1;
     
     // 2.创建一个图层对象  单条柱形 (原始层)
     CALayer *layer = [CALayer layer];
     // 2.1.设置layer对象的位置
     layer.position = CGPointMake(15, self.view.bounds.size.height);
     // 2.2.设置layer对象的锚点
     layer.anchorPoint = CGPointMake(0, 1);
     // 2.3.设置layer对象的位置大小
     layer.bounds = CGRectMake(0, 0, 30, 150);
     // 2.5.设置layer对象的颜色
     layer.backgroundColor = [UIColor whiteColor].CGColor;
     
     // 3.创建一个基本动画
     CABasicAnimation *basicAnimation = [CABasicAnimation animation];
     // 3.1.设置动画的属性
     basicAnimation.keyPath = @"transform.scale.y";
     // 3.2.设置动画的属性值
     basicAnimation.toValue = @0.1;
     // 3.3.设置动画的重复次数
     basicAnimation.repeatCount = MAXFLOAT;
     // 3.4.设置动画的执行时间
     basicAnimation.duration = 0.5;
     // 3.5.设置动画反转
     basicAnimation.autoreverses = YES;
     
     // 4.将动画添加到layer层上
     [layer addAnimation:basicAnimation forKey:nil];
     
     // 5.将layer层添加到复制层上
     [replicatorLayer addSublayer:layer];
     
     // 6.将复制层添加到view视图层上
     [self.view.layer addSublayer:replicatorLayer];
     */
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.redView.frame = CGRectMake(20, 100, 250, 250);
    self.redView.backgroundColor = [UIColor grayColor];
    
    
    CAReplicatorLayer *repL = [CAReplicatorLayer layer];
    
    repL.frame = self.redView.bounds;
    
    [self.redView.layer addSublayer:repL];
    
    
    CALayer *layer = [CALayer layer];
    
    layer.transform = CATransform3DMakeScale(0, 0, 0);
    
    layer.position = CGPointMake(self.redView.bounds.size.width / 2, 20);
    
    layer.bounds = CGRectMake(0, 0, 10, 10);
    
    layer.backgroundColor = [UIColor greenColor].CGColor;
    
    
    [repL addSublayer:layer];
    
    // 设置缩放动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"transform.scale";
    
    anim.fromValue = @1;
    
    anim.toValue = @0;
    
    anim.repeatCount = MAXFLOAT;
    
    CGFloat duration = 1;
    
    anim.duration = duration;
    
    [layer addAnimation:anim forKey:nil];
    
    
    int count = 20;
    
    CGFloat angle = M_PI * 2 / count;
    
    // 设置子层总数
    repL.instanceCount = count;
    
    repL.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    repL.instanceDelay = duration / count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods
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
