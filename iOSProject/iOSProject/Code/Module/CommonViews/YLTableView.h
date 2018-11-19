//
//  YLTableView.h
//  Telegraph
//
//  Created by 王留根 on 2018/4/25.
//

#import <UIKit/UIKit.h>





@protocol YLTableViewDelete <NSObject>
-(void)didselectedCell:(NSInteger)index;
-(void)buttonaction:(UIButton *)sender;

//下拉刷新
-(void)YLTableViewRefreshAction:(UIView *)view;
//上拉刷新
-(void)YLTableViewLoadMoreAction:(UIView *)view;
@end


@interface YLTableView : UIView

@property (nonatomic, weak) id<YLTableViewDelete> delegate;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, assign) CellType  cellType;

@end
