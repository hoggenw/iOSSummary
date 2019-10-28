//
//  GCDTestListViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/21.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "GCDTestListViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"

#import "GCDTest.h"

@interface GCDTestListViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation GCDTestListViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self initialUI];
    [self initialDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@""];
    model.desc = [NSString stringWithFormat:@"队列"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    //主线程与线程切换
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@""];
    model2.desc = [NSString stringWithFormat:@"主线程与线程切换"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    //dispatch_once用法
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@""];
    model3.desc = [NSString stringWithFormat:@"dispatch_once用法"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    [self.tableView.dataArray addObject: model3];
    
    //dispatch_group
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@""];
    model4.desc = [NSString stringWithFormat:@"dispatch_group"];
    model4.leadImageName = @"tabbar-icon-selected-1";
    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model4];
    [self.tableView.dataArray addObject: model4];
    
    
    
    //dispatch_barrier 与dispatch_apply
    DefualtCellModel *model5 = [DefualtCellModel new];
    model5.title = [NSString stringWithFormat:@""];
    model5.desc = [NSString stringWithFormat:@"dispatch_barrier 与dispatch_apply"];
    model5.leadImageName = @"tabbar-icon-selected-1";
    model5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model5];
    [self.tableView.dataArray addObject: model5];
    
    //死锁相关情形
    
    DefualtCellModel *model6 = [DefualtCellModel new];
    model6.title = [NSString stringWithFormat:@""];
    model6.desc = [NSString stringWithFormat:@"死锁相关情形1"];
    model6.leadImageName = @"tabbar-icon-selected-1";
    model6.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model6];
    [self.tableView.dataArray addObject: model6];
    
    
    //死锁相关情形2
    
    DefualtCellModel *model7 = [DefualtCellModel new];
    model7.title = [NSString stringWithFormat:@""];
    model7.desc = [NSString stringWithFormat:@"死锁相关情形2"];
    model7.leadImageName = @"tabbar-icon-selected-1";
    model7.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model7];
    [self.tableView.dataArray addObject: model7];
    
    //semaphore信号量
    
    DefualtCellModel *model8 = [DefualtCellModel new];
    model8.title = [NSString stringWithFormat:@""];
    model8.desc = [NSString stringWithFormat:@"semaphore信号量"];
    model8.leadImageName = @"tabbar-icon-selected-1";
    model8.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model8];
    [self.tableView.dataArray addObject: model8];
    
    self.tableView.dataArray = [NSMutableArray arrayWithArray: self.dataArray];
    [self.tableView.tableView reloadData];
    
}
- (void)initialUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [YLTableView new];
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

#pragma mark - Extension Delegate or Protocol

#pragma mark - YLTableViewDelete

-(void)didselectedCell:(NSInteger)index {
    
    GCDTest  * temp = [GCDTest shareInstance];
    NSLog(@"GCDTest temp 1: %@",temp);
    NSLog(@"%@",@(index));
    if (index == 0) {
        [temp creatQueue];
    }else if (index == 1){
         [temp testMain];
    }else if (index == 2){
        NSLog(@"GCDTest temp 2: %@",[GCDTest shareInstance]);
    }else if (index == 3){
        [temp testGroub];
    }else if (index == 4){
         [temp barrier];
    }else if(index == 5){
        [temp deadThread];
    }else if(index == 6){
        [temp deadThread2];
    }else if(index == 7){
        [temp semaphore];
    }
    else if(index == 8){
        
    }else if (index == 9){
        
    }else if (index == 10){
        
        
    }else if(index == 11){
        
    }
    
    else if(index == 12){
        
    }
    else if(index == 13){
        
    }
    
    
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
