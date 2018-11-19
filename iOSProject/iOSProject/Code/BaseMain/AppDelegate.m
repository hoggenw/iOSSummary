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
#import "GuidanceViewController.h"


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
    
    AdvertisementViewController *tb = [AdvertisementViewController new];
    //先判断是否是首次登陆
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {[AdvertisementViewController new];
        GuidanceViewController *guidanceViewController = [GuidanceViewController new];
        self.window.rootViewController = guidanceViewController;
        
    }else if ([AccountManager sharedInstance].isLogin) {
        //有广告数据才进入广告页面
        NSArray<NSString *> * urlString = [[NSUserDefaults standardUserDefaults] objectForKey: AdvertisementURLs];
        if (urlString != nil && urlString.count > 0) {
            tb.imageUrls = [urlString copy];
            [self.window setRootViewController:tb];
        }else {
            
            OwnersTabBarViewController * ownerTabVC = [OwnersTabBarViewController new];
            self.window.rootViewController = ownerTabVC;
        }
        
        
    }else{
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VoteLoginViewController new]];
    }
    
    //注冊消息推送
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    // 2.注册远程推送 或者 用application代理的方式注册
    [application registerForRemoteNotifications];
    return YES;
}

// iOS8+需要使用这个方法
//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
//    // 检查当前用户是否允许通知,如果允许就调用 registerForRemoteNotifications
//    if (notificationSettings.types != UIUserNotificationTypeNone) {
//        [application registerForRemoteNotifications];
//    }
//}

#pragma mark - deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * string = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                          stringByReplacingOccurrencesOfString: @">" withString: @""]
                         stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"%@", string);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取deviceToken" message: string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:okAction];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"注册远程通知失败: %@", error);
}



#pragma mark - Universal link 由于微信社交app屏蔽了此功能，故而基本没有啥用
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *restorableObjects))restorationHandler{
    //NSURL *webpageURL = userActivity.webpageURL;
    //NSLog(@"test webpageURL = %@",webpageURL);
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        
        NSURL *webpageURL = userActivity.webpageURL;
        NSString * valueString = [webpageURL.absoluteString componentsSeparatedByString: @"?params="].firstObject;
        NSString * needString = [valueString componentsSeparatedByString:@"85zn.ulml.mob.com/"].lastObject;
        //NSLog(@"needString: %@",needString);
        NSArray * infoArray = [needString componentsSeparatedByString:@"&"];
        
        NSString *host = webpageURL.host;
        // NSLog(@"test host = %@， infoArray.count ： %@",host, @(infoArray.count ));
        if ([host isEqualToString:@"85zn.ulml.mob.com"] && (infoArray.count == 2)) {
            NSString * goodsId = infoArray.firstObject;
            NSString * telphoneNUmber = infoArray.lastObject;
            //NSLog(@"网址首页");
        }
        
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

