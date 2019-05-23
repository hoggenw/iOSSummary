//
//  RunloopTest.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/22.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "RunloopTest.h"

@implementation RunloopTest

-(void)logSixStatus{
     NSLog(@"即将进入loop kCFRunLoopEntry %zd \n, 即将处理timer kCFRunLoopBeforeTimers %zd \n,即将处理source kCFRunLoopBeforeSources %zd \n, 即将进入休眠 kCFRunLoopBeforeWaiting %zd \n,从休眠中唤醒 kCFRunLoopAfterWaiting %zd \n,即将退出出 kCFRunLoopExit %zd \n",kCFRunLoopEntry,kCFRunLoopBeforeTimers,kCFRunLoopBeforeSources,kCFRunLoopBeforeWaiting,kCFRunLoopAfterWaiting,kCFRunLoopExit);
}
-(void)observerRunLoop{
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"----监听到RunLoop状态发生改变---%zd", activity);
    });
    // 添加观察者：监听RunLoop的状态
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    // 释放Observer
    CFRelease(observer);
}


-(void)timerTest{
    [[NSRunLoop currentRunLoop] addTimer:[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:true] forMode: NSRunLoopCommonModes];
}

-(void)timerAction {
    NSLog(@"测试双击home后台运行");
    //测试结果显示双击home键时，当前程序处于继续运行状态
}


-(void)stateRunLoop {
    if (_thread == nil) {
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(beiginRunloop) object:@"hoggen"];
        [_thread start];
    }
   
}

-(void)beiginRunloop {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworking_2"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        // 这里主要是监听某个 port，目的是让这个 Thread 不会回收
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread =
        [[NSThread alloc] initWithTarget:self
                                selector:@selector(networkRequestThreadEntryPoint:)
                                  object:nil];
        [_networkRequestThread start];
    });
    return _networkRequestThread;
}

@end
