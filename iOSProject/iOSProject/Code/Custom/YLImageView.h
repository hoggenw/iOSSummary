//
//  YLImageView.h
//  YLScoketTest
//
//  Created by 王留根 on 2018/2/2.
//  Copyright © 2018年 ios-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLImageView : UIImageView

-(void)setTapActionWithBlock:(void (^)(void))block;

@end
