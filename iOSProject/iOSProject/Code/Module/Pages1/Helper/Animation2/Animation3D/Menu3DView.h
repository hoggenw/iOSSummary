//
//  Menu3DView.h
//  iOSProject
//
//  Created by 王留根 on 2019/3/11.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Menu3DView : UIView
-(instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,copy) void(^backBlock)(void);
@end

NS_ASSUME_NONNULL_END
