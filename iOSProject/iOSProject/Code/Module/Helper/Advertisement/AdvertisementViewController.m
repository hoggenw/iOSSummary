//
//  AdvertisementViewController.m
//  ftxmall
//
//  Created by 王留根 on 2017/7/4.
//  Copyright © 2017年 wanthings. All rights reserved.
//

#import "AdvertisementViewController.h"
#import "BannerScrollView.h"
#import "OwnersTabBarViewController.h"


@interface AdvertisementViewController()

@property(nonatomic,strong) BannerScrollView*  bannerScroller;
@property(nonatomic,strong) NSMutableArray<NSString *> * imageUrl;

@end

@implementation AdvertisementViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imageUrl = [NSMutableArray array];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self GetAdvertising];
        });
        //_imageView = [UIImageView new];
    }
    return self;
}

- (void)setImageUrls:(NSMutableArray<NSString *> *)imageUrls {
    _imageUrls = imageUrls;
     [self showAdvertisement];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
     __weak typeof(self) weakSelf = self;
        if (self.bannerScroller != nil) {
            [self.bannerScroller setTotalPageCount:^ NSInteger{
                return weakSelf.imageUrls.count;
            }];
        }
    
}

- (void)jumpToTabbar  {
    AppDelegate *AppDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (AppDele.isUpdate)
//    {
//        [YLHintView showMessageOnThisPage: @"需要更新版本，才能继续使用"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/fu-tian-xia/id1095129585"]];//更新
//    }
//    else
//    {
//
//    }
    
    OwnersTabBarViewController *vc = [OwnersTabBarViewController new];
    [AppDele.window setRootViewController:vc];
    
    
}

- (void)showAdvertisement {
    __weak typeof(self) weakSelf = self;
    NSMutableArray<NSString *> * urls  = [_imageUrls mutableCopy];
//    _imageView.image = [UIImage imageNamed:@"Image_ad_log"];
//    _imageView.frame = CGRectMake(0, 0, 200, 170);
//    _imageView.center = CGPointMake(qqWidth/2, qqHeight - 85);
//    [self.view addSubview: _imageView];
    NSTimeInterval interval = 2;
    if (urls.count == 1) {
        interval = 3;
    }
    self.bannerScroller = [[BannerScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight ) duration:interval urls:urls];
    [self.view addSubview: _bannerScroller];

    [self.bannerScroller setTapActionBlock:^(NSInteger index){
        NSLog(@"点击%@",@(index));
    }];
    
    [self.bannerScroller setEndActionBlock:^{
        [weakSelf jumpToTabbar];
    }];
    
    
}

//获取引导页
-(void)GetAdvertising
{
    //AppDelegate *AppDele = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    //NSString *url = [((AppDelegate *)[[UIApplication sharedApplication] delegate]).Url stringByAppendingString:@"/welcome/ad"];
    NSString *url = @"https://www.ftxmall.net/api/welcome/ad";
#if defined(DEBUG)||defined(_DEBUG)
   
#endif
    
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSString *errnos = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"errno"]];
    
         
         if([errnos isEqualToString:@"0"])//成功
         {
             NSArray * dictionaryArray = [NSMutableArray arrayWithArray:[[responseObject objectForKey:@"result"] objectForKey:@"ad"]];
             for (int i = 0; i < dictionaryArray.count; i++) {
                 NSDictionary * dic = dictionaryArray[i];
                 NSString * imageUrlString =  dic[@"img"];
                 //[WXFX judgeCacheRefreshWithUrlString:imageUrlString imageView:[UIImageView new]];
                 [self.imageUrl addObject: imageUrlString];
                 
             }

             [[NSUserDefaults standardUserDefaults] setObject:self.imageUrl forKey:AdvertisementURLs];
                       
         }
         
         
         
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败：%@",error); 
         
     }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
