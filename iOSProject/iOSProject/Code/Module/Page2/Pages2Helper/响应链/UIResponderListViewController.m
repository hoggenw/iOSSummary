//
//  UIResponderListViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/14.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "UIResponderListViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "ShowInfoViewController.h"
#import "ShowMessageModel.h"
#import "ResponderExampleListViewController.h"

@interface UIResponderListViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation UIResponderListViewController


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
-(void)exampleButtonAction{
    ResponderExampleListViewController *exampleList = [ResponderExampleListViewController new];
    [self.navigationController pushViewController: exampleList animated: true];
}

#pragma mark - Events


#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@"响应链"];
    model.desc = [NSString stringWithFormat:@"总结梳理与应用"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    //响应者入栈与响应
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@"响应链"];
    model2.desc = [NSString stringWithFormat:@"响应者入栈与响应"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    
    //响应者入栈与响应
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@""];
    model3.desc = [NSString stringWithFormat:@"不规则图形中的应用"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    [self.tableView.dataArray addObject: model3];
    //利用响应链传参
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@""];
    model4.desc = [NSString stringWithFormat:@"利用响应链传参"];
    model4.leadImageName = @"tabbar-icon-selected-1";
    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model4];
    [self.tableView.dataArray addObject: model4];
    
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
        ShowMessageModel * model = [self getModelWith:@"响应链总结梳理" boldString:@"响应链总结梳理" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"App使用响应者对象接收和处理事件，响应者对象是任何UIResponder的实例。UIResponder的子类包括UIView,UIViewController,UIApplication等。响应者接收到原始事件数据，必须处理事件或者转发到另一个响应者对象。当你的App接收到一个事件时，UIKit自动引导事件到最合适的响应者对象，也叫做第一响应者。\n\n响应链\n\n- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event; \n - (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;   // default returns YES if point is in bounds\n\n" boldString:@"响应链\n\n- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event;   // recursively calls -pointInside:withEvent:. point is in the receiver's coordinate system\n - (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;   // default returns YES if point is in bounds\n\n" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        vc.dataArray = modelArray;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//        [self presentViewController: nav animated:true completion:nil];
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 1){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"一个是根据点击坐标返回事件是否发生在本视图以内，另一个方法是返回响应点击事件的对象。\n   系统先调用pointInSide: WithEvent:判断当前视图以及这些视图的子视图是否能接收这次点击事件，然后在调用hitTest: withEvent:依次获取处理这个事件的所有视图对象，在获取所有的可处理事件对象后，开始调用这些对象的touches回调方法\n\n   第一个过程是建立响应链的过程，将可以响应该事件的对象找出来，UIApplication对象维护着自己的一个响应者栈，当pointInSide: withEvent:返回yes的时候，响应者入栈。" boldString:@"" showType:TextType];
        
        
        ShowMessageModel * model2 = [ShowMessageModel new];
        model2.image = [UIImage imageNamed:@"responder_png"];
        model2.showType = ImageType;
        
         ShowMessageModel * model3 = [self getModelWith:@"栈顶的响应者作为最优先处理事件的对象，假设最顶层的响应者不处理事件，那么出栈，移交给下一个响应者，以此下去，直到事件得到了处理或者到达AppDelegate后依旧未响应，事件被摒弃为止。" boldString:@"" showType:TextType];
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
         [modelArray addObject: model3];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if (index == 2){
        
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"不规则图形中的应用" boldString:@"不规则图形中的应用" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"利用下面的方法可以控制响应视图的响应范围\n\n- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event\n\n 在响应方法中做出响应的判断，返回true 表示响应该点击事件" boldString:@"- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"扩大按钮的点击范围。\n\n- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {\n   CGRect bounds = self.bounds;\n   bounds = CGRectInset(bounds, -10, -10);\n   // CGRectContainsPoint  判断点是否在矩形内\n   return CGRectContainsPoint(bounds, point);\n}\n\n 在响应方法中做出响应的判断，返回true 表示响应该点击事件" boldString:@"- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {\n   CGRect bounds = self.bounds;\n   bounds = CGRectInset(bounds, -10, -10);\n   // CGRectContainsPoint  判断点是否在矩形内\n   return CGRectContainsPoint(bounds, point);\n}" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if (index == 3){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"利用响应链传参" boldString:@"利用响应链传参" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"利用响应链UIResponder (Extension)可以使用路由的方式将相关的相应由路由方式将信息传递下去，从而简化程序设计的复杂结构" boldString:@"" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {\n//顺着相应链传递\n[[self nextResponder] routerEventWithName:eventName userInfo:userInfo];\n}\n\n在需要的响应者中重写这个方法即可。" boldString:@"- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {\n//顺着相应链传递\n[[self nextResponder] routerEventWithName:eventName userInfo:userInfo];\n}" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
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
