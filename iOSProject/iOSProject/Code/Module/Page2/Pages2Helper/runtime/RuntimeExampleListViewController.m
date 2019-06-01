//
//  RuntimeExampleListViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/13.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "RuntimeExampleListViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "RuntimeTestTemp.h"
#import "SecondTestTemp.h"
#import "ThirdTestTemp.h"
#import "TestRuntime.h"
#import <objc/runtime.h>
#import "RuntimeTestViewController.h"
#import "Man.h"
#import "Algorithm.h"


@class Cat;

@interface RuntimeExampleListViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) TestRuntime * modelRuntime;

@end

@implementation RuntimeExampleListViewController


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
    model.title = [NSString stringWithFormat:@"Runtime"];
    model.desc = [NSString stringWithFormat:@"动态添加方法实现"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@"Runtime"];
    model2.desc = [NSString stringWithFormat:@"消息接收者重定向"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@"Runtime"];
    model3.desc = [NSString stringWithFormat:@"消息重定向"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    [self.tableView.dataArray addObject: model3];
    
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@"Runtime"];
    model4.desc = [NSString stringWithFormat:@"动态方法"];
    model4.leadImageName = @"tabbar-icon-selected-1";
    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model4];
    [self.tableView.dataArray addObject: model4];
    
    
    DefualtCellModel *model5 = [DefualtCellModel new];
    model5.title = [NSString stringWithFormat:@"Runtime"];
    model5.desc = [NSString stringWithFormat:@"拦截并替换系统方法"];
    model5.leadImageName = @"tabbar-icon-selected-1";
    model5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model5];
    [self.tableView.dataArray addObject: model5];
    
    DefualtCellModel *model6 = [DefualtCellModel new];
    model6.title = [NSString stringWithFormat:@""];
    model6.desc = [NSString stringWithFormat:@"添加新属性、block、私有变量赋值"];
    model6.leadImageName = @"tabbar-icon-selected-1";
    model6.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model6];
    [self.tableView.dataArray addObject: model6];
    
    
    DefualtCellModel *model7 = [DefualtCellModel new];
    model7.title = [NSString stringWithFormat:@""];
    model7.desc = [NSString stringWithFormat:@"获取属性列表"];
    model7.leadImageName = @"tabbar-icon-selected-1";
    model7.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model7];
    [self.tableView.dataArray addObject: model7];
    
    DefualtCellModel *model8 = [DefualtCellModel new];
    model8.title = [NSString stringWithFormat:@""];
    model8.desc = [NSString stringWithFormat:@"获取所有成员变量"];
    model8.leadImageName = @"tabbar-icon-selected-1";
    model8.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model8];
    [self.tableView.dataArray addObject: model8];
    
    
    DefualtCellModel *model9 = [DefualtCellModel new];
    model9.title = [NSString stringWithFormat:@""];
    model9.desc = [NSString stringWithFormat:@"获取所有方法"];
    model9.leadImageName = @"tabbar-icon-selected-1";
    model9.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model9];
    [self.tableView.dataArray addObject: model9];
    
    //获取当前遵循的所有协议
    DefualtCellModel *model10 = [DefualtCellModel new];
    model10.title = [NSString stringWithFormat:@""];
    model10.desc = [NSString stringWithFormat:@"获取当前遵循的所有协议"];
    model10.leadImageName = @"tabbar-icon-selected-1";
    model10.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model10];
    [self.tableView.dataArray addObject: model10];
    
    
    DefualtCellModel *model11 = [DefualtCellModel new];
    model11.title = [NSString stringWithFormat:@""];
    model11.desc = [NSString stringWithFormat:@"利用runtime 实现自己的kvo"];
    model11.leadImageName = @"tabbar-icon-selected-1";
    model11.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model11];
    [self.tableView.dataArray addObject: model11];
    
    
    DefualtCellModel *model12 = [DefualtCellModel new];
    model12.title = [NSString stringWithFormat:@""];
    model12.desc = [NSString stringWithFormat:@"字典转模型"];
    model12.leadImageName = @"tabbar-icon-selected-1";
    model12.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model12];
    [self.tableView.dataArray addObject: model12];
    
    
    DefualtCellModel *model13 = [DefualtCellModel new];
    model13.title = [NSString stringWithFormat:@""];
    model13.desc = [NSString stringWithFormat:@"基础算法1"];
    model13.leadImageName = @"tabbar-icon-selected-1";
    model13.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model13];
    [self.tableView.dataArray addObject: model13];
    
    
    DefualtCellModel *model14 = [DefualtCellModel new];
    model14.title = [NSString stringWithFormat:@""];
    model14.desc = [NSString stringWithFormat:@"基础算法2"];
    model14.leadImageName = @"tabbar-icon-selected-1";
    model14.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model14];
    [self.tableView.dataArray addObject: model14];
    
    
    DefualtCellModel *model15 = [DefualtCellModel new];
    model15.title = [NSString stringWithFormat:@""];
    model15.desc = [NSString stringWithFormat:@"基础算法3"];
    model15.leadImageName = @"tabbar-icon-selected-1";
    model15.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model15];
    [self.tableView.dataArray addObject: model15];
    
    
    DefualtCellModel *model16 = [DefualtCellModel new];
    model16.title = [NSString stringWithFormat:@""];
    model16.desc = [NSString stringWithFormat:@"基础算法4"];
    model16.leadImageName = @"tabbar-icon-selected-1";
    model16.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model16];
    [self.tableView.dataArray addObject: model16];
    
    
    DefualtCellModel *model17 = [DefualtCellModel new];
    model17.title = [NSString stringWithFormat:@""];
    model17.desc = [NSString stringWithFormat:@"基础算法5"];
    model17.leadImageName = @"tabbar-icon-selected-1";
    model17.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model17];
    [self.tableView.dataArray addObject: model17];
    
    
    DefualtCellModel *model18 = [DefualtCellModel new];
    model18.title = [NSString stringWithFormat:@""];
    model18.desc = [NSString stringWithFormat:@"基础算法6"];
    model18.leadImageName = @"tabbar-icon-selected-1";
    model18.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model18];
    [self.tableView.dataArray addObject: model18];
    
    
    DefualtCellModel *model19 = [DefualtCellModel new];
    model19.title = [NSString stringWithFormat:@""];
    model19.desc = [NSString stringWithFormat:@"基础算法7"];
    model19.leadImageName = @"tabbar-icon-selected-1";
    model19.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model19];
    [self.tableView.dataArray addObject: model19];
    



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

