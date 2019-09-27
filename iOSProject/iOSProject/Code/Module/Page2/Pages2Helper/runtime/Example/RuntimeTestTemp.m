//
//  RuntimeTestTemp.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/13.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "RuntimeTestTemp.h"
#import <objc/runtime.h>

@implementation RuntimeTestTemp



/**
 *object_getClass:获得的是isa的指向
 *self.class:当self是实例对象的时候，返回的是类对象，否则则返回自身。
 */

+(BOOL)resolveClassMethod:(SEL)sel{
    if (sel == @selector(haveMeal:)) {
        //"v@:@"：v：是添加方法无返回值 @表示是id(也就是要添加的类) ：表示添加的方法类型 @表示：参数类型
        class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(YLhaveMeal:)), "v@");
        return  true;
    }
    return [super resolveClassMethod:sel];
}

+(BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(singSong:)) {
        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(YLSingSong:)), "v@");
        return  true;
    }
    return [super resolveInstanceMethod:sel];
}

+(void)YLhaveMeal:(NSString *)temp {

    NSLog(@"%@",[NSString stringWithFormat:@"%s=======temp: %@ ", __func__,temp]);
    [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"%s=======temp: %@ ", __func__,temp]];
}

- (void)YLSingSong:(NSString *)name{
    NSLog(@"%@",[NSString stringWithFormat:@"%s=======name: %@ ", __func__,name]);
   // [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"%s=======name: %@ ", __func__,name]];
}

//声明类方法，但未实现
+ (void)comeOn:(NSString *)temp{
    NSLog(@"%s",__func__);
    NSLog(@"temp:  %@",temp);
    //[YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"%s=======temp: %@ ", __func__,temp]];
}
//声明实例方法，但未实现
- (void)goOn:(NSString *)temp{
    NSLog(@"%s",__func__);
    NSLog(@"temp:  %@",temp);
   // [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"%s=======temp: %@ ", __func__,temp]];
}

@end
