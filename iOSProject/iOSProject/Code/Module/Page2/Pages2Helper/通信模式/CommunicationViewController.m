//
//  CommunicationViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/21.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "CommunicationViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "ShowInfoViewController.h"
#import "ShowMessageModel.h"

@interface CommunicationViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation CommunicationViewController


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
    model.desc = [NSString stringWithFormat:@"Delegate,Notification,KVO前言"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@""];
    model2.desc = [NSString stringWithFormat:@"delegate"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@""];
    model3.desc = [NSString stringWithFormat:@"notification"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    [self.tableView.dataArray addObject: model3];
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@""];
    model4.desc = [NSString stringWithFormat:@"KVO"];
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
    
    
    
    
}

#pragma mark - Extension Delegate or Protocol

#pragma mark - YLTableViewDelete

-(void)didselectedCell:(NSInteger)index {
    
    NSLog(@"%@",@(index));
    if (index == 0) {
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"一般来说我们使用delegate,notification,KVO，都是为了实现程序的不过分耦合或者优化相关demo设计；所以一般APP中我们都会使用到：\n\n1.委托delegation\n\n2.通知中心Notification Center；\n\n3.键值观察key value observing，KVO\n\n 本质上说，我认为三种设计模式都是事件的传递，且可以有效避免对象之间的耦合（这是复用独立组件的基础）；" boldString:@"1.委托delegation\n\n2.通知中心Notification Center；\n\n3.键值观察key value observing，KVO" showType:TextType];
        [modelArray addObject: model];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 1){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"我喜欢称为代理和协议；代理即一个对象代理另一个对象实现代理方法；协议为遵守该协议的对象实现该协议的方法（或者说实现协议默认方法）；\n\n  delegate有清晰的事件传递链，可以很好的帮助理解程序的实现逻辑及流程\ndelegate的定义的语法严格（如定义方法可选和必须实现），避免遗忘和出错\ndelegate可以遵守多个协议，模拟了多继承的关系\ndelegate的方法直接定义到对象的结构体中，查找快速，效率高，消耗资源少\ndelegate除了传值意外也可以接受返回值\ndelegate方便于代码调试\n补充：\n\n定义和实现整个delegate必须包含（1.定义协议 2.遵守协议 3. 实现协议）\n使用delegate要避免循环引用\n一对一而非一对多" boldString:@"" showType:TextType];
        
        [modelArray addObject: model];

        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if (index == 2){
        
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"在IOS应用开发中有一个”Notification Center“的概念。它是一个单例对象，允许当事件发生时通知一些对象。它允许我们在低程度耦合的情况下，满足控制器与一个任意的对象进行通信的目的。\n\n优势\n\n系统自带的，实现简单\n能实现1对多的事件通知\n可以携带通知信息\n缺点：\n\n没有清晰的事件链，过多使用的情况下可能导致APP难以理解和维护\n调试时过程难以跟踪\n需要第三方单例来管理，使用key来辨识通知事件，（猜测接收通知的对象会被注册到Notification Center中，便于通知事件的查找；通知过多的情况下可能导致资源浪费）\n无法获取返回信息\n需要使用完毕后移除观察者，否则极易造成crash" boldString:@"" showType:TextType];
    
        [modelArray addObject: model];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if (index == 3){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"KVO是一个对象能够观察另外一个对象的属性的值，并且能够发现值的变化。这是一个对象与另外一个对象保持同步的一种方法，即当另外一种对象的状态发生改变时，观察对象马上作出反应。它只能用来对属性作出反应，而不会用来对方法或者动作作出反应。\n\n优点：\n\n能够提供一种简单的方法实现两个对象间的同步。例如：model和view之间同步；\n\n能够对非我们创建的对象，即内部对象的状态改变作出响应，而且不需要改变内部对象（SKD对象）的实现；\n\n能够提供观察的属性的最新值以及先前值；\n\n用key paths来观察属性，因此也可以观察嵌套对象；\n\n完成了对观察对象的抽象，因为不需要额外的代码来允许观察值能够被观察\n\n缺点：\n\n我们观察的属性必须使用strings来定义。因此在编译器不会出现警告以及检查；\n\n对属性重构将导致我们的观察代码不再可用；\n\n复杂的“IF”语句要求对象正在观察多个值。这是因为所有的观察代码通过一个方法来指向；\n\n当释放观察者时不需要移除观察者\n\n综上所述，我认为KVO的使用时明确的，而对于delegate和notification，我更偏向使用delegate\n\n而少用或者不用notification，从代码便于维护和结构清晰的角度考虑。" boldString:@"" showType:TextType];

        
        
        
        [modelArray addObject: model];
 
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
