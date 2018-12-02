//
//  NetworkManager.m
//  FTXExperienceStore
//
//  Created by 王留根 on 2018/1/10.
//  Copyright © 2018年 hoggen. All rights reserved.
//

#import "NetworkManager.h"
#import "YLDeviceUtil.h"
#import "AFNetworking.h"
#import "AccountManager.h"
#import "UserModel.h"
#import "VoteLoginViewController.h"

#define NetworkTimeoutInterval 20.0



//https
NSString * const BaseUrl = @"https://community.coinsolid.com";
NSString * const WebBaseUrl = @"https://community.coinsolid.com/resum/download?resumUrl=";


#pragma mark - 接口设置部分
NSString * const RegisteredApi = @"/owners/register";
NSString * const LoginApi = @"/community/login";
NSString * const PhoneCodeApi = @"/phone/getcode";
NSString * const CommunityInfoAPi = @"/community/get";
NSString * const BuildingInfoAPi = @"/building/get/";
NSString * const ChangeMobileApi = @"/owners/verifyOldPhone";
NSString * const BindNewMobileApi = @"/owners/verifyNewPhone";
NSString * const ImageUploadApi = @"/resum/upload";

NSString * const OwnersInfoApi = @"/owners/info";
NSString * const PropertyAddApi = @"/owners/propertyAdd";

NSString * const PropertydeleteApi = @"/owners/propertydelete/";

NSString * const CommunityBuildingListApi = @"/community/building/list";
NSString * const QueryVoteListApi = @"/vote/user/query/doing";
NSString * const VoteDetailApi = @"/vote/user/";
NSString * const VoteFinishListApi = @"/vote/user/list/fin";
NSString * const VoteFinishQueryListApi = @"/vote/user/query/fin";
NSString * const VoteItemListApi = @"/vote/user/list/item/";
NSString * const VoteHouseListApi = @"/vote/user/house/list";
NSString * const VoteActionApi = @"/vote/user/choose";

#pragma mark - 业主委员会

NSString * const GetBuildingsApi = @"/ownersCommittee/getBuildings";
NSString * const GetCommitteeBuildingDetailApi = @"/ownersCommittee/building/detail/";
NSString * const CouncilVoteListApi  = @"/vote/building/list/doing";
NSString * const CouncilQueryVoteListApi = @"/vote/building/query/doing";
NSString * const CouncilQueryVoteApi = @"/vote/building/query/";
NSString * const CouncilFinishVoteListApi  = @"/vote/building/list/fin";
NSString * const CouncilQueryFinishVoteListApi  =@"/vote/building/query/fin";
NSString * const CouncilFinishVoteDetailApi = @"/vote/building/query/";
NSString * const CouncilBuildingItemListApi = @"/vote/building/list/item/";
NSString * const VoteBuildingHouseListApi = @"/vote/building/house/list";
NSString * const CouncilBuildingResultApi = @"/vote/building/result/";
NSString * const CouncilBuildingCommitResultApi = @"/vote/building/end";
NSString * const CouncilAddNewVoteThemeBApi = @"/vote/building/add/";
NSString * const CouncilChangeVoteThemeApi = @"/vote/building/change";

@interface NetworkManager()
@property (nonatomic, strong) NetworkManager * netManager;
@end

@implementation NetworkManager

-(instancetype)init {
    @throw [NSException exceptionWithName:@"单例类" reason:@"不能用此方法构造" userInfo:nil];
}

-(instancetype)initPrivate {
    if (self = [super init]) {
        
    }
    return  self;
}
+(instancetype)sharedInstance {
    static NetworkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[self alloc] initPrivate];
            
        }
    });
    return  manager;
}

-(NetworkManager *)netManager {
    if (_netManager == nil) {
        _netManager = [NetworkManager sharedInstance];
    }
    return _netManager;
}
#pragma mark - 业务请求方法
//一般get请求
- (void)generalGetWithURL:(NSString *)requestURL param:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock; {
    [self.netManager getWithURL:requestURL param:paramDic needToken: false returnBlock:infoBlock];
}


