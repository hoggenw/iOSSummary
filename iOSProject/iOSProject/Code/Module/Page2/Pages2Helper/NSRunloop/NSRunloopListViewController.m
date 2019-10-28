//
//  NSRunloopListViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/22.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "NSRunloopListViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "ShowInfoViewController.h"
#import "ShowMessageModel.h"
#import "RunloopTestListViewController.h"

@interface NSRunloopListViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation NSRunloopListViewController


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

-(void)exampleButtonAction{
    RunloopTestListViewController * vc = [RunloopTestListViewController new];
    [self.navigationController pushViewController: vc animated: true];
}

#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@""];
    model.desc = [NSString stringWithFormat:@"RunLoop的定义"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@""];
    model2.desc = [NSString stringWithFormat:@"RunLoop机制"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@""];
    model3.desc = [NSString stringWithFormat:@"RunLoop相关类"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    [self.tableView.dataArray addObject: model3];
    
    
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
    
    UIButton *exampleButton = [UIButton makeBUtton:^(ButtonMaker * _Nonnull make) {
        make.addToSuperView(self.view).backgroundImageForState([UIImage imageWithColor:[UIColor whiteColor]],UIControlStateNormal).titleColorForState( [UIColor blackColor],UIControlStateNormal).titleForState(@"事例",UIControlStateNormal).addAction(self,@selector(exampleButtonAction),UIControlEventTouchUpInside);
    }];
 
    
    [exampleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(40));
    }];

}

#pragma mark - Extension Delegate or Protocol

#pragma mark - YLTableViewDelete

