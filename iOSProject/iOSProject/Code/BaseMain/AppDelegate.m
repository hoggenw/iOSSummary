//
//  AppDelegate.m
//  FTXExperienceStore
//
//  Created by 王留根 on 2018/1/10.
//  Copyright © 2018年 hoggen. All rights reserved.
//

#import "AppDelegate.h"
#import "YLUITabBarViewController.h"
#import "VoteLoginViewController.h"
#import "OwnersTabBarViewController.h"
#import "AdvertisementViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置背景色  [WXFX HexStringToColor:@"ff3356"]
    [[UINavigationBar appearance] setBarTintColor: ThemeColor ];
    //设置导航栏标题颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置状态栏颜色 在Info.plist中设置UIViewControllerBasedStatusBarAppearance 为NO
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//改变状态栏的颜色为白色
    //设置返回字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    if ([AccountManager sharedInstance].isLogin) {
        //有广告数据才进入广告页面
        NSArray<NSString *> * urlString = [[NSUserDefaults standardUserDefaults] objectForKey: AdvertisementURLs];
        if (urlString != nil && urlString.count > 0) {
            AdvertisementViewController *tb = [AdvertisementViewController new];
            tb.imageUrls = [urlString copy];
            [self.window setRootViewController:tb];
        }else {
            [AdvertisementViewController new];
            OwnersTabBarViewController * ownerTabVC = [OwnersTabBarViewController new];
            self.window.rootViewController = ownerTabVC;
        }
        
       
    }else{
       self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VoteLoginViewController new]];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
    }
    return _window;
}


@end
