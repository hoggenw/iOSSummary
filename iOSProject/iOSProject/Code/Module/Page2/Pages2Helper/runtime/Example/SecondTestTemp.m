//
//  SecondTestTemp.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/13.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "SecondTestTemp.h"
#import "RuntimeTestTemp.h"

@interface SecondTestTemp ()

@property(nonatomic, strong)RuntimeTestTemp * temp;

@end

@implementation SecondTestTemp

+(id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(haveMeal:)) {
        return [RuntimeTestTemp class];
    }
    return  [super forwardingTargetForSelector:aSelector];
}
-(id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(singSong:) ) {
        return self.temp;
    }
    return [super forwardingTargetForSelector:aSelector];
}

-(void)testForwardingTarget {
    [SecondTestTemp performSelector:@selector(haveMeal:) withObject:@"类方法重定向且方法动态添加"];
    self.temp = [RuntimeTestTemp new];
    [self performSelector:@selector(singSong:) withObject:@"实例方法重定向且方法动态添加"];
}


@end
