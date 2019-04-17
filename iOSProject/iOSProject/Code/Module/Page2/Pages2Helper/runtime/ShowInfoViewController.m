//
//  ShowInfoViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/4/16.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ShowInfoViewController.h"
#import "ShowMessageModel.h"
#import "YLShowInfoTableView.h"

@interface ShowInfoViewController ()<YLShowInfoTableViewDelegate>
@property (nonatomic, strong) YLShowInfoTableView  * tableView;
@property (nonatomic, assign) NSInteger page;


@end

@implementation ShowInfoViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initialUI];
    [self initialDataSource];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods
-(void)initialUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [YLShowInfoTableView new];
    self.tableView.cellType = Default;
    self.tableView.delegate = self;
    self.tableView.tableView.backgroundColor =  [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight);
        make.left.right.bottom.equalTo(self.view);
        //        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
}

-(void)initialDataSource {
    
    
    
    self.tableView.dataArray = [NSMutableArray arrayWithArray: self.dataArray];
    
    [self.tableView.tableView reloadData];
    
}

#pragma mark - Extension Delegate or Protocol

-(void)didselectedCell:(NSInteger)index {
    
    NSLog(@"%@",@(index));

    
    
}

-(void)buttonaction:(UIButton *)sender {
    
}

//下拉刷新
-(void)YLTableViewRefreshAction:(UIView *)view {
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self initialDataSource];
    [self.tableView.tableView.mj_header endRefreshing];
    
}
//上拉刷新
-(void)YLTableViewLoadMoreAction:(UIView *)view {
    self.page++;
    [self.tableView.tableView.mj_footer endRefreshing];
    
}
@end
