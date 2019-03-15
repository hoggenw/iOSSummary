//
//  GradientProgressView.h
//  iOSProject
//
//  Created by 王留根 on 2019/3/14.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientProgressView : UIView
/**  Progress values go from 0.0 to 1.0  */
@property (nonatomic, assign) CGFloat progress;


- (instancetype)initWithFrame:(CGRect )frame;
@end

NS_ASSUME_NONNULL_END
