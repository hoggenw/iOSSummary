//
//  RuntimeView.h
//  iOSProject
//
//  Created by 王留根 on 2019/5/13.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeView : UIView

-(void)setTapActionWithBlock:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END