-(void)didselectedCell:(NSInteger)index {
    
    NSLog(@"%@",@(index));
    if (index == 0) {
        RuntimeTestTemp *temp = [[RuntimeTestTemp alloc] init];
        [RuntimeTestTemp haveMeal:@"Apple"]; //打印：+[Person zs_haveMeal:]
        [temp singSong:@"纸短情长"];   //打印：-[Person zs_singSong:]
        
      //const char *types含义表_png
      //  UIImage * image = [UIImage imageNamed:@"const char *types含义表_png"];
        
    }else if (index == 1){
        SecondTestTemp * temp = [SecondTestTemp new];
        [temp testForwardingTarget];
        
    }else if (index == 2){
        ThirdTestTemp * temp = [ThirdTestTemp new];
        [temp testForwardInvocation];
        
        
        
    }else if (index == 3){
         [self runtimeTest];
        
    }else if (index == 4){
        //测试系统拦截
        [UIImage imageNamed: @"dksj"];
        
    }else if(index == 5){
        RuntimeTestViewController *vcTest = [[RuntimeTestViewController alloc] init];
        [self.navigationController pushViewController:vcTest animated: true];
        
    }else if(index == 6){
       //获取属性列表
        unsigned int count;
        objc_property_t *propertyList = class_copyPropertyList([TestRuntime class], &count);
        for (unsigned int i = 0; i<count; i++) {
            const char *propertyName = property_getName(propertyList[i]);
            NSLog(@"PropertyName(%d): %@",i,[NSString stringWithUTF8String:propertyName]);
             [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"PropertyName(%d): %@",i,[NSString stringWithUTF8String:propertyName]]];
        }
        free(propertyList);
        
    }else if(index == 7){
        NSLog(@"取出类中所有成员变量的名字和类型，结果为：\n");
        unsigned int oucnt = 0;
        Ivar *lists = class_copyIvarList([TestRuntime class], &oucnt);
        for (unsigned int i = 0 ; i< oucnt; i ++) {
            Ivar ivar = lists[i];
            const char *name = ivar_getName(ivar);
            const char *type = ivar_getTypeEncoding(ivar);
            NSLog(@"成员变量名：%s 成员变量类型：%s",name,type);
            [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"成员变量名：%s 成员变量类型：%s",name,type]];
        }
        free(lists);
    }
    else if(index == 8){
        //获取所有方法
        unsigned int count = 0;
        Method *methodList = class_copyMethodList([TestRuntime class], &count);
        for (unsigned int i = 0; i<count; i++) {
            Method method = methodList[i];
            SEL mthodName = method_getName(method);
            NSLog(@"MethodName(%d): %@",i,NSStringFromSelector(mthodName));
             [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"MethodName(%d): %@",i,NSStringFromSelector(mthodName)]];
        }
        free(methodList);
        
    }else if (index == 9){
        //获取当前遵循的所有协议
        unsigned int count = 0;
        __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
        for (int i=0; i<count; i++) {
            Protocol *protocal = protocolList[i];
            const char *protocolName = protocol_getName(protocal);
            NSLog(@"protocol(%d): %@",i, [NSString stringWithUTF8String:protocolName]);
             [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"protocol(%d): %@",i, [NSString stringWithUTF8String:protocolName]]];
        }
        free(protocolList);
    }else if (index == 10){
        self.modelRuntime = [[TestRuntime alloc] init];
        [self.modelRuntime YLAddObserver:self forKey:NSStringFromSelector(@selector(string))
                          withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                              NSLog(@"%@.%@  oldVlue is %@ newvalue is  now: %@", observedObject, observedKey, oldValue,newValue);
                              [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"%@.%@  oldVlue is %@ newvalue is  now: %@", observedObject,observedKey, oldValue,newValue]];
                          }];
        NSArray * array = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
        for (int  i = 0 ; i < array.count; i++) {
            self.modelRuntime.string = array[i];
            
        }
        
        NSLog(@" class name  :   %@",[self.modelRuntime class]);
        
    }else if(index == 11){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"model.json" ofType:nil];
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
        //NSLog(@"json : %@",json);
        Man * model = [Man objectWithDict:json];
        //[model setDict: [Man specialArrayJson]];
        //        [model setDict:];
        NSLog(@"测试结果:%@== ==%@==%ld==%f==%@==%@",model.name,model.money,model.age,model.height,model.books.firstObject,model.cat);
        [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"测试结果:%@== ==%@==%ld==%f==%@===%@",model.name,model.money,model.age,model.height,model.books.firstObject,model.cat]];
    }
    
    else if(index == 12){
        Algorithm * temp = [Algorithm new];
        int arrayCount = [self randomNumber: 100] + 1;
        NSMutableArray * numberArray = [NSMutableArray array];
        NSLog(@"arrayCount: %@",@(arrayCount));
        for(int i = 0 ; i < arrayCount ;i++ ){
            numberArray[i] = [NSNumber numberWithInt: [self randomNumber: 10000]] ;
        }
        
       BOOL result = [temp testArray:[numberArray copy] total: [self randomNumber: 10000]];
        NSLog(@"result is %@",@(result));
        
    }
    else if(index == 13){
        Algorithm * temp = [Algorithm new];
        NSLog(@"%@",[temp testString:@"world hello"]) ;
    }
    else if(index == 14){
        Algorithm * temp = [Algorithm new];
        int16_t result =  [temp testInt:4321];
        NSLog(@"int16_t : %@",@(result)) ;
    }else if(index == 15){
        Algorithm * temp = [Algorithm new];
        int arrayCount = [self randomNumber: 10] + 1;
        NSMutableArray * numberArray = [NSMutableArray array];
        NSLog(@"arrayCount: %@",@(arrayCount));
        for(int i = 0 ; i < arrayCount ;i++ ){
            numberArray[i] = [NSNumber numberWithInt: [self randomNumber: 100]] ;
            NSLog(@"i = %@ : value=%@",@(i),numberArray[i]);
        }
        NSMutableArray * resultArray = [temp bubbleSortTest:numberArray];
        for(int i = 0 ; i < resultArray.count ;i++ ){
       
            NSLog(@"resultArray------ i = %@ : value=%@",@(i),numberArray[i]);
        }
        
    }else if(index == 16){

        Algorithm * temp = [Algorithm new];
        int arrayCount = [self randomNumber: 10] + 1;
        NSMutableArray * numberArray = [NSMutableArray array];
        NSLog(@"arrayCount: %@",@(arrayCount));
        for(int i = 0 ; i < arrayCount ;i++ ){
            numberArray[i] = [NSNumber numberWithInt: [self randomNumber: 100]] ;
            NSLog(@"i = %@ : value=%@",@(i),numberArray[i]);
        }
        NSMutableArray * resultArray = [temp selectSortTest:numberArray];
        for(int i = 0 ; i < resultArray.count ;i++ ){
            
            NSLog(@"resultArray------ i = %@ : value=%@",@(i),numberArray[i]);
        }
        
    }else if(index == 17){
        
        Algorithm * temp = [Algorithm new];
        int arrayCount = [self randomNumber: 100] + 1;
        NSMutableArray * numberArray = [NSMutableArray array];
  
        for(int i = 0 ; i < arrayCount ;i++ ){
            numberArray[i] = [NSNumber numberWithInt: [self randomNumber: 1000]] ;
        }
        NSMutableArray * resultArray = [temp selectSortTest:numberArray];
        for(int i = 0 ; i < resultArray.count ;i++ ){
            
            NSLog(@"resultArray------ i = %@ : value=%@",@(i),numberArray[i]);
        }
        NSNumber * tempNumber = resultArray[[self randomNumber: (int)resultArray.count]];
        int index = [temp findIndex:resultArray value:tempNumber];
        NSLog(@"resultArray------ index = %@ : value=%@",@(index),tempNumber);
        
        temp.otherCount = 0;
        
        int index2 = [temp findIndex: resultArray value: tempNumber max: (int)resultArray.count-1 min:0];
         NSLog(@"resultArray------ index2 = %@ : value=%@ count times : %@",@(index2),tempNumber,@(temp.otherCount));
        
        
        
        
    }else if(index == 18){
        
        Algorithm * temp = [Algorithm new];
        [temp primeTest: 100];
        
        
        
    }
    
    
}

