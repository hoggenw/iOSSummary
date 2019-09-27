//
//  RunloopTest.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/22.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "RunloopTest.h"
#include <pthread.h>
#import <libkern/OSAtomic.h>


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
//        [runLoop removePort:<#(nonnull NSPort *)#> forMode:<#(nonnull NSRunLoopMode)#>]
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






-(void)saveLooptest1 {
    NSObject * obj = [NSObject new];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
            NSLog(@"对比对象1");
            sleep(3);
            NSLog(@"对比对象2");
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            NSLog(@"对比对象3");
        
    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (obj) {
            NSLog(@"同步锁对象1");
            sleep(3);
            NSLog(@"同步锁对象2");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (obj) {
            NSLog(@"同步锁对象3");
        }
    });
    
    /*
     @synchronized(obj)指令使用的obj为该锁的唯一标识，只有当标识相同时，才为满足互斥，如果线程2中的@synchronized(obj)改为@synchronized(self),刚线程2就不会被阻塞，@synchronized指令实现锁的优点就是我们不需要在代码中显式的创建锁对象，便可以实现锁的机制，但作为一种预防措施，@synchronized块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁。所以如果不想让隐式的异常处理例程带来额外的开销，你可以考虑使用锁对象。
     
     */
    
    
}
-(void)saveLooptest2 {
    //当信号总量设为 1 时也可以当作锁来用
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"对比对象1");
        sleep(2);
        NSLog(@"对比对象2");
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"对比对象3");
        
    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
         dispatch_semaphore_signal(semaphore);
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //sleep(1);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(semaphore);
    });
    
    /*这个函数的作用是这样的，如果dsema信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1；如果desema的值为0，那么这个函数就阻塞当前线程等待timeout（注意timeout的类型为dispatch_time_t，不能直接传入整形或float型数），如果等待的期间desema的值被dispatch_semaphore_signal函数加1了，且该函数（即dispatch_semaphore_wait）所处线程获得了信号量，那么就继续向下执行并将信号量减1。如果等待期间没有获取到信号量或者信号量的值一直为0，那么等到timeout时，其所处线程自动执行其后语句。*/

    
}


-(void)saveLooptest3 {
    NSLock *lock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //[lock lock];  lockBeforeDate:方法会在所指定Date之前尝试加锁，如果在指定时间之前都不能加锁，则返回NO。
        [lock lockBeforeDate:[NSDate date]];
        NSLog(@"需要线程同步的操作1 开始");
        sleep(1);
        NSLog(@"需要线程同步的操作1 结束");
        [lock unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        if ([lock tryLock]) {//尝试获取锁，如果获取不到返回NO，不会阻塞该线程
            NSLog(@"锁可用的操作");
            [lock unlock];
        }else{
            NSLog(@"锁不可用的操作");
        }
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:3];
        if ([lock lockBeforeDate:date]) {//尝试在未来的3s内获取锁，并阻塞该线程，如果3s内获取不到恢复线程, 返回NO,不会阻塞该线程
            NSLog(@"没有超时，获得锁");
            [lock unlock];
        }else{
            NSLog(@"超时，没有获得锁");
        }
    });

}

-(void)saveLooptest4 {
    //NSLock *lock = [[NSLock alloc] init];  //使用NSLock则是典型的死锁
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveMethod)(int);
        RecursiveMethod = ^(int value) {
            [lock lock];
            if (value > 0) {
                NSLog(@"value = %d", value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
        };
        RecursiveMethod(7);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:6];
        if ([lock lockBeforeDate:date]) {//尝试在未来的3s内获取锁，并阻塞该线程，如果3s内获取不到恢复线程, 返回NO,不会阻塞该线程
            NSLog(@"没有超时，获得锁");
            [lock unlock];
        }else{
            NSLog(@"超时，没有获得锁");
        }
    });
    
}

-(void)saveLooptest5 {
    NSConditionLock *lock = [[NSConditionLock alloc] init];
    NSMutableArray *products = [NSMutableArray array];
    NSInteger HAS_DATA = 1;
    NSInteger NO_DATA = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [lock lockWhenCondition:NO_DATA];
            [products addObject:[[NSObject alloc] init]];
            NSLog(@"produce a product,总量:%zi",products.count);
            [lock unlockWithCondition:HAS_DATA];
            sleep(1);
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            NSLog(@"wait for product");
            [lock lockWhenCondition:HAS_DATA];
            [products removeObjectAtIndex:0];
            NSLog(@"custome a product");
            [lock unlockWithCondition:NO_DATA];
        }
    });

}

