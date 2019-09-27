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
@property (nonatomic,strong)   NSThread * thread;
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
    
    
    DefualtCellModel *model6 = [DefualtCellModel new];
    model6.title = [NSString stringWithFormat:@""];
    model6.desc = [NSString stringWithFormat:@"线程安全@synchronized"];
    model6.leadImageName = @"tabbar-icon-selected-1";
    model6.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model6];
    [self.tableView.dataArray addObject: model6];
    
    
    DefualtCellModel *model7 = [DefualtCellModel new];
    model7.title = [NSString stringWithFormat:@""];
    model7.desc = [NSString stringWithFormat:@"线程安全dispatch_semaphore"];
    model7.leadImageName = @"tabbar-icon-selected-1";
    model7.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model7];
    [self.tableView.dataArray addObject: model7];
    //
    DefualtCellModel *model8 = [DefualtCellModel new];
    model8.title = [NSString stringWithFormat:@""];
    model8.desc = [NSString stringWithFormat:@"线程安全NSLock"];
    model8.leadImageName = @"tabbar-icon-selected-1";
    model8.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model8];
    [self.tableView.dataArray addObject: model8];
    //
    
    DefualtCellModel *model9 = [DefualtCellModel new];
    model9.title = [NSString stringWithFormat:@""];
    model9.desc = [NSString stringWithFormat:@"线程安全NSRecursiveLock"];
    model9.leadImageName = @"tabbar-icon-selected-1";
    model9.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model9];
    [self.tableView.dataArray addObject: model9];
    
    
    DefualtCellModel *model10 = [DefualtCellModel new];
    model10.title = [NSString stringWithFormat:@""];
    model10.desc = [NSString stringWithFormat:@"线程安全NSConditionLock"];
    model10.leadImageName = @"tabbar-icon-selected-1";
    model10.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model10];
    [self.tableView.dataArray addObject: model10];
    
    
    DefualtCellModel *model11 = [DefualtCellModel new];
    model11.title = [NSString stringWithFormat:@""];
    model11.desc = [NSString stringWithFormat:@"线程安全condition"];
    model11.leadImageName = @"tabbar-icon-selected-1";
    model11.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model11];
    [self.tableView.dataArray addObject: model11];
    
    //pthread_mutex
    DefualtCellModel *model12 = [DefualtCellModel new];
    model12.title = [NSString stringWithFormat:@""];
    model12.desc = [NSString stringWithFormat:@"线程安全pthread_mutex"];
    model12.leadImageName = @"tabbar-icon-selected-1";
    model12.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model12];
    [self.tableView.dataArray addObject: model12];
    
    
    DefualtCellModel *model13 = [DefualtCellModel new];
    model13.title = [NSString stringWithFormat:@""];
    model13.desc = [NSString stringWithFormat:@"线程安全pthread_mutex(recursive)"];
    model13.leadImageName = @"tabbar-icon-selected-1";
    model13.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model13];
    [self.tableView.dataArray addObject: model13];
    
    
    
    DefualtCellModel *model14 = [DefualtCellModel new];
    model14.title = [NSString stringWithFormat:@""];
    model14.desc = [NSString stringWithFormat:@"线程安全OSSpinLock"];
    model14.leadImageName = @"tabbar-icon-selected-1";
    model14.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model14];
    [self.tableView.dataArray addObject: model14];
    
    
    DefualtCellModel *model15 = [DefualtCellModel new];
    model15.title = [NSString stringWithFormat:@""];
    model15.desc = [NSString stringWithFormat:@"Loop测试timer"];
    model15.leadImageName = @"tabbar-icon-selected-1";
    model15.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model15];
    [self.tableView.dataArray addObject: model15];
    
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
    
    
     self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"常驻线程测试1" style:UIBarButtonItemStylePlain target:self action:@selector(runloopTest2)],[[UIBarButtonItem alloc] initWithTitle:@"常驻线程测试2" style:UIBarButtonItemStylePlain target:self action:@selector(runloopTest)]];
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
        _thread = [RunloopTest networkRequestThread];
    }else if(index == 5){
        [_temp saveLooptest1];
    }else if(index == 6){
        [_temp saveLooptest2];
    }else if(index == 7){
         [_temp saveLooptest3];
    }
    else if(index == 8){
        [_temp saveLooptest4];
    }else if (index == 9){
         [_temp saveLooptest5];
    }else if (index == 10){
        [_temp saveLooptest6];
        
    }else if(index == 11){
         [_temp saveLooptest7];
    }
    
    else if(index == 12){
         [_temp saveLooptest8];
    }
    else if(index == 13){
         [_temp saveLooptest9];
    } else if(index == 14){
        [_temp testLoopWithTimer];
    }
    
    
}


-(void)runloopTest
{
    if (_thread == nil) {
      _thread =  [RunloopTest networkRequestThread];;
    }
    [self performSelector:@selector(testLoop) onThread: _thread withObject:@"hoggen" waitUntilDone:YES];
}

-(void)testLoop{
    NSLog(@"currentThread.name = %@", [[NSThread currentThread] name]);
    //常驻线程是可以运行timer的
//    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(actionTime:) userInfo:nil repeats:YES];
//
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    NSLog(@"testtesttest");
}

-(void)runloopTest2
{
    if (_temp.thread == nil) {
        [_temp stateRunLoop];
    }
    [self performSelector:@selector(testLoop) onThread: _temp.thread withObject:@"hoggen" waitUntilDone:YES];
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


- (void)actionTime:(NSTimer *)timer {
    NSLog(@"---- %@",[NSDate date]);
}


@end