-(void)buttonaction:(UIButton *)sender {
    
}
- (void)runtimeTest {
    TestRuntime * model = [TestRuntime shareRuntimer];
    Method class1 = class_getClassMethod([TestRuntime class], @selector(classMethod1));
    Method class2 = class_getClassMethod([TestRuntime class], @selector(classMethod2));
    Method instanceMethod1 = class_getInstanceMethod([TestRuntime class], @selector(method1));
    Method instanceMethod2 = class_getInstanceMethod([TestRuntime class], @selector(method2));
    //两个类方法的交换
    method_exchangeImplementations(class1, class2);
    NSLog(@"类方法交换后，先执行1方法，在执行2方法，结果为：\n");
    [TestRuntime classMethod1];
    [TestRuntime classMethod2];
    NSLog(@"实例方法交换后，先执行1方法，在执行2方法，结果为：\n");
    method_exchangeImplementations(instanceMethod1, instanceMethod2);
    [model method1];
    [model method2];
    
    NSLog(@"实例方法1和类方法1交换后，先执行实例方法，在执行类方法，结果为：\n");
    method_exchangeImplementations(class1, instanceMethod1);
    [TestRuntime classMethod1];
    [model method1];
    
 
 
    
    
}

- (int )randomNumber:(int)number {
    int randomNumber = arc4random() % number;
    return randomNumber;
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
