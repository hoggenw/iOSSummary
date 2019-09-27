//
//  RuntimeTestTemp.h
//  iOSProject
//
//  Created by 王留根 on 2019/5/13.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeTestTemp : NSObject


@property (nonatomic, copy) NSString *string;
//声明类方法，但未实现
+ (void)haveMeal:(NSString *)food;
//声明实例方法，但未实现
- (void)singSong:(NSString *)name;

//声明类方法，但未实现
+ (void)comeOn:(NSString *)temp;
//声明实例方法，但未实现
- (void)goOn:(NSString *)temp;
@end

NS_ASSUME_NONNULL_END
