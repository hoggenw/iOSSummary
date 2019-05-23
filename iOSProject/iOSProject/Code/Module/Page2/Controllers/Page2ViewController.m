//
//  Page2ViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/2/18.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "Page2ViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "RuntimeListViewController.h"
#import "UIResponderListViewController.h"
#import "RAMManagerViewController.h"
#import "LiftCircleListViewController.h"
#import "GCDListViewController.h"
#import "CommunicationViewController.h"
#import "NSRunloopListViewController.h"

@interface Page2ViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation Page2ViewController


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

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@"运行时"];
    model.desc = [NSString stringWithFormat:@"运行时"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    
    DefualtCellModel *model1 = [DefualtCellModel new];
    model1.title = [NSString stringWithFormat:@"响应链"];
    model1.desc = [NSString stringWithFormat:@"响应链"];
    model1.leadImageName = @"tabbar-icon-selected-1";
    model1.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model1];

//    拷贝与内存管理
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@""];
    model2.desc = [NSString stringWithFormat:@"拷贝与内存管理"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    
    //生命周期总结梳理
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@""];
    model3.desc = [NSString stringWithFormat:@"生命周期总结梳理"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    //GCD开发常用总结梳理
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@""];
    model4.desc = [NSString stringWithFormat:@"GCD开发常用总结梳理"];
    model4.leadImageName = @"tabbar-icon-selected-1";
    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model4];
    
    
    DefualtCellModel *model5 = [DefualtCellModel new];
    model5.title = [NSString stringWithFormat:@""];
    model5.desc = [NSString stringWithFormat:@"通信模式"];
    model5.leadImageName = @"tabbar-icon-selected-1";
    model5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model5];
    
    //NSRunloop
    DefualtCellModel *model6 = [DefualtCellModel new];
    model6.title = [NSString stringWithFormat:@""];
    model6.desc = [NSString stringWithFormat:@"NSRunloop"];
    model6.leadImageName = @"tabbar-icon-selected-1";
    model6.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model6];
    
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
    
    NSLog(@"%@",@(index));
    if (index == 0) {
        RuntimeListViewController * runVC = [RuntimeListViewController new];
        runVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController: runVC animated: true];

    }else if (index == 1){
        UIResponderListViewController * runVC = [UIResponderListViewController new];
        runVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController: runVC animated: true];
    }else if (index == 2){
        
        RAMManagerViewController * runVC = [RAMManagerViewController new];
        runVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController: runVC animated: true];
        
    }else if (index == 3){
        LiftCircleListViewController * runVC = [LiftCircleListViewController new];
        runVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController: runVC animated: true];
        
    }else if (index == 4){
        //GCDListViewController
        GCDListViewController * runVC = [GCDListViewController new];
        runVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController: runVC animated: true];
    }else if(index == 5){
        CommunicationViewController * runVC = [CommunicationViewController new];
        runVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController: runVC animated: true];
    }else if(index == 6){
        NSRunloopListViewController * runVC = [NSRunloopListViewController new];
        runVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController: runVC animated: true];
       
    }else if(index == 7){
       
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
