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
    
    
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@""];
    model2.desc = [NSString stringWithFormat:@"内存泄漏的一些想法"];
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
        ShowMessageModel * model = [self getModelWith:@"  总的来说，我认为内存泄漏的原因是由于内存在ARC环境下没有被系统自动释放（如循环引用）" boldString:@"  总的来说，我认为内存泄漏的原因是由于内存在ARC环境下没有被系统自动释放（如循环引用）" showType:TextType];
        
        ShowMessageModel * model2 = [self getModelWith:@"记录如何调试内存泄漏的http://blog.csdn.net/Kevintang158/article/details/79027274" boldString:@"http://blog.csdn.net/Kevintang158/article/details/79027274" showType:TextType];
        ShowMessageModel * model3 = [self getModelWith:@"内存之定时器\n\n我们都知道定时器使用完毕时需要将其停止并滞空，但**置空定时器**方法到底何时调用呢？在当前类的dealloc方法中吗？并不是，若将置空定时器方法调用在dealloc方法中会产生如下问题，**当前类销毁执行dealloc的前提是定时器需要停止并滞空**，**而定时器停止并滞空的时机在当前类调用dealloc方法时**，这样就造成了互相等待的场景，从而内存一直无法释放。因此需要注意**置空定时器**的调用时机从而避免内存无法释放，可以将**置空定时器**方法外漏，在外部调用即可。" boldString:@"内存之定时器" showType:TextType];
        
        ShowMessageModel * model4 = [self getModelWith:@"内存之block\n\nBlock的内存泄漏主要是由于循环引用；防止内存泄漏就是要防止对象之间引用的闭环出现； 一般采用的方法是让其中一个对象持有另一个对象的弱引用，例如：" boldString:@"内存之block" showType:TextType];
        
        ShowMessageModel * model5 = [self getModelWith:@" __weak typeof(self) weakself = self; " boldString:@" __weak typeof(self) weakself = self; " showType:TextType];
        ShowMessageModel * model6 = [self getModelWith:@"内存泄漏之delegate\n\n @property (nonatomic, weak) id<****delegate> delegate;\n\n比较值得注意的是swift中的协议要继承与class的，这时候可以用weak来修饰" boldString:@"内存泄漏之delegate\n\n @property (nonatomic, weak) id<****delegate> delegate;" showType:TextType];
        
        ShowMessageModel * model7 = [self getModelWith:@"特别之非OC对象\n\n   CGImageRef类型变量非OC对象，其需要手动执行释放操作\n\nCGImageRelease(ref)，否则会造成大量的内存泄漏导致程序崩溃。其他的对于CoreFoundation框架下的某些对象或变量需要手动释放、C语言代码中的malloc等需要对应free等都需要注意。" boldString:@"特别之非OC对象\n\n   CGImageRef类型变量非OC对象，其需要手动执行释放操作\n\n" showType:TextType];
        
        
        ShowMessageModel * model8 = [self getModelWith:@"地图之内存泄漏\n\n若项目中使用地图相关类，一定要检测内存情况，因为地图是比较耗费App内存的，因此在根据文档实现某地图相关功能的同时，我们需要注意内存的正确释放，大体需要注意的有需在使用完毕时将地图、代理等滞空为nil，注意地图中标注（大头针）的复用，并且在使用完毕时清空标注数组等。" boldString:@"地图之内存泄漏" showType:TextType];
        
        ShowMessageModel * model9 = [self getModelWith:@"循环数量巨大时内存管理\n\n  for (int i = 0; i < 100000; i++) {\n\n    @autoreleasepool {\n   NSString *string = @\"Abc\";\n   string = [string lowercaseString];\n   string = [string stringByAppendingString:@\"xyz\"];\n    NSLog(@\"%@\", string);\n}\n}\n\n在循环中创建自己的autoReleasePool，及时释放占用内存大的临时变量，减少内存占用峰值。\n\n" boldString:@"循环数量巨大时内存管理\n\n  for (int i = 0; i < 100000; i++) {\n\n    @autoreleasepool {\n   NSString *string = @\"Abc\";\n   string = [string lowercaseString];\n   string = [string stringByAppendingString:@\"xyz\"];\n    NSLog(@\"%@\", string);\n}\n}\n" showType:TextType];
        
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        [modelArray addObject: model5];
        [modelArray addObject: model6];
        [modelArray addObject: model7];
        [modelArray addObject: model8];
        [modelArray addObject: model9];
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
