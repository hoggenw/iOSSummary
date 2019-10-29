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
#import "RuntimeExampleListViewController.h"


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
-(void)exampleButtonAction{
    RuntimeExampleListViewController *exampleList = [RuntimeExampleListViewController new];
    [self.navigationController pushViewController: exampleList animated: true];
}

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
    //Rutime消息发送
    
    DefualtCellModel *model5 = [DefualtCellModel new];
    model5.title = [NSString stringWithFormat:@"Runtime"];
    model5.desc = [NSString stringWithFormat:@"Rutime消息发送"];
    model5.leadImageName = @"tabbar-icon-selected-1";
    model5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model5];
    [self.tableView.dataArray addObject: model5];
    
    DefualtCellModel *model6 = [DefualtCellModel new];
    model6.title = [NSString stringWithFormat:@"Runtime"];
    model6.desc = [NSString stringWithFormat:@"多继承的实现思路"];
    model6.leadImageName = @"tabbar-icon-selected-1";
    model6.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model6];
    [self.tableView.dataArray addObject: model6];
    
    DefualtCellModel *model7 = [DefualtCellModel new];
    model7.title = [NSString stringWithFormat:@"Runtime"];
    model7.desc = [NSString stringWithFormat:@"开发中的应用"];
    model7.leadImageName = @"tabbar-icon-selected-1";
    model7.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model7];
    [self.tableView.dataArray addObject: model7];
    
    //动态方法交换：Method Swizzling
    DefualtCellModel *model8 = [DefualtCellModel new];
    model8.title = [NSString stringWithFormat:@""];
    model8.desc = [NSString stringWithFormat:@"动态方法交换：Method Swizzling"];
    model8.leadImageName = @"tabbar-icon-selected-1";
    model8.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model8];
    [self.tableView.dataArray addObject: model8];
    //拦截并替换系统方法
    DefualtCellModel *model9 = [DefualtCellModel new];
    model9.title = [NSString stringWithFormat:@"Runtime"];
    model9.desc = [NSString stringWithFormat:@"拦截并替换系统方法"];
    model9.leadImageName = @"tabbar-icon-selected-1";
    model9.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model9];
    [self.tableView.dataArray addObject: model9];
    
    //分类添加新属性
    DefualtCellModel *model10 = [DefualtCellModel new];
    model10.title = [NSString stringWithFormat:@"Runtime"];
    model10.desc = [NSString stringWithFormat:@"分类添加新属性"];
    model10.leadImageName = @"tabbar-icon-selected-1";
    model10.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model10];
    [self.tableView.dataArray addObject: model10];
    
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
        
        ShowMessageModel * model15 = [self getModelWith:@"typedef struct objc_selector *SEL;\n\n  SEL在OC中称作方法选择器，用于表示运行时方法的名字，然而我们并不能在Runtime中找到它的结构体的详细定义。Objective-C在编译时，会依据每一个方法的名字、参数序列，生成一个唯一的整型标识(Int类型的地址)，这个标识就是SEL。\n\n注意：\n1.不同类中相同名字的方法对应的方法选择器是相同的。\n2.即使是同一个类中，方法名相同而变量类型不同也会导致它们具有相同的方法选择器。\n通常我们获取SEL有三种方法：\n1.OC中，使用@selector(“方法名字符串”)\n2.OC中，使用NSSelectorFromString(“方法名字符串”)\n 3.Runtime方法，使用sel_registerName(“方法名字符串”)" boldString:@"typedef struct objc_selector *SEL;" showType:TextType];
        
        ShowMessageModel * model16 = [self getModelWith:@"4.Ivar\n\n  Ivar代表类中实例变量的类型，是一个指向ojbcet_ivar的结构体的指针，即在Runtime中：\n\n typedef struct objc_ivar *Ivar;\n\n 下面是Runtime中对objc_ivar结构体的具体定义：" boldString:@"4.Ivar" showType:TextType];
        ShowMessageModel * model17 = [self getModelWith:@"struct objc_ivar {\n  char * Nullable ivar_name    OBJC2UNAVAILABLE;\n  char * Nullable ivar_type    OBJC2UNAVAILABLE;\n  int ivar_offset    OBJC2_UNAVAILABLE;\n#ifdef LP64\n  int space    OBJC2_UNAVAILABLE;\n#endif\n} \n  我们在objc_class中看到的ivars成员列表,其中的元素就是Ivar，我可以通过实例查找其在类中的名字，这个过程被称为反射，下面的class_copyIvarList获取的不仅有实例变量还有属性：" boldString:@"struct objc_ivar {\n  char * Nullable ivar_name    OBJC2UNAVAILABLE;\n  char * Nullable ivar_type    OBJC2UNAVAILABLE;\n  int ivar_offset    OBJC2_UNAVAILABLE;\n#ifdef LP64\n  int space    OBJC2_UNAVAILABLE;\n#endif\n} " showType:TextType];
        
        ShowMessageModel * model18 = [self getModelWith:@"Ivar *ivarList = class_copyIvarList([self class], &count);\nfor (int i= 0; i<count; i++) {\nIvar ivar = ivarList[i];\nconst char *ivarName = ivar_getName(ivar);\nNSLog(@\"Ivar(%d): %@\", i, [NSString stringWithUTF8String:ivarName]);\n}\nfree(ivarList)；" boldString:@"Ivar *ivarList = class_copyIvarList([self class], &count);\nfor (int i= 0; i<count; i++) {\nIvar ivar = ivarList[i];\nconst char *ivarName = ivar_getName(ivar);\nNSLog(@\"Ivar(%d): %@\", i, [NSString stringWithUTF8String:ivarName]);\n}\nfree(ivarList)；" showType:TextType];
        
         ShowMessageModel * model19 = [self getModelWith:@"5.Method\n\n  Method表示某个方法的类型，即在Runtime中：\n\ntypedef struct objc_method *Method;\n\n 我们可以在objct_class定义中看到methodLists，其中的元素就是Method，下面是Runtime中objc_method结构体的具体定义：" boldString:@"5.Method" showType:TextType];
        
        ShowMessageModel * model20 = [self getModelWith:@"struct objc_method {\n\n   SEL Nonnull method_name    OBJC2UNAVAILABLE;\n   char * Nullable method_types    OBJC2UNAVAILABLE;\n   IMP Nonnull method_imp    OBJC2UNAVAILABLE;\n}\n 理解objc_method定义中的参数：\nmethod_name:方法名类型SEL\nmethod_types: 一个char指针，指向存储方法的参数类型和返回值类型\nmethod_imp：本质上是一个指针，指向方法的实现\n这里其实就是SEL(method_name)与IMP(method_name)形成了一个映射，通过SEL，我们可以很方便的找到方法实现IMP。" boldString:@"struct objc_method {\n\n   SEL Nonnull method_name    OBJC2UNAVAILABLE;\n   char * Nullable method_types    OBJC2UNAVAILABLE;\n   IMP Nonnull method_imp    OBJC2UNAVAILABLE;\n}\n " showType:TextType];
          ShowMessageModel * model21 = [self getModelWith:@"5.IMP\n\n  IMP是一个函数指针，它在Runtime中的定义如下：\n\n  typedef void (IMP)(void / id, SEL, ... */ ); \n\n IMP这个函数指针指向了方法实现的首地址，当OC发起消息后，最终执行的代码是由IMP指针决定的。利用这个特性，我们可以对代码进行优化：当需要大量重复调用方法的时候，我们可以绕开消息绑定而直接利用IMP指针调起方法，这样的执行将会更加高效，相关的代码示例如下：" boldString:@"5.IMP" showType:TextType];
        ShowMessageModel * model22 = [self getModelWith:@"void (*setter)(id, SEL, BOOL);\n  int i;\n  setter = (void (*)(id, SEL, BOOL))[target methodForSelector:@selector(setFilled:)];\n    for ( i = 0 ; i < 1000 ; i++ )\n      setter(targetList[i], @selector(setFilled:), YES);" boldString:@"void (*setter)(id, SEL, BOOL);\n  int i;\n  setter = (void (*)(id, SEL, BOOL))[target methodForSelector:@selector(setFilled:)];\n    for ( i = 0 ; i < 1000 ; i++ )\n      setter(targetList[i], @selector(setFilled:), YES);" showType:TextType];
        
        
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
        [modelArray addObject: model15];
        [modelArray addObject: model16];
        [modelArray addObject: model17];
        [modelArray addObject: model18];
        [modelArray addObject: model19];
        [modelArray addObject: model20];
        [modelArray addObject: model21];
        [modelArray addObject: model22];
        
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if (index == 4){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"Rutime消息发送" boldString:@"Rutime消息发送" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"OC调用方法被编译转化为如下的形式：\n\n id _Nullable objc_msgSend(id _Nullable self, SEL _Nonnull op, ...)\n\n 其实，除了常见的objc_msgSend，消息发送的方法还有objc_msgSend_stret,objc_msgSendSuper,objc_msgSendSuper_stret等，如果消息传递给超类就使用带有super的方法，如果返回值是结构体而不是简单值就使用带有stret的值。" boldString:@"id _Nullable objc_msgSend(id _Nullable self, SEL _Nonnull op, ...)" showType:TextType];
        ShowMessageModel * model3 = [self getModelWith:@"运行时阶段的消息发送的详细步骤如下：" boldString:@"运行时阶段的消息发送的详细步骤如下：" showType:TextType];
        ShowMessageModel * model4 = [self getModelWith:@"1.检测selector 是不是需要忽略的。比如 Mac OS X 开发，有了垃圾回收就不理会retain,release 这些函数了。\n2.检测target 是不是nil 对象。ObjC 的特性是允许对一个 nil对象执行任何一个方法不会 Crash，因为会被忽略掉。\n3.如果上面两个都过了，那就开始查找这个类的 IMP，先从 cache 里面找，若可以找得到就跳到对应的函数去执行。\n4.如果在cache里找不到就找一下方法列表methodLists。\n5.如果methodLists找不到，就到超类的方法列表里寻找，一直找，直到找到NSObject类为止。\n6.如果还找不到，Runtime就提供了如下三种方法来处理：动态方法解析、消息接受者重定向、消息重定向，这三种方法的调用关系如下图：" boldString:@"动态方法解析、消息接受者重定向、消息重定向" showType:TextType];
        
        ShowMessageModel * model5 = [ShowMessageModel new];
        model5.image = [UIImage imageNamed:@"runtime_message_png"];
        model5.showType = ImageType;
        
        ShowMessageModel * model6 = [self getModelWith:@"1.动态方法解析(Dynamic Method Resolution)\n\n所谓动态解析，我们可以理解为通过cache和方法列表没有找到方法时，Runtime为我们提供一次动态添加方法实现的机会，主要用到的方法如下：\n\n//OC方法：\n//类方法未找到时调起，可于此添加类方法实现\n\n   + (BOOL)resolveClassMethod:(SEL)sel\n\n//实例方法未找到时调起，可于此添加实例方法实现\n\n   + (BOOL)resolveInstanceMethod:(SEL)sel\n\n//Runtime方法：\n/**\n运行时方法：向指定类中添加特定方法实现的操作\n@param cls 被添加方法的类\n@param name selector方法名\n@param imp 指向实现方法的函数指针\n@param types imp函数实现的返回值与参数类型\n@return 添加方法是否成功\n*/\n\n    BOOL class_addMethod(Class _Nullable cls,\n   SEL _Nonnull name,\n   IMP _Nonnull imp,\n   const char * _Nullable types)" boldString:@"1.动态方法解析(Dynamic Method Resolution)" showType:TextType];
        
        ShowMessageModel * model7 = [self getModelWith:@"可返回观看代码事例" boldString:@"可返回观看代码事例" showType:TextType];
    
        ShowMessageModel * model8 = [self getModelWith:@"2.消息接收者重定向\n\n 我们注意到动态方法解析过程中的两个resolve方法都返回了布尔值，当它们返回YES时方法即可正常执行，但是若它们返回NO，消息发送机制就进入了消息转发(Forwarding)的阶段了，我们可以使用Runtime通过下面的方法替换消息接收者的为其他对象，从而保证程序的继续执行。\n\n\n//重定向类方法的消息接收者，返回一个类\n\n- (id)forwardingTargetForSelector:(SEL)aSelector\n\n//重定向实例方法的消息接受者，返回一个实例对象\n\n- (id)forwardingTargetForSelector:(SEL)aSelector\n\n\n" boldString:@"2.消息接收者重定向" showType:TextType];
        
         ShowMessageModel * model9 = [self getModelWith:@"可返回观看代码事例" boldString:@"可返回观看代码事例" showType:TextType];
        
        ShowMessageModel * model10 = [self getModelWith:@"3.消息重定向\n\n 当以上两种方法无法生效，那么这个对象会因为找不到相应的方法实现而无法响应消息，此时Runtime系统会通过forwardInvocation：消息通知该对象，给予此次消息发送最后一次寻找IMP的机会：\n\n\n- (void)forwardInvocation:(NSInvocation *)anInvocation；\n\n   其实每个对象都从NSObject类中继承了forwardInvocation：方法，但是NSObject中的这个方法只是简单的调用了doesNotRecongnizeSelector:方法，提示我们错误。所以我们可以重写这个方法：对不能处理的消息做一些默认处理，也可以将消息转发给其他对象来处理，而不抛出错误。\n\n    我们注意到anInvocation是forwardInvocation唯一参数，它封装了原始的消息和消息参数。正是因为它，我们还不得不重写另一个函数：methodSignatureForSelector。这是因为在for\n\n " boldString:@"3.消息重定向" showType:TextType];
        ShowMessageModel * model11 = [self getModelWith:@"可返回观看代码事例" boldString:@"可返回观看代码事例" showType:TextType];
        
        
        ShowMessageModel * model12 = [self getModelWith:@"总结：\n\n1.从以上的代码中就可以看出，forwardingTargetForSelector仅支持一个对象的返回，也就是说消息只能被转发给一个对象，而forwardInvocation可以将消息同时转发给任意多个对象，这就是两者的最大区别。\n\n2.虽然理论上可以重载doesNotRecognizeSelector函数实现保证不抛出异常（不调用super实现），但是苹果文档着重提出“一定不能让这个函数就这么结束掉，必须抛出异常”。(If you override this method, you must call super or raise an invalidArgumentException exception at the end of your implementation. In other words, this method must not return normally; it must always result in an exception being thrown.)\n\n3.forwardInvocation甚至能够修改消息的内容，用于实现更加强大的功能。" boldString:@"总结：" showType:TextType];
        
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
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if(index == 5){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"我们会发现Runtime消息转发的一个特点：一个对象可以调起它本身不具备的方法。这个过程与OC中的继承特性很相似，其实官方文档中图示也很好的说明了这个问题：" boldString:@"" showType:TextType];
        ShowMessageModel * model2 = [ShowMessageModel new];
        model2.image = [UIImage imageNamed:@"forwardInvocation_png"];
        model2.showType = ImageType;
        
        ShowMessageModel * model3 = [self getModelWith:@"图中的Warrior通过forwardInvocation：将negotiate消息转发给了Diplomat，这就好像是Warrior使用了超类Diplomat的方法一样。所以从这个思路，我们可以在实际开发需求中模拟多继承的操作。" boldString:@"" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if(index == 6){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        
        ShowMessageModel * model2 = [ShowMessageModel new];
        model2.image = [UIImage imageNamed:@"runtime_totalUse_png"];
        model2.showType = ImageType;
;
        [modelArray addObject: model2];
        
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if(index == 7){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"实现动态方法交换(Method Swizzling )是Runtime中最具盛名的应用场景，其原理是：通过Runtime获取到方法实现的地址，进而动态交换两个方法的功能。使用到关键方法如下：" boldString:@"" showType:TextType];
    
        
        ShowMessageModel * model2 = [self getModelWith:@"//获取类方法的Mthod\nMethod _Nullable class_getClassMethod(Class _Nullable cls, SEL _Nonnull name)\n\n//获取实例对象方法的Mthod\nMethod _Nullable class_getInstanceMethod(Class _Nullable cls, SEL _Nonnull name)\n\n//交换两个方法的实现\nvoid method_exchangeImplementations(Method _Nonnull m1, Method _Nonnull m2)" boldString:@"//获取类方法的Mthod\nMethod _Nullable class_getClassMethod(Class _Nullable cls, SEL _Nonnull name)\n\n//获取实例对象方法的Mthod\nMethod _Nullable class_getInstanceMethod(Class _Nullable cls, SEL _Nonnull name)\n\n//交换两个方法的实现\nvoid method_exchangeImplementations(Method _Nonnull m1, Method _Nonnull m2)" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }
    else if(index == 8){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"2.拦截并替换系统方法" boldString:@"2.拦截并替换系统方法" showType:TextType];
        
        
        ShowMessageModel * model2 = [self getModelWith:@"Runtime动态方法交换更多的是应用于系统类库和第三方框架的方法替换。在不可见源码的情况下，我们可以借助Rutime交换方法实现，为原有方法添加额外功能，这在实际开发中具有十分重要的意义。\n\n  步骤1：在添加分类中 添加替代执行的方法 \n\n+(UIImage *)YLImageNamed:(NSString *)name {\n    NSLog(@\"拦截系统的imageNamed方法\");\n    return [UIImage YLImageNamed: name];\n}" boldString:@"+(UIImage *)YLImageNamed:(NSString *)name {\n    NSLog(@\"拦截系统的imageNamed方法\");\n    return [UIImage YLImageNamed: name];\n}" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"步骤2：在UIImage的分类中拦截系统方法，将其替换为我们自定义的方法\n\n +(void)load {\n//load方法不需要手动调用，iOS会在应用程序启动的时候自动调起load方法，而且执行时间较早，所以在此方法中执行交换操作比较合适。\n// 获取两个类的类方法\n    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));\n    Method m2 = class_getClassMethod([UIImage class], @selector(YLImageNamed:));\n// 开始交换方法实现\n     method_exchangeImplementations(m1, m2);\n}" boldString:@"+(void)load {\n//load方法不需要手动调用，iOS会在应用程序启动的时候自动调起load方法，而且执行时间较早，所以在此方法中执行交换操作比较合适。\n// 获取两个类的类方法\n    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));\n    Method m2 = class_getClassMethod([UIImage class], @selector(YLImageNamed:));\n// 开始交换方法实现\n     method_exchangeImplementations(m1, m2);\n}" showType:TextType];
        
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if (index == 9){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"二、实现分类添加新属性\n\nOC的类目并不支持直接添加属性，如果我们直接在分类的声明中写入Property属性，那么只能为其生成set与get方法声明，却不能生成成员变量，直接调用这些属性还会造成崩溃" boldString:@"二、实现分类添加新属性" showType:TextType];
        
        
        ShowMessageModel * model2 = [self getModelWith:@"所以为了实现给分类添加属性，我们还需借助Runtime的关联对象(Associated Objects)特性，它能够帮助我们在运行阶段将任意的属性关联到一个对象上，下面是相关的三个方法:" boldString:@"关联对象(Associated Objects)" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"/**\n1.给对象设置关联属性\n@param object 需要设置关联属性的对象，即给哪个对象关联属性\n@param key 关联属性对应的key，可通过key获取这个属性，\n@param value 给关联属性设置的值\n@param policy 关联属性的存储策略(对应Property属性中的assign,copy，retain等)\nOBJC_ASSOCIATION_ASSIGN             @property(assign)。\nOBJC_ASSOCIATION_RETAIN_NONATOMIC   @property(strong, nonatomic)。\nOBJC_ASSOCIATION_COPY_NONATOMIC     @property(copy, nonatomic)。\nOBJC_ASSOCIATION_RETAIN             @property(strong,atomic)。\nOBJC_ASSOCIATION_COPY               @property(copy, atomic)。\n*/\nvoid objc_setAssociatedObject(id _Nonnull object,\nconst void * _Nonnull key,\nid _Nullable value,\nobjc_AssociationPolicy policy)\n/**\n2.通过key获取关联的属性\n@param object 从哪个对象中获取关联属性\n@param key 关联属性对应的key\n@return 返回关联属性的值\n*/\nid _Nullable objc_getAssociatedObject(id _Nonnull object,\nconst void * _Nonnull key)\n/**\n3.移除对象所关联的属性\n@param object 移除某个对象的所有关联属性\n*/\nvoid objc_removeAssociatedObjects(id _Nonnull object)\n\n" boldString:@"/**\n1.给对象设置关联属性\n@param object 需要设置关联属性的对象，即给哪个对象关联属性\n@param key 关联属性对应的key，可通过key获取这个属性，\n@param value 给关联属性设置的值\n@param policy 关联属性的存储策略(对应Property属性中的assign,copy，retain等)\nOBJC_ASSOCIATION_ASSIGN             @property(assign)。\nOBJC_ASSOCIATION_RETAIN_NONATOMIC   @property(strong, nonatomic)。\nOBJC_ASSOCIATION_COPY_NONATOMIC     @property(copy, nonatomic)。\nOBJC_ASSOCIATION_RETAIN             @property(strong,atomic)。\nOBJC_ASSOCIATION_COPY               @property(copy, atomic)。\n*/\nvoid objc_setAssociatedObject(id _Nonnull object,\nconst void * _Nonnull key,\nid _Nullable value,\nobjc_AssociationPolicy policy)\n/**\n2.通过key获取关联的属性\n@param object 从哪个对象中获取关联属性\n@param key 关联属性对应的key\n@return 返回关联属性的值\n*/\nid _Nullable objc_getAssociatedObject(id _Nonnull object,\nconst void * _Nonnull key)\n/**\n3.移除对象所关联的属性\n@param object 移除某个对象的所有关联属性\n*/\nvoid objc_removeAssociatedObjects(id _Nonnull object)" showType:TextType];
        ShowMessageModel * model4 = [self getModelWith:@"注意：key与关联属性一一对应，我们必须确保其全局唯一性，常用我们使用@selector(methodName)作为key。" boldString:@"" showType:TextType];
        
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
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

