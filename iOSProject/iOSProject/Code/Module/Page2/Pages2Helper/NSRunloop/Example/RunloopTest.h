//
//  RunloopTest.h
//  iOSProject
//
//  Created by 王留根 on 2019/5/22.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunloopTest : NSObject

@property (nonatomic,strong)   NSThread * thread;

-(void)logSixStatus;
-(void)observerRunLoop;
-(void)timerTest;
-(void)stateRunLoop;
+ (NSThread *)networkRequestThread ;

//@synchronized
-(void)saveLooptest1;
//dispatch_semaphore
-(void)saveLooptest2;

-(void)saveLooptest3;

-(void)saveLooptest4;

-(void)saveLooptest5;


-(void)saveLooptest6;

-(void)saveLooptest7;

-(void)saveLooptest8;


-(void)saveLooptest9;

-(void)testLoopWithTimer;

@end

NS_ASSUME_NONNULL_END
