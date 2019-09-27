//
//  YLPlayerOption.h
//  iOSProject
//
//  Created by 王留根 on 2019/9/10.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, YLInterfaceOrientationType) {
    
    YLInterfaceOrientationPortrait           = 0,//home键在下面
    YLInterfaceOrientationLandscapeLeft      = 1,//home键在左边
    YLInterfaceOrientationLandscapeRight     = 2,//home键在右边
    YLInterfaceOrientationUnknown            = 3,//未知方向
    YLInterfaceOrientationPortraitUpsideDown = 4,//home键在上面
};

@interface YLPlayerOption : NSObject
/*
 屏幕方向
 */
@property(nonatomic,assign)YLInterfaceOrientationType screenDirection;

/*
 是否是正在播放状态
 */
@property(nonatomic,assign)BOOL isPlaying;

/*
 当前播放时间
 */
@property(nonatomic,assign) NSTimeInterval currenTime;
/*
 视频的总时长
 */
@property(nonatomic,assign) NSTimeInterval totalTime;
/*
 当前播放器处于被显示状态
 */
@property(nonatomic,assign)BOOL isBeingAppearState;

/*
 当前视频播放器是不是第一响应者状态
 */
@property(nonatomic,assign)BOOL isBeingActiveState;

/*
 获取当前的屏幕方向
 */
-(YLInterfaceOrientationType)getCurrentScreenDirection;

@end

NS_ASSUME_NONNULL_END
