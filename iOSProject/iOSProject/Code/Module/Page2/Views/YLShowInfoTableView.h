//
//  YLShowInfoTableView.h
//  iOSProject
//
//  Created by 王留根 on 2019/4/16.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol YLShowInfoTableViewDelegate <NSObject>
-(void)didselectedCell:(NSInteger)index;
-(void)buttonaction:(UIButton *)sender;

//下拉刷新
-(void)YLTableViewRefreshAction:(UIView *)view;
//上拉刷新
-(void)YLTableViewLoadMoreAction:(UIView *)view;

@end



@interface YLShowInfoTableView : UIView

@property (nonatomic, weak) id<YLShowInfoTableViewDelegate> delegate;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, assign) CellType  cellType;

@end

NS_ASSUME_NONNULL_END