-(void)saveLooptest6 {

    
    NSCondition *condition = [[NSCondition alloc] init];
    NSMutableArray *products = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            if ([products count] == 0) {
                NSLog(@"wait for product");
                [condition wait];
            }
            [products removeObjectAtIndex:0];
            NSLog(@"custome a product");
            [condition unlock];
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            [products addObject:[[NSObject alloc] init]];
            NSLog(@"produce a product,总量:%zi",products.count);
            [condition signal];
            [condition unlock];
            sleep(1);
        }
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            [condition lock];
            if ([products count] == 0) {
                NSLog(@"22 ==wait for product");
                [condition wait];
            }
            [products removeObjectAtIndex:0];
            NSLog(@"22 === custome a product");
            [condition unlock];
        }
    });
    
    
    /*[condition lock];一般用于多线程同时访问、修改同一个数据源，保证在同一时间内数据源只被访问、修改一次，其他线程的命令需要在lock 外等待，只到unlock ，才可访问
     
     [condition unlock];与lock 同时使用
     
     [condition wait];让当前线程处于等待状态
     
     [condition signal];CPU发信号告诉线程不用在等待，可以继续执行
     
     */

}

-(void)saveLooptest7{
//    #include <pthread.h>
    __block pthread_mutex_t theLock;
    pthread_mutex_init(&theLock, NULL);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&theLock);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(3);
        NSLog(@"需要线程同步的操作1 结束");
        pthread_mutex_unlock(&theLock);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        pthread_mutex_lock(&theLock);
        NSLog(@"需要线程同步的操作2");
        pthread_mutex_unlock(&theLock);
    });
    
    /*
     c语言定义下多线程加锁方式。
     
     1：pthread_mutex_init(pthread_mutex_t mutex,const pthread_mutexattr_t attr);
     
     初始化锁变量mutex。attr为锁属性，NULL值为默认属性。
     
     2：pthread_mutex_lock(pthread_mutex_t mutex);加锁
     
     3：pthread_mutex_tylock(*pthread_mutex_t *mutex);加锁，但是与2不一样的是当锁已经在使用的时候，返回为EBUSY，而不是挂起等待。
     
     4：pthread_mutex_unlock(pthread_mutex_t *mutex);释放锁
     
     5：pthread_mutex_destroy(pthread_mutex_t* mutex);使用完后释放
     */
}

-(void)saveLooptest8{
    __block pthread_mutex_t theLock;
    //pthread_mutex_init(&theLock, NULL);
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&theLock, &attr);
    pthread_mutexattr_destroy(&attr);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveMethod)(int);
        RecursiveMethod = ^(int value) {
            pthread_mutex_lock(&theLock);
            if (value > 0) {
                NSLog(@"value = %d", value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            pthread_mutex_unlock(&theLock);
        };
        RecursiveMethod(5);
    });

}


-(void)saveLooptest9{
    __block OSSpinLock theLock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&theLock);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(3);
        NSLog(@"需要线程同步的操作1 结束");
        OSSpinLockUnlock(&theLock);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&theLock);
        sleep(1);
        NSLog(@"需要线程同步的操作2");
        OSSpinLockUnlock(&theLock);
    });

}
-(void)testLoopWithTimer{
   
    dispatch_queue_t queue = dispatch_queue_create("com.apple.www", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(actionTime:) userInfo:nil repeats:YES];
        //=============================而子线程中的RunLoop默认是不启动的==================
        
        
        
        //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];//不执行
        //========================================需要手动启动当前线程
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];//执行
         [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        //========================================因为主线程的loop已经启动
        //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];//执行
        //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];//执行
        
        //============================
        //[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(actionTime:) userInfo:nil repeats:YES];//不执行 次创建方法会自动会默认自动添加到当前RunLoop中
        
        //==========================
        /* 启动子线程runloop */
//        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(actionTime:) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
/*
 *主线程中的RunLoop默认是启动的，所以timer只要添加到主线程RunLoop中就会被执行；而子线程中的RunLoop默认是不启动的，所以timer添加到子线程RunLoop中后，还要手动启动RunLoop才能使timer被执行。
 *NSTimer只有添加到启动起来的RunLoop中才会正常运行。NSTimer通常不建议添加到主线程中执行，因为界面的更新在主线程中，界面导致的卡顿会影响NSTimer的准确性。
 */
    });
}

- (void)actionTime:(NSTimer *)timer {
    NSLog(@"---- %@",[NSDate date]);
}



@end
