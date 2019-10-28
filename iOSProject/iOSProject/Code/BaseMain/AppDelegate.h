//
//  AppDelegate.h
//  FTXExperienceStore
//
//  Created by 王留根 on 2018/1/10.
//  Copyright © 2018年 hoggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/*
 决定是不是可以允许转屏的参数
 */
@property(nonatomic,assign)BOOL allowRotation;

/*
 当前的网络状态
 */
@property(nonatomic,assign)int netWorkStatesCode;

@end