-(void)didselectedCell:(NSInteger)index {
    
    NSLog(@"%@",@(index));
    if (index == 0) {
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"RunLoop的定义\n\n当有持续的异步任务需求时，我们会创建一个独立的生命周期可控的线程。RunLoop就是控制线程生命周期并接收事件进行处理的机制。\nRunLoop是iOS事件响应与任务处理最核心的机制，它贯穿iOS整个系统。\n在我们开发iOS中有2套API来访问RunLoop\n\nFoundation: NSRunLoop\n\nCore Foundation: CFRunLoop 核心部分，代码开源，C 语言编写，跨平台" boldString:@"RunLoop的定义" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"目的\n通过RunLoop机制实现省电，流畅，响应速度快，用户体验好" boldString:@"目的" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"理解\n进程是一家工厂，线程是一个流水线，Run Loop就是流水线上的主管；当工厂接到商家的订单分配给这个流水线时，Run Loop就启动这个流水线，让流水线动起来，生产产品；当产品生产完毕时，Run Loop就会暂时停下流水线，节约资源。\nRunLoop管理流水线，流水线才不会因为无所事事被工厂销毁；而不需要流水线时，就会辞退RunLoop这个主管，即退出线程，把所有资源释放。\nRunLoop并不是iOS平台的专属概念，在任何平台的多线程编程中，为控制线程的生命周期，接收处理异步消息都需要类似RunLoop的循环机制实现，Android的Looper就是类似的机制。" boldString:@"理解" showType:TextType];
        
        ShowMessageModel * model4 = [self getModelWith:@"特性\n1.主线程的RunLoop在应用启动的时候就会自动创建\n2.其他线程则需要在该线程下自己启动\n3.不能自己创建RunLoop\n4. RunLoop并不是线程安全的，所以需要避免在其他线程上调用当前线程的RunLoop\n4. RunLoop负责管理autorelease pools\n5.RunLoop负责处理消息事件，即输入源事件和计时器事件" boldString:@"特性" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 1){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"RunLoop机制\n\n主线程 (有 RunLoop 的线程) 几乎所有函数都从以下六个之一的函数调起:" boldString:@"RunLoop机制" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION  \n\n  CFRunloop is calling out to an abserver callback function \n\n  用于向外部报告 RunLoop 当前状态的更改，框架中很多机制都由 RunLoopObserver 触发，如 CAAnimation" boldString:@"" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK  \n\n  CFRunloop is calling out to a block \n\n  消息通知、非延迟的perform、dispatch调用、block回调、KVO" boldString:@"" showType:TextType];
        
       ShowMessageModel * model4 = [self getModelWith:@"CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE  \n\n  CFRunloop is servicing the main desipatch queue \n\n " boldString:@"" showType:TextType];
        
        ShowMessageModel * model5 = [self getModelWith:@"CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION  \n\n  CFRunloop is calling out to a timer callback function \n\n 延迟的perform, 延迟dispatch调用" boldString:@"" showType:TextType];
        
        
        ShowMessageModel * model6 = [self getModelWith:@"CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION  \n\n  CFRunloop is calling out to a source 0 perform function \n\n 处理App内部事件、App自己负责管理（触发），如UIEvent、CFSocket。普通函数调用，系统调用" boldString:@"" showType:TextType];
        
        
         ShowMessageModel * model7 = [self getModelWith:@"CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE1_PERFORM_FUNCTION  \n\n  CFRunloop is calling out to a source 1 perform function \n\n 由RunLoop和内核管理，Mach port驱动，如CFMachPort、CFMessagePort\n\n\nRunLoop 架构" boldString:@"RunLoop 架构" showType:TextType];
        
        ShowMessageModel * model8 = [ShowMessageModel new];
        model8.showType = ImageType;
        model8.image = [UIImage imageNamed: @"runloop_image_png"];
        
        ShowMessageModel * model9 = [self getModelWith:@"RunLoop 运行时" boldString:@"RunLoop 运行时" showType:TextType];
        
        ShowMessageModel * model10 = [ShowMessageModel new];
        model10.showType = ImageType;
        model10.image = [UIImage imageNamed: @"runloop_active_png"];
        
        
        ShowMessageModel * model11 = [self getModelWith:@"主要有以下六种状态：\n\nkCFRunLoopEntry -- 进入runloop循环\nkCFRunLoopBeforeTimers -- 处理定时调用前回调\nkCFRunLoopBeforeSources -- 处理input sources的事件\nkCFRunLoopBeforeWaiting -- runloop睡眠前调用\nkCFRunLoopAfterWaiting -- runloop唤醒后调用\nkCFRunLoopExit -- 退出runloop" boldString:@"" showType:TextType];
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        [modelArray addObject: model5];
        [modelArray addObject: model6];
        [modelArray addObject: model7];
        [modelArray addObject: model8];
        [modelArray addObject: model9];
        [modelArray addObject: model10];
        [modelArray addObject: model11];
        
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 2){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"RunLoop相关类\n\nCore Foundation中关于RunLoop的5个类\n\n1.CFRunLoopRef\n2.CFRunLoopModeRef\n3.CFRunLoopSourceRef\n4.CFRunLoopTimerRef\n5.CFRunLoopObserverRef\n\nCFRunLoopRef代表RunLoop的实体类，一个RunLoop中包含若干个Mode，而每个mode又包含若干个Source／Timer／Observer。" boldString:@"RunLoop相关类" showType:TextType];
        
        ShowMessageModel * model2 = [self getModelWith:@"理解\n\n1.每次运行RunLoop都必须指定其中一个mode，如果没有mode，RunLoop无法运行，而这个mode被称为当前mode。\n2.如果要切换mode，只能退出当前RunLoop，然后再重新指定个mode进入。\n3.为什么要像2这样做呢？不是很麻烦吗？苹果这样做是为了区分不同组的Source／Timer／Observer。" boldString:@"理解" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"系统默认的5个mode\n\nNSDefaultRunLoopMode\n这个mode一般是主线程RunLoop的默认mode。创建线程之初RunLoop是以这种mode运行的。\n\nUITrackingRunLoopMode\n这个mode是保证滑动ScrollView滑动不受影响，比如滑动tableView的时候主线程就切到这个mode上了。\n\nUITInitializationRunLoopMode\n在刚启动App的时候第一次进入的mode，启动后就不进入此mode了，本人理解是为了防止App进入时选择了其他mode而运行错乱。\n\nGSEventReceiveRunLoopMode\n接受系统内部的mode，通常不用。\n\nNSRunLoopCommonModes\n这个mode是包换1和2的，因此解有个一个问题。定时器触发的时候滑动TableView定时器会停止。这是因为默认是在第一个mode上运行，在滑动的时候RunLoop切换到了第二个mode，所以第一个mode上的任务就被搁置了。\nSo，解决这个问题就直接把Timer加入到第五个mode中就完美解决了，滑动的时候也不影响定时器的触发" boldString:@"系统默认的5个mode" showType:TextType];
        
        ShowMessageModel * model4 = [self getModelWith:@"特性\n1.主线程的RunLoop在应用启动的时候就会自动创建\n2.其他线程则需要在该线程下自己启动\n3.不能自己创建RunLoop\n4. RunLoop并不是线程安全的，所以需要避免在其他线程上调用当前线程的RunLoop\n4. RunLoop负责管理autorelease pools\n5.RunLoop负责处理消息事件，即输入源事件和计时器事件" boldString:@"特性" showType:TextType];
        
        ShowMessageModel * model5 = [self getModelWith:@"事件源（输入源）\nSource是事件源也是输入源，比如点击Button按钮、滑动TableView都是一种事件源，告诉RunLoop需要去做什么！\n\nCFRunLoopSourceRef分两种：\n\nSource0：非基于Port端口，自定义的方法函数、SelectorPerform。简单理解就是你写的就是。\n\nSource1：基于Port端口，系统提供默认的方法函数，比如UIApplicationMain。" boldString:@"事件源（输入源）" showType:TextType];
        
        ShowMessageModel * model6 = [self getModelWith:@"事件源（输入源）\nSource是事件源也是输入源，比如点击Button按钮、滑动TableView都是一种事件源，告诉RunLoop需要去做什么！\n\nCFRunLoopSourceRef分两种：\n\nSource0：非基于Port端口，自定义的方法函数、SelectorPerform。简单理解就是你写的就是。\n\nSource1：基于Port端口，系统提供默认的方法函数，比如UIApplicationMain。" boldString:@"事件源（输入源）" showType:TextType];
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        [modelArray addObject: model5];
        [modelArray addObject: model6];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
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


-(ShowMessageModel *)getModelWith:(NSString *)content boldString:(NSString *)boldString showType:(ShowMessageType)showType{
    ShowMessageModel * model = [ShowMessageModel new];
    model.content =content;
    model.boldString = boldString;
    model.showType = showType;
    return model;
}
@end
