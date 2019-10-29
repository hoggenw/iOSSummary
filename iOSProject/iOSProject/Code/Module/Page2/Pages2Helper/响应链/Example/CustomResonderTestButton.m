//
//  CustomResonderTestButton.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/14.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "CustomResonderTestButton.h"

@implementation CustomResonderTestButton

//扩大按钮的点击范围。
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    NSLog(@"%@",NSStringFromCGPoint(point));
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, -40, -40);
    // CGRectContainsPoint  判断点是否在矩形内
    return CGRectContainsPoint(bounds, point);
}


@end
