//
//  RAMManagerViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/15.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "RAMManagerViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "ShowInfoViewController.h"
#import "ShowMessageModel.h"
#import "RAMExamapleListViewController.h"

@interface RAMManagerViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation RAMManagerViewController


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
    RAMExamapleListViewController *exampleList = [RAMExamapleListViewController new];
    [self.navigationController pushViewController: exampleList animated: true];
}

#pragma mark - Events


#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@"拷贝与内存管理"];
    model.desc = [NSString stringWithFormat:@"拷贝的总结"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
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
        ShowMessageModel * model = [self getModelWith:@"理解\n\n本质上我认为区别在于复制是是指针复制（浅拷贝）还是复制到新的地址上（深拷贝）" boldString:@"理解" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"大体上会区分为对象和容器两个概念，对象的copy是浅拷贝，mutablecopy是深拷贝。在OC中不是所有的类都支持拷贝，只有遵循<NSCopying>才支持copy，只有遵循<NSMutableCopying>才支持mutableCopy。如果没有遵循，拷贝时会直接Crash。\n 遵守协议以后，无论是copy还是mutableCopy，对于对象而言都是深拷贝；对对象内的属性重新赋值，不会改变其他对象的属性的值，因为赋值本质上来说是赋予新对象的属性指针" boldString:@"大体上会区分为对象和容器两个概念，对象的copy是浅拷贝，mutablecopy是深拷贝。" showType:TextType];
        
       
        
        ShowMessageModel * model3 = [self getModelWith:@"容器包含对象的拷贝，无论是copy，还是mutablecopy都是浅拷贝，要想实现对象的深拷贝，必须自己提供拷贝方法" boldString:@"容器包含对象的拷贝，无论是copy，还是mutablecopy都是浅拷贝，要想实现对象的深拷贝，必须自己提供拷贝方法" showType:TextType];
        
         ShowMessageModel * model4 = [self getModelWith:@"非容器不可变对象：NSString\n\n 1. 对于非容器不可变对象的copy为浅拷贝，mutableCopy为深拷贝\n2. 浅拷贝获得的对象地址和原对象地址一致， 返回的对象为不可变对象\n3. 深拷贝返回新的内存地址，返回对象为可变对象\n" boldString:@"非容器不可变对象：NSString" showType:TextType];
        
         ShowMessageModel * model5 = [self getModelWith:@"非容器可变对象： NSMutableString\n\n对于可变对象的的拷贝，无论是copy还是mutabelCopy，都为深拷贝，且拷贝后返回的对象也是可变的" boldString:@"非容器可变对象： NSMutableString" showType:TextType];
        
        ShowMessageModel * model6 = [self getModelWith:@"容器类不可变对象： NSArray\n\n1.容器类不可变对象 copy只是指针copy ，mutableCopy，容器内是地址重新copy是深拷贝\n2.但是容器内的对象无论是可变与不可变对象都是浅拷贝\n" boldString:@"容器类不可变对象： NSArray" showType:TextType];
        
        ShowMessageModel * model7 = [self getModelWith:@"容器类可变对象： NSMutableArray\n\n  1.容器类可变对象 copy和mutableCopy是深拷贝\n2.但是容器内的对象无论是可变与不可变对象都是浅拷贝\n" boldString:@"容器类可变对象： NSMutableArray" showType:TextType];
        
        ShowMessageModel * model8 = [self getModelWith:@"小结：copy： 对于可变对象为深拷贝，对于不可变对象为浅拷贝； mutableCopy：始终是深拷贝,所谓拷贝，本质上是持有指针（无论是新的地址还是原来的地址）;此外对可变容器赋值时，如果没有使用copy进行赋值，者修改其中一个内容时，其他内容会被修改(思考方向可以从引用指针和引用指针计数上开始)。不可变容器则不受影响." boldString:@"小结：copy： 对于可变对象为深拷贝，对于不可变对象为浅拷贝； mutableCopy：始终是深拷贝,所谓拷贝，本质上是持有指针（无论是新的地址还是原来的地址）;此外对可变容器赋值时，如果没有使用copy进行赋值，者修改其中一个内容时，其他内容会被修改(思考方向可以从引用指针和引用指针计数上开始)。不可变容器则不受影响." showType:TextType];
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        [modelArray addObject: model5];
        [modelArray addObject: model6];
        [modelArray addObject: model7];
        [modelArray addObject: model8];
        vc.dataArray = modelArray;
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
