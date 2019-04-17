//
//  ShowInfoTableViewCell.h
//  iOSProject
//
//  Created by 王留根 on 2019/4/16.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShowMessageModel;
@interface ShowInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) ShowMessageModel * model;
@property (nonatomic, weak) id<NormalActionWithInfoDelegate> delegate;
// 便利构造
+ (instancetype)cellInTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
