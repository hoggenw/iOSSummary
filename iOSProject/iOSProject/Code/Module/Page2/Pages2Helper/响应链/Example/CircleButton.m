//
//  CircleButton.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/15.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "CircleButton.h"

@implementation CircleButton



- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGFloat halfWidth = self.bounds.size.width / 2;
    
    CGFloat xDistance = point.x - halfWidth;
    
    CGFloat yDistance = point.y - halfWidth;
    
    CGFloat radius = sqrt(xDistance * xDistance + yDistance * yDistance);
    
    NSLog(@"HaldWidth:%f---point:%@---x轴距离:%f---y轴距离:%f--半径:%f",halfWidth,NSStringFromCGPoint(point),xDistance,yDistance,radius);
    
    return radius <= halfWidth;
}


@end
