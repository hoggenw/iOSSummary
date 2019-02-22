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
#import "YLIFlyHelper.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate (){
    BMKMapManager* _mapManager;
}

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
    
    
    //国际化设置
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        if ([language hasPrefix:@"zh-Hans"]) {//开头匹配
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
        }
    }
    
    
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
    
    
    // U-Share 平台设置 分享
    [YLUMengHelper UMSocialStart];
    //人脸识别
    [YLIFlyHelper makeConfiguration];
    
    //注冊消息推送
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    // 2.注册远程推送 或者 用application代理的方式注册
    [application registerForRemoteNotifications];

    //地图消息
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"NS6lYC0TtQdaKmuWseunZ5pqobicYbyY"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //远程通知调用，未启动app时候需要在此做相关调用
    // 取到url scheme跳转信息 未启动时走这一步
    NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    if (url.absoluteString.length > 0) {
        //NSString * urlString = url.absoluteString;
        //NSLog(@"=============%@",urlString);
        return  YES;
    }
    
   
    
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
    [YLHintView showAlertMessage:string title:@"获取deviceToken"];
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
           // NSString * goodsId = infoArray.firstObject;
           // NSString * telphoneNUmber = infoArray.lastObject;
            //NSLog(@"网址首页");
        }
        
    }
    
    return YES;
    
}

#pragma mark - 微信重写openURL


#pragma mark- 远程推送调用处理,或者app之间调用处理

//ios9以上用这个回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    /*
     sourceApplication: 跳转app
     urlString: 为其他app传参的要素
     */
    NSString * urlString = url.absoluteString;
    NSLog(@"=============%@",urlString);
    if ([urlString rangeOfString:@"&from=fufamily"].location != NSNotFound) {
        
    }
    
    
    NSString *str = [url absoluteString];
    if ([str hasPrefix:@"wx"])//微信回调
    {
//        [WXApi handleOpenURL:url delegate:self];
    }
    else if ([str hasPrefix:@"ftxmall"])
    {
        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
//         ];
        
    }
    
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }else{
        NSLog(@"");
    }
    return result;
}

// iOS 10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        UNNotificationRequest *request = notification.request; // 收到推送的请求
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        NSNumber *badge = content.badge;  // 推送消息的角标
        NSString *body = content.body;    // 推送消息体
        UNNotificationSound *sound = content.sound;  // 推送消息的声音
        NSString *subtitle = content.subtitle;  // 推送消息的副标题
        NSString *title = content.title;  // 推送消息的标题
        
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            NSLog(@"iOS10 前台收到远程通知");
            
        }
        else {
            // 判断为本地通知
            NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        }
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    }else{
        
    }
    
   
}
// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        UNNotificationRequest *request = response.notification.request; // 收到推送的请求
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        NSNumber *badge = content.badge;  // 推送消息的角标
        NSString *body = content.body;    // 推送消息体
        UNNotificationSound *sound = content.sound;  // 推送消息的声音
        NSString *subtitle = content.subtitle;  // 推送消息的副标题
        NSString *title = content.title;  // 推送消息的标题
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            NSLog(@"iOS10 收到远程通知");
            
        }
        else {
            // 判断为本地通知
            NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        }
        
        // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
        completionHandler();  // 系统要求执行这个方法
    }else{
        
    }
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
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


