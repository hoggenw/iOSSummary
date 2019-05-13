//
//  ThirdTestTemp.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/13.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ThirdTestTemp.h"
#import "RuntimeTestTemp.h"

@interface ThirdTestTemp ()

@property(nonatomic, strong)RuntimeTestTemp * temp;

@end

@implementation ThirdTestTemp

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    //1.从anInvocation中获取消息
    SEL sel = anInvocation.selector;
    //2.判断Student方法是否可以响应应sel
    //动态j添加的方法， 在respondsToSelector中是响应不到的
    if ([self.temp respondsToSelector:@selector(goOn:)]) {
        [anInvocation invokeWithTarget:self.temp];
    }else{
        //2.2若仍然无法响应，则报错：找不到响应方法
        [self doesNotRecognizeSelector:sel];
    }
    //类方法无法实现
//    if ([RuntimeTestTemp respondsToSelector:@selector(comeOn:)]) {
//        [anInvocation invokeWithTarget:[RuntimeTestTemp class]];
//    }else{
//        //2.2若仍然无法响应，则报错：找不到响应方法
//        [self doesNotRecognizeSelector:sel];
//    }
}
//需要从这个方法中获取的信息来创建NSInvocation对象，因此我们必须重写这个方法，为给定的selector提供一个合适的方法签名。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature * methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}

-(void)testForwardInvocation {
   // [ThirdTestTemp performSelector:@selector(comeOn:) withObject:@"类方法重定向且方法动态添加"];
    self.temp = [RuntimeTestTemp new];
    [self performSelector:@selector(goOn:) withObject:@"实例方法重定向且方法动态添加"];
}

@end
