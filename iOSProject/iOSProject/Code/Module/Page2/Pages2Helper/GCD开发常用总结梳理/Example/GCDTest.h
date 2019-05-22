//
//  GCDTest.h
//  iOSProject
//
//  Created by 王留根 on 2019/5/21.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDTest : NSObject


-(void)creatQueue;
-(void)testMain;
-(void)testGroub;
-(void)barrier;
-(void)deadThread;
-(void)deadThread2;
- (void)semaphore;
+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
