//
//  DefaultTableViewCell.h
//  iOSProject
//
//  Created by 王留根 on 2018/11/19.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefualtCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DefaultTableViewCell : UITableViewCell

@property (nonatomic, strong) DefualtCellModel * model;
@property (nonatomic, weak) id<NormalActionWithInfoDelegate> delegate;
// 便利构造
+ (instancetype)cellInTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
