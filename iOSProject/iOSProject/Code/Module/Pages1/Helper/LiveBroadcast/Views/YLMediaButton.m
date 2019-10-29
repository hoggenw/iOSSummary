//
//  YLMediaButton.m
//  iOSProject
//
//  Created by 王留根 on 2019/9/10.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "YLMediaButton.h"

@implementation YLMediaButton

-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [super sendAction:action to:target forEvent:event];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = self.bounds;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
    [self.layer addSublayer:layer];
    
    UIBezierPath *pathStart = [UIBezierPath bezierPath];
    pathStart = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    UIBezierPath *pathEnd = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, -5, -5)];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id _Nullable)(pathStart.CGPath);
    animation.toValue = (__bridge id _Nullable)(pathEnd.CGPath);
    animation.duration = 0.25f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"path"];
    
}

@end
