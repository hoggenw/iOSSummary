//
//  RuntimeListViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/4/16.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "RuntimeListViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "ShowInfoViewController.h"
#import "ShowMessageModel.h"


@interface RuntimeListViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation RuntimeListViewController


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
    model.title = [NSString stringWithFormat:@"动态语言"];
    model.desc = [NSString stringWithFormat:@"Runtime"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@"消息机制"];
    model2.desc = [NSString stringWithFormat:@"基本原理"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@"Runtime"];
    model3.desc = [NSString stringWithFormat:@"Runtime使用"];
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
    
    
    
    
    
}

#pragma mark - Extension Delegate or Protocol

#pragma mark - YLTableViewDelete

-(void)didselectedCell:(NSInteger)index {
    
    NSLog(@"%@",@(index));
    if (index == 0) {
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [ShowMessageModel new];
        model.content = @"OC是动态语言，Runtime又是什么？";
        model.boldString = @"OC是动态语言，Runtime又是什么？";
        model.showType = TextType;
        
        
        ShowMessageModel * model2 = [ShowMessageModel new];
        model2.content = @"动态语言:我们常说OC是一门动态语言，就是因为它总是把一些决定性的工作从编译阶段推迟到运行时阶段。OC代码的运行不仅需要编译器，还需要运行时系统(Runtime System)来执行编译后的代码。";
        model2.boldString = @"动态语言";
        model2.showType = TextType;
        
        
        
        ShowMessageModel * model3 = [ShowMessageModel new];
        model3.content = @"Runtime是一套底层纯C语言API，OC代码最终都会被编译器转化为运行时代码，通过消息机制决定函数调用方式，这也是OC作为动态语言使用的基础。";
        model3.boldString = @"Runtime";
        model3.showType = TextType;
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 1){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [ShowMessageModel new];
        model.content = @"OC的方法调用都是类似[receiver selector]的形式";
        model.boldString = @"OC的方法调用都是类似[receiver selector]的形式";
        model.showType = TextType;
        
        
        ShowMessageModel * model2 = [ShowMessageModel new];
        model2.content = @"第一步：编译阶段";
        model2.boldString = @"第一步：编译阶段";
        model2.showType = TextType;
        
        
        
        ShowMessageModel * model3 = [ShowMessageModel new];
        model3.content = @"[receiver selector]方法被编译器转化，分为两种情况：\n1.不带参数的方法被编译为：objc_msgSend(receiver，selector)\n2.带参数的方法被编译为：objc_msgSend(recevier，selector，org1，org2，…)";
        model3.boldString = @"";
        model3.showType = TextType;
        
        
        ShowMessageModel * model4 = [ShowMessageModel new];
        model4.content = @"第二步：运行时阶段";
        model4.boldString = @"第二步：运行时阶段";
        model4.showType = TextType;
        
        
        ShowMessageModel * model5 = [ShowMessageModel new];
        model5.content = @"消息接收者recever寻找对应的selector，也分为两种情况：\n1.接收者能找到对应的selector，直接执行接收receiver对象的selector方法。\n2.接收者找不到对应的selector，消息被转发或者临时向接收者添加这个selector对应的实现内容，否则崩溃。";
        model5.boldString = @"";
        model5.showType = TextType;
        
        
        ShowMessageModel * model6 = [ShowMessageModel new];
        model6.content = @"说明：OC调用方法[receiver selector]，编译阶段确定了要向哪个接收者发送message消息，但是接收者如何响应决定于运行时的判断。";
        model6.boldString = @"说明：OC调用方法[receiver selector]，编译阶段确定了要向哪个接收者发送message消息，但是接收者如何响应决定于运行时的判断。";
        model6.showType = TextType;
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        [modelArray addObject: model5];
        [modelArray addObject: model6];
        
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 2){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [ShowMessageModel new];
        model.content = @"Runtime的使用";
        model.boldString = @"Runtime的使用";
        model.showType = TextType;
        
        
        ShowMessageModel * model2 = [ShowMessageModel new];
        model2.content = @"OC代码使用：OC代码会在编译阶段被编译器转化。OC中的类、方法和协议等在Runtime中都由一些数据结构来定义。所以，我们平时直接使用OC编写代码，其实这已经是在和Runtime进行交互了，只不过这个过程对于我们来说是无感的。";
        model2.boldString = @"OC代码使用：";
        model2.showType = TextType;
        
        
        
        ShowMessageModel * model3 = [ShowMessageModel new];
        model3.content = @"NSObject方法使用：Runtime的最大特征就是实现了OC语言的动态特性。作为大部分Objective-C类继承体系的根类的NSObject，其本身就具有了一些非常具有运行时动态特性的方法，比如respondsToSelector:方法可以检查在代码运行阶段当前对象是否能响应指定的消息，所以使用这些方法也算是一种与Runtme的交互方式，类似的方法还有如下：";
        model3.boldString = @"NSObject方法使用：";
        model3.showType = TextType;
        
        
        ShowMessageModel * model4 = [ShowMessageModel new];
        model4.content = @"-description：//返回当前类的描述信息 \n-class //方法返回对象的类；\n-isKindOfClass: 和 -isMemberOfClass:  //检查对象是否存在于指定的类的继承体系中 \n-respondsToSelector:    //检查对象能否响应指定的消息(包括协议消息)；\n-conformsToProtocol:    //检查对象是否实现了指定协议类的方法；\n-methodForSelector:     //返回指定方法实现的地址。";
        model4.boldString = @"-description：//返回当前类的描述信息 \n-class //方法返回对象的类；\n-isKindOfClass: 和 -isMemberOfClass:  //检查对象是否存在于指定的类的继承体系中 \n-respondsToSelector:    //检查对象能否响应指定的消息(包括协议消息)；\n-conformsToProtocol:    //检查对象是否实现了指定协议类的方法；\n-methodForSelector:     //返回指定方法实现的地址。";
        model4.showType = TextType;
        
        
        ShowMessageModel * model5 = [ShowMessageModel new];
        model5.content = @"Runtime函数使用：Runtime系统是一个由一系列函数和数据结构组成，具有公共接口的动态共享库。头文件存放于/usr/include/objc目录下。在我们工程代码里引用Runtime的头文件，同样能够实现类似OC代码的效果，一些代码示例如下";
        model5.boldString = @"Runtime函数使用：";
        model5.showType = TextType;
        
        
        ShowMessageModel * model6 = [ShowMessageModel new];
        model6.content = @"//相当于：Class class = [UIView class]; \nClass viewClass = objc_getClass(\"UIView\");\n//相当于：UIView *view = [UIView alloc];\nUIView *view = ((id (*)(id, SEL))(void *)objc_msgSend)((id)viewClass, sel_registerName(\"alloc\"));\n//相当于：UIView *view = [view init];\n((id (*)(id, SEL))(void *)objc_msgSend)((id)view, sel_registerName(\"init\"));";
        model6.boldString = @"";
        model6.showType = TextType;
        
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
@end
