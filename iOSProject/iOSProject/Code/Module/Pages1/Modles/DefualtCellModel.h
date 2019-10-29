//
//  DefualtCellModel.h
//  iOSProject
//
//  Created by 王留根 on 2018/11/19.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefualtCellModel : NSObject

@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *leadImageName;
@property (nonatomic , copy) NSString *desc;
@property (nonatomic, assign) UITableViewCellAccessoryType  cellAccessoryType;

@end

NS_ASSUME_NONNULL_END
