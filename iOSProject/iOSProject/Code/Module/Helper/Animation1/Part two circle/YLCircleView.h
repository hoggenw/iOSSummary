//
//  YLCircleView.h
//  YLAudioFrequecy
//
//  Created by 王留根 on 2018/2/7.
//  Copyright © 2018年 ios-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLCircleView : UIView

@property (nonatomic,strong) CAShapeLayer * circleLayer;

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lindeColor:(UIColor *)lineColor size:(CGFloat)size;

@end
