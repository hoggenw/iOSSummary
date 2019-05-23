//
//  RunloopTestListViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/22.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "RunloopTestListViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "RunloopTest.h"



@interface RunloopTestListViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong)RunloopTest  * temp;
@end

@implementation RunloopTestListViewController


#pragma mark - Override Methods



- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self initialUI];
    [self initialDataSource];
    _temp =[RunloopTest new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@""];
    model.desc = [NSString stringWithFormat:@"runloop六种状态"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    //主线程与线程切换
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@""];
    model2.desc = [NSString stringWithFormat:@"监听runloop状态改变"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    //dispatch_once用法
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@""];
    model3.desc = [NSString stringWithFormat:@"计时器Timer"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    [self.tableView.dataArray addObject: model3];
    
    //dispatch_group
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@""];
    model4.desc = [NSString stringWithFormat:@"常驻线程"];
    model4.leadImageName = @"tabbar-icon-selected-1";
    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model4];
    [self.tableView.dataArray addObject: model4];
    
  //AFNetworking中RunLoop的创建
    DefualtCellModel *model5 = [DefualtCellModel new];
    model5.title = [NSString stringWithFormat:@""];
    model5.desc = [NSString stringWithFormat:@"AFNetworking中RunLoop的创建"];
    model5.leadImageName = @"tabbar-icon-selected-1";
    model5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model5];
    [self.tableView.dataArray addObject: model5];
    
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"常驻线程测试" style:UIBarButtonItemStylePlain target:self action:@selector(runloopTest)];
    
    
}

#pragma mark - Extension Delegate or Protocol

#pragma mark - YLTableViewDelete

-(void)didselectedCell:(NSInteger)index {
    
 
    NSLog(@"GCDTest temp 1: %@",_temp);
    NSLog(@"%@",@(index));
    if (index == 0) {
        [_temp logSixStatus];
    }else if (index == 1){
        [_temp observerRunLoop];
    }else if (index == 2){
      [_temp timerTest];
    }else if (index == 3){
        [_temp stateRunLoop];
    }else if (index == 4){
        [RunloopTest networkRequestThread];
    }else if(index == 5){
       
    }else if(index == 6){
       
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


-(void)runloopTest
{
    [self performSelector:@selector(testLoop) onThread: _temp.thread withObject:@"hoggen" waitUntilDone:YES];
}
-(void)testLoop{
    NSLog(@"testtesttest");
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


-(UIButton *)creatNormalBUttonWithName:(NSString *)name{
    
    UIButton * button = [UIButton new];
    [self.view addSubview: button];
    button.titleLabel.textColor = [UIColor blackColor];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState: UIControlStateNormal];
    [button setTitle: name forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    return button;
    
}


@end
