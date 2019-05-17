//
//  OwnersTabBarViewController.m
//  Vote
//
//  Created by 王留根 on 2018/6/13.
//  Copyright © 2018年 OwnersVote. All rights reserved.
//

#import "OwnersTabBarViewController.h"
#import "YLNavigationController.h"
#import "Page1ViewController.h"
#import "Page2ViewController.h"

@interface OwnersTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation OwnersTabBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialUserInterface];
    [self initialDataSource];

    
    
}


- (void)dealloc
{
    // 通知移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    // 图片缓存清理
    
}

#pragma mark - extension function / private function


#pragma mark - extension UI布局

// 界面初始化
- (void)initialUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // bar's title seleted color
    //self.tabBar.tintColor = [[PSTheme sharedInstance] tintColor];
    // bar's background color(iOS7:tintColor -> barTintColor)
    //self.tabBar.barTintColor = [UIColor colorWithWhite:1 alpha:0.7];
    
    // 标签栏背景
    // 注：4，5，6，6+的适配问题
    //NSString *strImageName = nil;
    //self.tabBar.backgroundImage = [UIImage imageNamed:strImageName];
    
    // 代理
    self.delegate = self;
    
    // 添加子控制器
    NSArray *childVCNames  = @[@"Page1ViewController", @"Page2ViewController", @"UIViewController"];
    NSArray *titles = @[Localized(@"TabbarHome"), Localized(@"TabbarFeatures"), Localized(@"TabbarMe")];
    NSArray *iconNames = @[@"1", @"2", @"3"];
    for (int i=0; i<childVCNames.count; i++)
    {
        UIViewController *childVC = [[NSClassFromString(childVCNames[i]) alloc] init];
        [self addChildVC:childVC title:titles[i] iconName:iconNames[i]];
    }
    
}


// 将传入的控制器包装成导航控制器作为子控制器
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title iconName:(NSString *)iconName
{
    // 包装成导航控制器
    UINavigationController *nc = [[YLNavigationController alloc] initWithRootViewController:childVC];
    
    // 配置
    childVC.navigationItem.title = title;
    
    //UIImage * icon = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar-icon-%ld", [iconName integerValue]+5]];
    UIImage * icon = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar-icon-%@", @([iconName integerValue])]];
    UIImage * selectedIcon = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar-icon-selected-%ld", (long)[iconName integerValue]]];
    
    // 设置图片渲染模式，UIImageRenderingModeAlwaysOriginal：始终绘制图片原始状态，不使用TintColor
    icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedIcon = [selectedIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:icon selectedImage:selectedIcon];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor blackColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      ThemeColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    nc.tabBarItem = tabBarItem;
   
    
    // 添加
    [self addChildViewController:nc];
    
}


#pragma mark - extension lazy load / getter



#pragma mark - extension 数据处理

// 数据源初始化
- (void)initialDataSource
{
    // 版本判断  是否提示更新
    
    
}


#pragma mark - extension 事件响应


#pragma mark - delegate function


#pragma mark - delegate <UITabBarControllerDelegate>


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    BOOL selectFlag = YES;  // 允许选中标记
    
 
    
    return selectFlag;
}



-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"circlehit"]) {
        [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"tabBarController收到button点击事件参数为：%@",userInfo[@"name"]]];
    }
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}
@end
