//
//  GesturePasswordView.h
//  iOSProject
//
//  Created by 王留根 on 2019/2/28.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GesturePasswordView;
@protocol GesturePasswordViewDelegate <NSObject>



- (void)submitPsd:(NSString *)toast;//验证密码成功

//那边控制器得到参数,比较完后,然后通过代理返回过来
-(BOOL)GesturePasswordView:(GesturePasswordView *)gesturePasswordView
              withPassword:(NSString *)password;


@end

@interface GesturePasswordView : UIView

@property (nonatomic, weak)id<GesturePasswordViewDelegate>  delegate;

@end

NS_ASSUME_NONNULL_END
