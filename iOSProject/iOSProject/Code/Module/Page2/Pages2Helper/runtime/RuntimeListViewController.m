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
    
    //Runtime中数据结构
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@"Runtime"];
    model4.desc = [NSString stringWithFormat:@"Runtime中数据结构"];
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
        ShowMessageModel * model = [self getModelWith:@"OC是动态语言，Runtime又是什么？" boldString:@"OC是动态语言，Runtime又是什么？" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"动态语言:我们常说OC是一门动态语言，就是因为它总是把一些决定性的工作从编译阶段推迟到运行时阶段。OC代码的运行不仅需要编译器，还需要运行时系统(Runtime System)来执行编译后的代码。" boldString:@"动态语言" showType:TextType];
        ShowMessageModel * model3 = [self getModelWith:@"Runtime是一套底层纯C语言API，OC代码最终都会被编译器转化为运行时代码，通过消息机制决定函数调用方式，这也是OC作为动态语言使用的基础。" boldString:@"Runtime" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 1){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"OC的方法调用都是类似[receiver selector]的形式" boldString:@"OC的方法调用都是类似[receiver selector]的形式" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"第一步：编译阶段" boldString:@"第一步：编译阶段" showType:TextType];
        ShowMessageModel * model3 = [self getModelWith:@"[receiver selector]方法被编译器转化，分为两种情况：\n1.不带参数的方法被编译为：objc_msgSend(receiver，selector)\n2.带参数的方法被编译为：objc_msgSend(recevier，selector，org1，org2，…)" boldString:@"" showType:TextType];
        ShowMessageModel * model4 = [self getModelWith:@"第二步：运行时阶段" boldString:@"第二步：运行时阶段" showType:TextType];
        ShowMessageModel * model5 = [self getModelWith:@"消息接收者recever寻找对应的selector，也分为两种情况：\n1.接收者能找到对应的selector，直接执行接收receiver对象的selector方法。\n2.接收者找不到对应的selector，消息被转发或者临时向接收者添加这个selector对应的实现内容，否则崩溃。" boldString:@"" showType:TextType];
        ShowMessageModel * model6 = [self getModelWith:@"说明：OC调用方法[receiver selector]，编译阶段确定了要向哪个接收者发送message消息，但是接收者如何响应决定于运行时的判断。" boldString:@"说明：OC调用方法[receiver selector]，编译阶段确定了要向哪个接收者发送message消息，但是接收者如何响应决定于运行时的判断。" showType:TextType];
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
        ShowMessageModel * model = [self getModelWith:@"Runtime的使用" boldString:@"Runtime的使用" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"OC代码使用：OC代码会在编译阶段被编译器转化。OC中的类、方法和协议等在Runtime中都由一些数据结构来定义。所以，我们平时直接使用OC编写代码，其实这已经是在和Runtime进行交互了，只不过这个过程对于我们来说是无感的。" boldString:@"OC代码使用：" showType:TextType];
        ShowMessageModel * model3 = [self getModelWith:@"NSObject方法使用：Runtime的最大特征就是实现了OC语言的动态特性。作为大部分Objective-C类继承体系的根类的NSObject，其本身就具有了一些非常具有运行时动态特性的方法，比如respondsToSelector:方法可以检查在代码运行阶段当前对象是否能响应指定的消息，所以使用这些方法也算是一种与Runtme的交互方式，类似的方法还有如下：" boldString:@"NSObject方法使用：" showType:TextType];
        ShowMessageModel * model4 = [self getModelWith:@"-description：//返回当前类的描述信息 \n-class //方法返回对象的类；\n-isKindOfClass: 和 -isMemberOfClass:  //检查对象是否存在于指定的类的继承体系中 \n-respondsToSelector:    //检查对象能否响应指定的消息(包括协议消息)；\n-conformsToProtocol:    //检查对象是否实现了指定协议类的方法；\n-methodForSelector:     //返回指定方法实现的地址。" boldString:@"-description：//返回当前类的描述信息 \n-class //方法返回对象的类；\n-isKindOfClass: 和 -isMemberOfClass:  //检查对象是否存在于指定的类的继承体系中 \n-respondsToSelector:    //检查对象能否响应指定的消息(包括协议消息)；\n-conformsToProtocol:    //检查对象是否实现了指定协议类的方法；\n-methodForSelector:     //返回指定方法实现的地址。" showType:TextType];
        ShowMessageModel * model5 = [self getModelWith:@"Runtime函数使用：Runtime系统是一个由一系列函数和数据结构组成，具有公共接口的动态共享库。头文件存放于/usr/include/objc目录下。在我们工程代码里引用Runtime的头文件，同样能够实现类似OC代码的效果，一些代码示例如下" boldString:@"Runtime函数使用：" showType:TextType];
        ShowMessageModel * model6 = [self getModelWith:@"//相当于：Class class = [UIView class]; \nClass viewClass = objc_getClass(\"UIView\");\n//相当于：UIView *view = [UIView alloc];\nUIView *view = ((id (*)(id, SEL))(void *)objc_msgSend)((id)viewClass, sel_registerName(\"alloc\"));\n//相当于：UIView *view = [view init];\n((id (*)(id, SEL))(void *)objc_msgSend)((id)view, sel_registerName(\"init\"));" boldString:@"" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        [modelArray addObject: model5];
        [modelArray addObject: model6];
        
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
        
        
    }else if (index == 3){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"Runtime中数据结构？" boldString:@"Runtime中数据结构？" showType:TextType];
        
        ShowMessageModel * model2 = [self getModelWith:@"OC代码被编译器转化为C语言，然后再通过运行时执行，最终实现了动态调用。这其中的OC类、对象和方法等都对应了C中的结构体，而且我们都可以在Rutime源码中找到它们的定义。\n 那么，我们如何来查看Runtime的代码呢？其实很简单，只需要我们在当前代码文件中引用头文件 \n\n  #import <objc/runtime.h> \n#import <objc/message.h>" boldString:@"#import <objc/runtime.h> \n#import <objc/message.h>" showType:TextType];
        ShowMessageModel * model3 = [self getModelWith:@"Runtime是一套底层纯C语言API，OC代码最终都会被编译器转化为运行时代码，通过消息机制决定函数调用方式，这也是OC作为动态语言使用的基础。" boldString:@"Runtime" showType:TextType];
        ShowMessageModel * model4 = [self getModelWith:@"1.id—>objc_object  \n\nid是一个指向objc_object结构体的指针，即在Runtime中：" boldString:@"1.id—>objc_object" showType:TextType];
        ShowMessageModel * model5 = [self getModelWith:@"typedef struct objc_object *id;  \n\n Runtime中对objc_object结构体的具体定义" boldString:@"typedef struct objc_object *id;" showType:TextType];
        ShowMessageModel * model6 = [self getModelWith:@"///Represents an instance of a class.\nstruct objc_object {\nClass _Nonnull isa  OBJC_ISA_AVAILABILITY;\n};\n 我们都知道id在OC中是表示一个任意类型的类实例，从这里也可以看出，OC中的对象虽然没有明显的使用指针，但是在OC代码被编译转化为C之后，每个OC对象其实都是拥有一个isa的指针的。" boldString:@"///Represents an instance of a class.\nstruct objc_object {\nClass _Nonnull isa  OBJC_ISA_AVAILABILITY;\n}" showType:TextType];
        ShowMessageModel * model7 = [self getModelWith:@"2.Class - >objc_classs\n\nclass是一个指向objc_class结构体的指针，即在Runtime中：" boldString:@"2.Class - >objc_classs" showType:TextType];
         ShowMessageModel * model8 = [self getModelWith:@"typedef struct objc_class *Class; \n\n下面是Runtime中对objc_class结构体的具体定义：" boldString:@"typedef struct objc_class *Class; " showType:TextType];
        ShowMessageModel * model9 = [self getModelWith:@"//usr/include/objc/runtime.h\nstruct objc_class {\n  Class _Nonnull isa OBJC_ISA_AVAILABILITY;\n#if !OBJC2\n Class Nullable super_class       OBJC2UNAVAILABLE;\n const char * Nonnull name                               OBJC2UNAVAILABLE;\n long version       OBJC2_UNAVAILABLE;\n long info       OBJC2_UNAVAILABLE;\n long instance_size                                       OBJC2_UNAVAILABLE;\n struct objc_ivar_list * Nullable ivars       OBJC2UNAVAILABLE;\n struct objc_method_list * Nullable * _Nullable methodLists       OBJC2UNAVAILABLE;\n struct objc_cache * Nonnull cache       OBJC2UNAVAILABLE;\nstruct objc_protocol_list * Nullable protocols       OBJC2UNAVAILABLE;\n #endif\n} OBJC2_UNAVAILABLE;" boldString:@"//usr/include/objc/runtime.h\nstruct objc_class {\n  Class _Nonnull isa OBJC_ISA_AVAILABILITY;\n#if !OBJC2\n Class Nullable super_class       OBJC2UNAVAILABLE;\n const char * Nonnull name                               OBJC2UNAVAILABLE;\n long version       OBJC2_UNAVAILABLE;\n long info       OBJC2_UNAVAILABLE;\n long instance_size                                       OBJC2_UNAVAILABLE;\n struct objc_ivar_list * Nullable ivars       OBJC2UNAVAILABLE;\n struct objc_method_list * Nullable * _Nullable methodLists       OBJC2UNAVAILABLE;\n struct objc_cache * Nonnull cache       OBJC2UNAVAILABLE;\nstruct objc_protocol_list * Nullable protocols       OBJC2UNAVAILABLE;\n #endif\n} OBJC2_UNAVAILABLE;" showType:TextType];
        
        ShowMessageModel * model10 = [self getModelWith:@"isa指针：\n  我们会发现objc_class和objc_object同样是结构体，而且都拥有一个isa指针。我们很容易理解objc_object的isa指针指向对象的定义，那么objc_class的指针是怎么回事呢？\n其实，在Runtime中Objc类本身同时也是一个对象。Runtime把类对象所属类型就叫做元类，用于描述类对象本身所具有的特征，最常见的类方法就被定义于此，所以objc_class中的isa指针指向的是元类，每个类仅有一个类对象，而每个类对象仅有一个与之相关的元类。" boldString:@"isa指针：" showType:TextType];
        
        ShowMessageModel * model11 = [self getModelWith:@"cache:\n  为了优化性能，objc_class中的cache结构体用于记录每次使用类或者实例对象调用的方法。这样每次响应消息的时候，Runtime系统会优先在cache中寻找响应方法，相比直接在类的方法列表中遍历查找，效率更高。" boldString:@"cache:" showType:TextType];
        ShowMessageModel * model12 = [self getModelWith:@"ivars:\n  ivars用于存放所有的成员变量和属性信息，属性的存取方法都存放在methodLists中。" boldString:@"ivars:" showType:TextType];
         ShowMessageModel * model13 = [self getModelWith:@"methodLists：\n  methodLists用于存放对象的所有成员方法。" boldString:@"methodLists：" showType:TextType];
        
        ShowMessageModel * model14 = [self getModelWith:@"3.SEL\n\n  SEL是一个指向objc_selector结构体的指针，即在Runtime中：" boldString:@"3.SEL" showType:TextType];
        
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
        [modelArray addObject: model12];
        [modelArray addObject: model13];
         [modelArray addObject: model14];
        
        
        
        
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
