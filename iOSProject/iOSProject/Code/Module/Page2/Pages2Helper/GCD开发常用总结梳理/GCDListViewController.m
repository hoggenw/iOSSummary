//
//  GCDListViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/21.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "GCDListViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "ShowInfoViewController.h"
#import "ShowMessageModel.h"
#import "GCDTestListViewController.h"

@interface GCDListViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation GCDListViewController


#pragma mark - Override Methods

/**
 *在使用GCD的时候，我们会把需要处理的任务放到Block中，然后将任务追加到相应的队列里面，这个队列，叫做Dispatch Queue。然而，存在于两种Dispatch Queue，一种是要等待上一个执行完，再执行下一个的Serial Dispatch Queue，这叫做串行队列；另一种，则是不需要上一个执行完，就能执行下一个的Concurrent Dispatch Queue，叫做并行队列。这两种，均遵循FIFO原则
 *串行与并行针对的是队列，而同步与异步，针对的则是线程。最大的区别在于，同步线程要阻塞当前线程，必须要等待同步线程中的任务执行完，返回以后，才能继续执行下一任务；而异步线程则是不用等待。
 */

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

-(void)exampleButtonAction{
    GCDTestListViewController * vc = [GCDTestListViewController new];
    [self.navigationController pushViewController: vc animated: true];
}

#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@""];
    model.desc = [NSString stringWithFormat:@"一、相关概念"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@""];
    model2.desc = [NSString stringWithFormat:@"事例：队列"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    
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
    
    UIButton *exampleButton = [self creatNormalBUttonWithName:@"事例"];
    [exampleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(40));
    }];
    [exampleButton addTarget:self action:@selector(exampleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}

#pragma mark - Extension Delegate or Protocol

#pragma mark - YLTableViewDelete

-(void)didselectedCell:(NSInteger)index {
    
    NSLog(@"%@",@(index));
    if (index == 0) {
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"一、相关概念\nGCD全称Grand Central Dispatch，属于系统级的线程管理，通过 GCD，我们可以对当前程序执行的线程进行调度与控制，而不需要过度关注线程创建释放相关内容，这无疑大大节约了开发的精力，并且将繁琐的线程抽象起来，更有利于掌握和理解；" boldString:@"一、相关概念" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"* 串行（Serial）：让任务一个接着一个地执行（一个任务执行完毕后，再执行下一个任务）\n*并发（Concurrent）：可以让多个任务并发（同时）执行（自动开启多个线程同时执行任务）并发功能只有在异步（dispatch_async）函数下才有效。\n*同步（Synchronous）：在当前线程中执行任务，不具备开启新线程的能力\n*异步（Asynchronous）：在新的线程中执行任务，具备开启新线程的能力" boldString:@"" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 1){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"队列\n分为串行队列与并行队列，执行分为异步与同步" boldString:@"队列" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@" //串行队列的创建方法\ndispatch_queue_t queueSerial = dispatch_queue_create(\"test.queue\", DISPATCH_QUEUE_SERIAL);\n//并发队列的创建方法\ndispatch_queue_t queueC = dispatch_queue_create(\"conTest.queue\", DISPATCH_QUEUE_CONCURRENT);NSLog(@\"asyncConcurrent---begin\");\n//同步执行任务创建方法\n dispatch_sync(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"1---sync---%@\",[NSThread currentThread]);\n}\n });\ndispatch_sync(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"2---sync---%@\",[NSThread currentThread]);\n}\n });\ndispatch_sync(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"3---sync---%@\",[NSThread currentThread]);\n}\n});\n//异步执行任务创建方法\ndispatch_async(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\n NSLog(@\"1------%@\",[NSThread currentThread]);\n}\n});\ndispatch_async(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"2------%@\",[NSThread currentThread]);\n}\n});\ndispatch_async(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"3------%@\",[NSThread currentThread]);\n}\n});\nNSLog(@\"syncConcurrent---end\");\n//并发同步队列在一个线程中执行，并发异步队列则由系统分配的线程执行，执行速度不一定比当前线程的速度慢" boldString:@" //串行队列的创建方法\ndispatch_queue_t queueSerial = dispatch_queue_create(\"test.queue\", DISPATCH_QUEUE_SERIAL);\n//并发队列的创建方法\ndispatch_queue_t queueC = dispatch_queue_create(\"conTest.queue\", DISPATCH_QUEUE_CONCURRENT);NSLog(@\"asyncConcurrent---begin\");\n//同步执行任务创建方法\n dispatch_sync(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"1---sync---%@\",[NSThread currentThread]);\n}\n });\ndispatch_sync(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"2---sync---%@\",[NSThread currentThread]);\n}\n });\ndispatch_sync(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"3---sync---%@\",[NSThread currentThread]);\n}\n});\n//异步执行任务创建方法\ndispatch_async(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\n NSLog(@\"1------%@\",[NSThread currentThread]);\n}\n});\ndispatch_async(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"2------%@\",[NSThread currentThread]);\n}\n});\ndispatch_async(queueC, ^{\nfor (int i = 0; i < 2; ++i) {\nNSLog(@\"3------%@\",[NSThread currentThread]);\n}\n});\nNSLog(@\"syncConcurrent---end\");\n//并发同步队列在一个线程中执行，并发异步队列则由系统分配的线程执行，执行速度不一定比当前线程的速度慢" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 2){
        
    }else if (index == 3){
        
    }else if (index == 4){
        
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


-(ShowMessageModel *)getModelWith:(NSString *)content boldString:(NSString *)boldString showType:(ShowMessageType)showType{
    ShowMessageModel * model = [ShowMessageModel new];
    model.content =content;
    model.boldString = boldString;
    model.showType = showType;
    return model;
}
@end