#pragma mark - 登录接口

-(void)postWithLoginParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
     [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,LoginApi] param:paramDic needToken: true returnBlock:infoBlock];
}


#pragma mark - 上传图片接口
-(void)postImageUploadApiParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,ImageUploadApi] param:paramDic needToken: true returnBlock:infoBlock];
}

#pragma mark -获取验证码
-(void)postWithGetCodeParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,PhoneCodeApi] param:paramDic needToken: true returnBlock:infoBlock];
 
    
}

#pragma mark -注册
-(void)postWithRegisteredParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,RegisteredApi] param:paramDic needToken: true returnBlock:infoBlock];

}

#pragma mark -验证旧手机
-(void)postVerifyOldPhoneWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,ChangeMobileApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -绑定新手机
-(void)postVerifyNewPhoneWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,BindNewMobileApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -小区账号注册审核列表
-(void)postVoteListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CommunityBuildingListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -获取业委会未完成投票列表
-(void)postCouncilVoteListApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CouncilVoteListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -获取业委会完成投票列表
-(void)postCouncilFinishVoteListApiApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CouncilFinishVoteListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -完成业委会完成投票
-(void)postCouncilBuildingCommitResultApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CouncilBuildingCommitResultApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}
#pragma mark -筛选业委会未完成投票列表
-(void)postCouncilQueryVoteListApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CouncilQueryVoteListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -筛选业委会完成投票列表
-(void)postCouncilQueryFinishVoteListApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CouncilQueryFinishVoteListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -获取已完成投票列表
-(void)postVoteFinishListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,VoteFinishListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -查看投某一项的投票人住宅号
-(void)postVoteHouseListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,VoteHouseListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -业主委员会查看投某一项的投票人住宅号
-(void)postVoteBuildingHouseListApitWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,VoteBuildingHouseListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -业主委员会新增投票项目
-(void)postCouncilAddNewVoteThemeBApitWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CouncilAddNewVoteThemeBApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -业主委员会修改投票项目
-(void)postCouncilChangeVoteThemeApiApitWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CouncilChangeVoteThemeApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -筛选投票列表
-(void)postQueryVoteListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,QueryVoteListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -筛选已完成投票列表
-(void)postVoteFinishQueryListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,VoteFinishQueryListApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -进行投票
-(void)postVoteActionApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,VoteActionApi] param:paramDic needToken: true returnBlock:infoBlock];
    
    
}

#pragma mark -删除住宅
-(void)postPropertydeleteWithParam:(NSString *)cid  returnBlock:(ReturnBlock)infoBlock {

    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@",BaseUrl,PropertydeleteApi,cid] param: nil needToken: true returnBlock:infoBlock];
    
    
}


