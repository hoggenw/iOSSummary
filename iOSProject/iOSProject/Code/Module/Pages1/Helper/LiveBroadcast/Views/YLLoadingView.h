//
//  YLLoadingView.h
//  iOSProject
//
//  Created by 王留根 on 2019/9/10.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLLoadingView : UIView

/*
 显示加载框并且显示加载动画
 */
-(void)showAndStartAnimation;
/*
 隐藏加载框并且停止加载动画
 */
-(void)hideAndStopAnimation;

@end

NS_ASSUME_NONNULL_END
