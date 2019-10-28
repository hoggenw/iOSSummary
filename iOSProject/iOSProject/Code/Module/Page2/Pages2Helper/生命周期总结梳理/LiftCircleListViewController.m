//
//  LiftCircleListViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/20.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "LiftCircleListViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"
#import "ShowInfoViewController.h"
#import "ShowMessageModel.h"

@interface LiftCircleListViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;


@end

@implementation LiftCircleListViewController


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
    model.desc = [NSString stringWithFormat:@"程序的生命周期"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
  
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@""];
    model2.desc = [NSString stringWithFormat:@"AppDelegate中的回调方法和通知"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
   
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@""];
    model3.desc = [NSString stringWithFormat:@"程序周期相关操作"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    [self.tableView.dataArray addObject: model3];
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@""];
    model4.desc = [NSString stringWithFormat:@"UIViewController的生命周期"];
    model4.leadImageName = @"tabbar-icon-selected-1";
    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model4];
    [self.tableView.dataArray addObject: model4];
    
    
    DefualtCellModel *model5 = [DefualtCellModel new];
    model5.title = [NSString stringWithFormat:@""];
    model5.desc = [NSString stringWithFormat:@"引申知识load与initialize"];
    model5.leadImageName = @"tabbar-icon-selected-1";
    model5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model5];
    [self.tableView.dataArray addObject: model5];
    
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
        ShowMessageModel * model = [self getModelWith:@"程序的生命周期\n包含五个状态" boldString:@"程序的生命周期\n包含五个状态" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"Not Running：未运行。\nInactive：前台非活动状态。处于前台，但是不能接受事件处理。\nActive：前台活动状态。处于前台，能接受事件处理。\nBackground：后台状态。进入后台，如果又可执行代码，会执行代码，代码执行完毕，程序进行挂起。\nSuspended：挂起状态。进入后台，不能执行代码，如果内存不足，程序会被杀死。" boldString:@"" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 1){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"AppDelegate中的回调方法和通知 \n\n1.回调方法：application:didFinishLaunchingWithOptions:" boldString:@"AppDelegate中的回调方法和通知" showType:TextType];
        
        
        ShowMessageModel * model2 = [self getModelWith:@"  本地通知：UIApplicationDidFinishLaunchingNotification\n触发时机：程序启动并进行初始化的时候后。\n适宜操作：这个阶段应该进行根视图的创建。" boldString:@"  本地通知：UIApplicationDidFinishLaunchingNotification\n触发时机：程序启动并进行初始化的时候后。\n适宜操作：这个阶段应该进行根视图的创建。\n\n2.回调方法：applicationDidBecomeActive：" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@" 本地通知：UIApplicationDidBecomeActiveNotification\n触发时机：程序进入前台并处于活动状态时调用。\n适宜操作：这个阶段应该恢复UI状态（例如游戏状态）。\n\n3.回调方法：applicationWillResignActive:" boldString:@" 本地通知：UIApplicationDidBecomeActiveNotification\n触发时机：程序进入前台并处于活动状态时调用。\n适宜操作：这个阶段应该恢复UI状态（例如游戏状态）。" showType:TextType];
        
        ShowMessageModel * model4 = [self getModelWith:@"   本地通知：UIApplicationWillResignActiveNotification\n触发时机：从活动状态进入非活动状态。\n适宜操作：这个阶段应该保存UI状态（例如游戏状态）。\n\n4.回调方法：applicationDidEnterBackground:" boldString:@"   本地通知：UIApplicationWillResignActiveNotification\n触发时机：从活动状态进入非活动状态。\n适宜操作：这个阶段应该保存UI状态（例如游戏状态）。" showType:TextType];
        
        
        ShowMessageModel * model5 = [self getModelWith:@"本地通知：UIApplicationDidEnterBackgroundNotification\n触发时机：程序进入后台时调用。\n适宜操作：这个阶段应该保存用户数据，释放一些资源（例如释放数据库资源）。\n\n5.回调方法：applicationWillEnterForeground：" boldString:@"本地通知：UIApplicationDidEnterBackgroundNotification\n触发时机：程序进入后台时调用。\n适宜操作：这个阶段应该保存用户数据，释放一些资源（例如释放数据库资源）。" showType:TextType];
        
        ShowMessageModel * model6 = [self getModelWith:@"   本地通知：UIApplicationWillEnterForegroundNotification\n 触发时机：程序进入前台，但是还没有处于活动状态时调用。\n适宜操作：这个阶段应该恢复用户数据\n\n\n6.回调方法：applicationWillTerminate:" boldString:@"   本地通知：UIApplicationWillEnterForegroundNotification\n 触发时机：程序进入前台，但是还没有处于活动状态时调用。\n适宜操作：这个阶段应该恢复用户数据" showType:TextType];
        
        
        ShowMessageModel * model7 = [self getModelWith:@"本地通知：UIApplicationWillTerminateNotification\n触发时机：程序被杀死时调用。\n适宜操作：这个阶段应该进行释放一些资源和保存用户数据。" boldString:@"本地通知：UIApplicationWillTerminateNotification\n触发时机：程序被杀死时调用。\n适宜操作：这个阶段应该进行释放一些资源和保存用户数据。" showType:TextType];
        
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
         [modelArray addObject: model4];
         [modelArray addObject: model5];
         [modelArray addObject: model6];
         [modelArray addObject: model7];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if (index == 2){
        
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"程序周期相关操作" boldString:@"程序周期相关操作" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"1.程序启动\n点击应用图标时，会经历三个状态：\nNot running-->Inactive-->Active\n\n Not running --> Inactive\n调用 application:didFinishLaunchingWithOptions: 发送   UIApplicationDidFinishLaunchingNotification\nInactive-->Active\n调用 applicationDidBecomeActive： 发送：UIApplicationDidBecomeActiveNotification\n" boldString:@"\n点击应用图标时，会经历三个状态：\nNot running-->Inactive-->Active\n\n Not running --> Inactive\n调用 application:didFinishLaunchingWithOptions: 发送   UIApplicationDidFinishLaunchingNotification\nInactive-->Active\n调用 applicationDidBecomeActive： 发送：UIApplicationDidBecomeActiveNotification\n" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"根据info.plist中Application does not run in background  /   UIApplicationExitsOnSuspend控制似乎否可以在后台运行或挂起。\n如果可以在后台运行或者挂起会经历\nActive-->Inactive-->Background-->Suspended\n\nActive-->Inactive\n调用 applicationWillResignActive： 发送：UIApplicationWillResignActiveNotification\nBackground-->Suspended\n调用 applicationDidEnterBackground： 发送：UIApplicationDidEnterBackgroundNotification\n\n如果不可以后台运行或挂起会经历\nActive-->Inactive-->Background-->Suspended-->Not Running\n\nBackground-->Suspended\n调用 applicationDidEnterBackground： 发送：UIApplicationDidEnterBackgroundNotification\nSuspended-->Not Running\n调用 applicationWillTerminate： 发送：UIApplicationWillTerminateNotification\n" boldString:@"2.程序点击Home（双击home后台运行）\n根据info.plist中Application does not run in background  /   UIApplicationExitsOnSuspend控制似乎否可以在后台运行或挂起。\n如果可以在后台运行或者挂起会经历\nActive-->Inactive-->Background-->Suspended\n\nActive-->Inactive\n调用 applicationWillResignActive： 发送：UIApplicationWillResignActiveNotification\nBackground-->Suspended\n调用 applicationDidEnterBackground： 发送：UIApplicationDidEnterBackgroundNotification\n\n如果不可以后台运行或挂起会经历\nActive-->Inactive-->Background-->Suspended-->Not Running\n\nBackground-->Suspended\n调用 applicationDidEnterBackground： 发送：UIApplicationDidEnterBackgroundNotification\nSuspended-->Not Running\n调用 applicationWillTerminate： 发送：UIApplicationWillTerminateNotification\n" showType:TextType];
        ShowMessageModel * model4 = [self getModelWith:@"3.挂起后，重新运行\nSuspended-->Background-->Inactive-->Active\nBackground-->Inactive\n调用 applicationWillEnterForeground： 发送：UIApplicationWillEnterForegroundNotification\n\nInactive-->Active\n调用 applicationDidBecomeActive： 发送：UIApplicationDidBecomeActiveNotification\n" boldString:@"Suspended-->Background-->Inactive-->Active\nBackground-->Inactive\n调用 applicationWillEnterForeground： 发送：UIApplicationWillEnterForegroundNotification\n\nInactive-->Active\n调用 applicationDidBecomeActive： 发送：UIApplicationDidBecomeActiveNotification\n" showType:TextType];
        
        ShowMessageModel * model5 = [self getModelWith:@"4.内存不足，杀死程序\n Background-->Suspended-->Not running\n这种情况不会调用任何方法，也不会发送任何通知。" boldString:@" Background-->Suspended-->Not running\n这种情况不会调用任何方法，也不会发送任何通知。" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model4];
        [modelArray addObject: model5];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
        
    }else if (index == 3){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"UIViewController的生命周期\n\n下面是UIViewController生命的相关方法（注意顺序）" boldString:@"UIViewController的生命周期" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"//类的初始化方法，并不是每次创建对象都调用，只有这个类第一次创建对象才会调用，做一些类的准备工作，再次创建这个类的对象。initialize方法将不会被调用，对于这个类的子类，如果实现了initialize方法，在这个子类第一次创建对象是会调用自己的initialization方法，没有实现者由调用父类实现方法；可以用以实现相关全局变量 \n\n+ (void)initialize;" boldString:@"+ (void)initialize;" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"//对象初始化方法init方法和initCoder方法相似，只是被调用的环境不一样，如果用代码进行初始化，会调用init，从nib文件或者归档进行初始化，会调用initCoder。\n\n- (instancetype)init;\n//从归档初始化\n- (instancetype)initWithCoder:(NSCoder *)coder;" boldString:@"- (instancetype)init;\n//从归档初始化\n- (instancetype)initWithCoder:(NSCoder *)coder;" showType:TextType];
        
        ShowMessageModel * model4 = [self getModelWith:@"//加载视图:是开始加载视图的起始方法，除非手动调用，否则在viewcontroller的生命周期中没特殊情况只被调用一次；ViewController的view是使用了lazyInit方式创建，就是说你调用的view属性的getter：［self view］。在getter里会先判断view是否创建，如果没有创建，那么会调用loadView来创建view。loadView和viewDidLoad的一个区别就是：loadView时还没有view。而viewDidLoad时view以及创建好了。\n\n-(void)loadView;" boldString:@"-(void)loadView;" showType:TextType];
        
          ShowMessageModel * model5 = [self getModelWith:@"//将要加载视图：，类中成员对象和变量的初始化我们都会放在这个方法中，在类创建后，无论视图的展现或消失，这个方法也是只会在将要布局时调用一次。\n\n- (void)viewDidLoad;" boldString:@"- (void)viewDidLoad;" showType:TextType];
        
        ShowMessageModel * model6 = [self getModelWith:@"//将要展示\n -(void)viewWillAppear:(BOOL)animated;\n\n//将要布局子视图，在viewWillAppear后调用，将要对子视图进行布局。\n -(void)viewWillLayoutSubviews;\n//已经布局子视图\n-(void)viewDidLayoutSubviews;\n\n//已经展示\n-(void)viewDidAppear:(BOOL)animated;\n//将要消失\n-(void)viewWillDisappear:(BOOL)animated;\n//已经消失\n-(void)viewDidDisappear:(BOOL)animated;\n//内存警告\n- (void)didReceiveMemoryWarning;\n//被释放\n-(void)dealloc;\n" boldString:@"//将要展示\n -(void)viewWillAppear:(BOOL)animated;\n\n//将要布局子视图，在viewWillAppear后调用，将要对子视图进行布局。\n -(void)viewWillLayoutSubviews;\n//已经布局子视图\n-(void)viewDidLayoutSubviews;\n\n//已经展示\n-(void)viewDidAppear:(BOOL)animated;\n//将要消失\n-(void)viewWillDisappear:(BOOL)animated;\n//已经消失\n-(void)viewDidDisappear:(BOOL)animated;\n//内存警告\n- (void)didReceiveMemoryWarning;\n//被释放\n-(void)dealloc;" showType:TextType];
        
        ShowMessageModel * model7 = [self getModelWith:@"从nib文件加载的controller，只要不释放，在每次viewWillAppare时都会调用layoutSubviews方法，有时甚至会在viewDidAppare后在调用一次layoutSubviews，而重点是从代码加载的则只会在开始调用一次，之后都不会，所以注意，在layoutSubviews中写相关的布局代码十分危险。" boldString:@"" showType:TextType];
        
        ShowMessageModel * model8 = [self getModelWith:@"parentViewController属性\n\n@property(nullable,nonatomic,weak,readonly) UIViewController *parentViewController;\n例如：我的项目结构为 tabbarController > navigationContriller > contorller\n\n打印" boldString:@"parentViewController属性\n\n@property(nullable,nonatomic,weak,readonly) UIViewController *parentViewController;" showType:TextType];
        ShowMessageModel * model9 = [self getModelWith:@"NSLog(@\"self.parentViewController > %@ ===== %@\",[self.parentViewController.parentViewController class],self.parentViewController.parentViewController);\n\n输出\n" boldString:@"NSLog(@\"self.parentViewController > %@ ===== %@\",[self.parentViewController.parentViewController class],self.parentViewController.parentViewController);\n" showType:TextType];
        
         ShowMessageModel * model10 = [self getModelWith:@"self.parentViewController > YLUITabBarViewController ===== <YLUITabBarViewController: 0x10201ee00>\n\n无需调用window的rootcontroller来获取YLUITabBarViewController" boldString:@"self.parentViewController > YLUITabBarViewController ===== <YLUITabBarViewController: 0x10201ee00>\n\n" showType:TextType];
        
        ShowMessageModel * model11 = [self getModelWith:@"2.模态跳转中Controller的从属\n\n主要是两个参数，只要模态关系没有被释放，我们就可以利用这个两个参数进行对象获取，传值什么的根本不需要block或者delegate；" boldString:@"2.模态跳转中Controller的从属" showType:TextType];
        
        ShowMessageModel * model12 = [self getModelWith:@"//其所present的contller，比如，A和B两个controller，A跳转到B，那么A的presentedViewController就是B\n@property(nullable, nonatomic,readonly) UIViewController *presentedViewController  NS_AVAILABLE_IOS(5_0);\n//和上面的方法刚好相反，比如，A和B两个controller，A跳转到B，那么B的presentingViewController就是A\n@property(nullable, nonatomic,readonly) UIViewController *presentingViewController NS_AVAILABLE_IOS(5_0);\n\n传值可以简单使用" boldString:@"//其所present的contller，比如，A和B两个controller，A跳转到B，那么A的presentedViewController就是B\n@property(nullable, nonatomic,readonly) UIViewController *presentedViewController  NS_AVAILABLE_IOS(5_0);\n//和上面的方法刚好相反，比如，A和B两个controller，A跳转到B，那么B的presentingViewController就是A\n@property(nullable, nonatomic,readonly) UIViewController *presentingViewController NS_AVAILABLE_IOS(5_0);\n" showType:TextType];
        
        
        ShowMessageModel * model13 = [self getModelWith:@" self.presentingViewController.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];\n [self dismissViewControllerAnimated:YES completion:nil];" boldString:@" self.presentingViewController.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];\n [self dismissViewControllerAnimated:YES completion:nil];" showType:TextType];
        
        
        
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
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
    }else if (index == 4){
        ShowInfoViewController * vc = [ShowInfoViewController new];
        NSMutableArray *modelArray = [NSMutableArray array];
        ShowMessageModel * model = [self getModelWith:@"引申知识load与initialize\n\nload" boldString:@"引申知识load与initialize\n\nload" showType:TextType];
        ShowMessageModel * model2 = [self getModelWith:@"1.对于加入运行期系统的类及分类，必定会调用此方法，且仅调用一次。\n\n2.iOS会在应用程序启动的时候调用load方法，在main函数之前调用\n\n3.执行子类的load方法前，会先执行所有超类的load方法，顺序为父类->子类->分类\n\n4.在load方法中使用其他类是不安全的，因为会调用其他类的load方法，而如果关系复杂的话，就无法判断出各个类的载入顺序，类只有初始化完成后，类实例才能进行正常使用\n\n5.load 方法不遵从继承规则，如果类本身没有实现load方法，那么系统就不会调用，不管父类有没有实现（跟下文的initialize有明显区别）\n\n6.尽可能的精简load方法，因为整个应用程序在执行load方法时会阻塞，即，程序会阻塞直到所有类的load方法执行完毕，才会继续\n\n7.load 方法中最常用的就是方法交换method swizzling" boldString:@"" showType:TextType];
        
        ShowMessageModel * model3 = [self getModelWith:@"initialize" boldString:@"initialize" showType:TextType];
    
        
        ShowMessageModel * model5 = [self getModelWith:@"1.在首次使用该类之前由运行期系统（非人为）调用，且仅调用一次\n\n2.惰性调用，只有当程序使用相关类时，才会调用\n\n3.运行期系统会确保initialize方法是在线程安全的环境中执行，即，只有执行initialize的那个线程可以操作类或类实例。其他线程都要先阻塞，等待initialize执行完\n\n4.如果类未实现initialize方法，而其超类实现了，那么会运行超类的实现代码，而且会运行两次（load 第5点）\n    initialize 遵循继承规则\n    初始化子类的的时候会先初始化父类，然后会调用父类的initialize方法，而子类没有覆写initialize方法，因此会再次调用父类的实现方法\n\n initialize方法也需要尽量精简，一般只应该用来设置内部数据，比如，某个全局状态无法在编译期初始化，可以放在initialize里面。" boldString:@"" showType:TextType];
        
        ShowMessageModel * model6 = [self getModelWith:@"SO：" boldString:@"SO：" showType:TextType];
        
        ShowMessageModel * model7 = [self getModelWith:@"1.在加载阶段，如果类实现了load方法，系统就会调用它，load方法不参与覆写机制\n\n2.在首次使用某个类之前，系统会向其发送initialize消息，通常应该在里面判断当前要初始化的类，防止子类未覆写initialize的情况下调用两次\n\n3.load与initialize方法都应该实现得精简一些，有助于保持应用程序的响应能力，也能减少引入“依赖环”（interdependency cycle）的几率\n\n4.无法在编译期设定的全局常量，可以放在initialize方法里初始化" boldString:@"" showType:TextType];
        [modelArray addObject: model];
        [modelArray addObject: model2];
        [modelArray addObject: model3];
        [modelArray addObject: model5];
        [modelArray addObject: model6];
        [modelArray addObject: model7];
        vc.dataArray = modelArray;
        [self.navigationController pushViewController: vc animated: true];
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