#pragma mark - 获取社区信息
-(void)getCommunityInfoWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,CommunityInfoAPi] param:paramDic needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取项目信息
-(void)getBuildingInfoWithParam:(NSString *)cid returnBlock:(ReturnBlock)infoBlock {
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@",BaseUrl,BuildingInfoAPi,cid] param:nil needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取业主委员会未完成投票项目信息
-(void)getBuildingInfoWithParam:(NSString *)bid  voteid:(NSString *)vid returnBlock:(ReturnBlock)infoBlock {
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@/%@/1",BaseUrl,CouncilQueryVoteApi,bid,vid] param:nil needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取业主委员已经完成投票项目信息
-(void)getCouncilFinishVoteDetailApiWithParam:(NSString *)bid  voteid:(NSString *)vid  returnBlock:(ReturnBlock)infoBlock {
    //NSLog(@"CouncilFinishVoteDetailApi :%@",[NSString stringWithFormat:@"%@%@%@/%@/2",BaseUrl,CouncilFinishVoteDetailApi,bid,vid]);
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@/%@/2",BaseUrl,CouncilFinishVoteDetailApi,bid,vid] param: nil needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取业主委员已经完成投票项目结果
-(void)getCouncilBuildingResultApiWithParam:(NSString *)bid  voteid:(NSString *)vid  returnBlock:(ReturnBlock)infoBlock {
    //NSLog(@"CouncilFinishVoteDetailApi :%@",[NSString stringWithFormat:@"%@%@%@/%@/2",BaseUrl,CouncilFinishVoteDetailApi,bid,vid]);
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@/%@",BaseUrl,CouncilBuildingResultApi,bid,vid] param: nil needToken: true returnBlock:infoBlock];
}


#pragma mark - 获取用户信息
-(void)getOwnersInfoWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,OwnersInfoApi] param: paramDic needToken: true returnBlock:infoBlock];
}
#pragma mark - 新增住宅
-(void)getPropertyAddWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    [self.netManager postWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,PropertyAddApi] param: paramDic needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取业主委员会登录项目
-(void)getBuildingsApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock {
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@",BaseUrl,GetBuildingsApi] param: paramDic needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取业主委员会登录项目详情
-(void)getCommitteeBuildingDetailApiWithParam:(NSString  *)bid returnBlock:(ReturnBlock)infoBlock {
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@",BaseUrl,GetCommitteeBuildingDetailApi,bid] param: nil needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取业主投票详情
-(void)getVoteDetailApiWithParam:(NSString  *)bid returnBlock:(ReturnBlock)infoBlock {
    //NSLog(@"bid :%@",bid);
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@",BaseUrl,VoteDetailApi,bid] param: nil needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取业主投票项目列表
-(void)getVoteItemListApiWithParam:(NSString  *)bid returnBlock:(ReturnBlock)infoBlock {
    //NSLog(@"bid :%@",bid);
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@",BaseUrl,VoteItemListApi,bid] param: nil needToken: true returnBlock:infoBlock];
}

#pragma mark - 获取业主委员会投票项目列表
-(void)getCouncilBuildingItemListApiWithParam:(NSString  *)vid returnBlock:(ReturnBlock)infoBlock {
    //NSLog(@"bid :%@",bid);
    NSDictionary * dataDic =  [UserDefUtils getDictionaryForKey:@"chioceBuildingProject"];
    [self.netManager getWithURL: [NSString stringWithFormat:@"%@%@%@/%@",BaseUrl,CouncilBuildingItemListApi,[NSString stringWithFormat:@"%@",dataDic[@"bid"]] ,vid] param: nil needToken: true returnBlock:infoBlock];
}









#pragma mark - 基础请求方法
//放入请求头
- (void)postWithURL:(NSString *)requestURL param:(NSDictionary *)paramDic needToken:(BOOL)needToken returnBlock:(ReturnBlock)infoBlock {
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getSessionManager: needToken];
    
    [manager POST:requestURL parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        
        if ([[NSString stringWithFormat:@"%@" ,dict[@"retcode"]] isEqualToString:@"127"]) {
            AppDelegate *AppDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            AppDele.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VoteLoginViewController new]];
            [[AccountManager sharedInstance] missLoginDeal];
             return ;
        }
        
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure error: %@", error);
        NSDictionary *dict = @{@"returnInfo" : @NO};
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
    }];
}

//放入请求体
- (void)postWithURL:(NSString *)requestURL paramBody:(NSDictionary *)paramDic needToken:(BOOL)needToken returnBlock:(ReturnBlock)infoBlock {
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getSessionManager: needToken];
    [manager POST:requestURL parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        
        if ([[NSString stringWithFormat:@"%@" ,dict[@"retcode"]] isEqualToString:@"127"]) {
            AppDelegate *AppDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            AppDele.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VoteLoginViewController new]];
            [[AccountManager sharedInstance] missLoginDeal];
            return ;
        }
        
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure error: %@", error);
        NSDictionary *dict = @{@"returnInfo" : @NO};
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
    }];

}

- (void)getWithURL:(NSString *)requestURL param:(NSDictionary *)paramDic  needToken:(BOOL)needToken returnBlock:(ReturnBlock)infoBlock {
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getSessionManager: needToken];
    [manager GET:requestURL parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        if ([[NSString stringWithFormat:@"%@" ,dict[@"retcode"]] isEqualToString:@"127"]) {
            AppDelegate *AppDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            AppDele.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VoteLoginViewController new]];
            [[AccountManager sharedInstance] missLoginDeal];
             return ;
        }
        self.returnBlock = infoBlock;
        
        self.returnBlock(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dict = @{@"returnInfo" : @NO};
        NSLog(@"error:%@",error);
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
        
    }];
}

- (void)deleteWithURL:(NSString *)requestURL param:(NSDictionary *)paramDic  needToken:(BOOL)needToken returnBlock:(ReturnBlock)infoBlock {
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getSessionManager: needToken];
    [manager DELETE:requestURL parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dict = @{@"returnInfo" : @NO};
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
    }];
}


- (void)putWithURL:(NSString *)requestURL param:(NSDictionary *)paramDic  needToken:(BOOL)needToken returnBlock:(ReturnBlock)infoBlock {
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getSessionManager: needToken];
    [manager PUT:requestURL parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
        if ([[NSString stringWithFormat:@"%@" ,dict[@"retcode"]] isEqualToString:@"127"]) {
            AppDelegate *AppDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            AppDele.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VoteLoginViewController new]];
            [[AccountManager sharedInstance] missLoginDeal];
            return ;
        }
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dict = @{@"returnInfo" : @NO};
        self.returnBlock = infoBlock;
        self.returnBlock(dict);
    }];
}

#pragma  mark - 头部文件设置
- (AFHTTPSessionManager *)getSessionManager:(BOOL)needToken
{
    static AFHTTPSessionManager *sessionManager = nil;
    sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //(这里设置涉及到AFHTTPRequestSerializer  ，AFJSONRequestSerializer java 后台getParameter能否收到参数，AFHTTPRequestSerializer能)测试无效
    
    [sessionManager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[sessionManager.requestSerializer setValue:@"application/form-data" forHTTPHeaderField:@"Content-Type"];
    [sessionManager.requestSerializer setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    sessionManager.requestSerializer.timeoutInterval = NetworkTimeoutInterval;
    
    //证书问题===
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    sessionManager.securityPolicy = securityPolicy;
    //证书问题===
    
    NSString *str = [YLDeviceUtil getSystemInfo];
    [sessionManager.requestSerializer setValue:str forHTTPHeaderField:@"platform"];
    NSString * language = [NSString string];
    
    if ([[self currentLanguage] isEqualToString:@"zh-Hans-CN"]) {
        language = @"cn";
    }else{
        language = @"en";
    }
    [sessionManager.requestSerializer setValue:language forHTTPHeaderField:@"lan"];
    [sessionManager.requestSerializer setValue:[YLDeviceUtil getAPPVersion] forHTTPHeaderField:@"version"];
    //[sessionManager.requestSerializer setValue:@"Paw/3.0.14 (Macintosh; OS X/10.12.5) GCDHTTPRequest"forHTTPHeaderField:@"User-Agent"];
    if (needToken) {
        UserModel * user = [[AccountManager sharedInstance] fetch];
        NSLog(@"yltoken = %@", user.accessToken);
        [sessionManager.requestSerializer setValue: @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpblR5cGUiOiIyIiwibG9naW5OYW1lIjoiYWRtaW4iLCJleHAiOjE1NDM4MzE1MzQsInVzZXJJZCI6IncxMjM0NTYifQ.fRtN4k7s9Fu71XiRFUw_Hj7edn3fswsxvPM9qKHXPz4" forHTTPHeaderField:@"token"];
    }
    return sessionManager;
}

- (NSString*)currentLanguage
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

@end
