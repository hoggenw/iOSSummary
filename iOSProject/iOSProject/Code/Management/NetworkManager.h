//
//  NetworkManager.h
//  FTXExperienceStore
//
//  Created by 王留根 on 2018/1/10.
//  Copyright © 2018年 hoggen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLHintView.h"

//返回block
typedef void (^ReturnBlock)(NSDictionary *returnDict);

extern NSString * const BaseUrl;              // 网络请求的BaseUrl
extern NSString * const WebBaseUrl;         // 通用网页的BaseUrl

extern NSString * const LoginApi;
extern NSString * const PhoneCodeApi;
extern NSString * const RegisteredApi;

extern NSString * const SetPayPassWorldApi;
extern NSString * const SetVerifyCodeApi;
extern NSString * const ChangeMobileApi;

extern NSString * const GETPortApi;
extern NSString * const ImageUploadApi;

@interface NetworkManager : NSObject

@property(nonatomic,strong)ReturnBlock returnBlock;
+(instancetype)sharedInstance;

//判断目前App Store版本
- (void)generalGetWithURL:(NSString *)requestURL param:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;

//登录接口
-(void)postWithLoginParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//注册接口

-(void)postWithRegisteredParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//获取验证码
-(void)postWithGetCodeParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;



//-验证旧手机
-(void)postVerifyOldPhoneWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//绑定新手机
-(void)postVerifyNewPhoneWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//获取社区信息
-(void)getCommunityInfoWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;

// 上传图片接口
-(void)postImageUploadApiParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;

// 获取项目信息
-(void)getBuildingInfoWithParam:(NSString *)cid returnBlock:(ReturnBlock)infoBlock;
//获取用户信息
-(void)getOwnersInfoWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//新增住宅
-(void)getPropertyAddWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//#pragma mark -删除住宅
-(void)postPropertydeleteWithParam:(NSString *)cid  returnBlock:(ReturnBlock)infoBlock;

// 获取业主委员会登录项目
-(void)getBuildingsApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//获取业主委员会登录项目详情
-(void)getCommitteeBuildingDetailApiWithParam:(NSString  *)bid returnBlock:(ReturnBlock)infoBlock;

// -获取投票列表
-(void)postVoteListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//-筛选业委会未完成投票列表
-(void)postCouncilQueryVoteListApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//-获取业委会完成投票列表
-(void)postCouncilFinishVoteListApiApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//-筛选业委会完成投票列表
-(void)postCouncilQueryFinishVoteListApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
// -获取业委会未完成投票列表
-(void)postCouncilVoteListApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
// -进行投票
-(void)postVoteActionApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;

//查看投某一项的投票人住宅号
-(void)postVoteHouseListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
//-获取已完成投票列表
-(void)postVoteFinishListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;

//获取业主投票项目列表
-(void)getVoteItemListApiWithParam:(NSString  *)bid returnBlock:(ReturnBlock)infoBlock;

// -筛选投票列表
-(void)postQueryVoteListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
// -筛选已完成投票列表
-(void)postVoteFinishQueryListWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
// 获取业主投票详情
-(void)getVoteDetailApiWithParam:(NSString  *)bid returnBlock:(ReturnBlock)infoBlock ;
//- 获取业主委员会未完成投票项目信息
-(void)getBuildingInfoWithParam:(NSString *)bid  voteid:(NSString *)vid returnBlock:(ReturnBlock)infoBlock;
// - 获取业主委员已经完成投票项目信息
-(void)getCouncilFinishVoteDetailApiWithParam:(NSString *)bid  voteid:(NSString *)vid  returnBlock:(ReturnBlock)infoBlock;
// - 获取业主委员会投票项目列表
-(void)getCouncilBuildingItemListApiWithParam:(NSString  *)vid returnBlock:(ReturnBlock)infoBlock;
//-业主委员会查看投某一项的投票人住宅号
-(void)postVoteBuildingHouseListApitWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
// 获取业主委员已经完成投票项目结果
-(void)getCouncilBuildingResultApiWithParam:(NSString *)bid  voteid:(NSString *)vid  returnBlock:(ReturnBlock)infoBlock;
// -完成业委会完成投票
-(void)postCouncilBuildingCommitResultApiWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
// -业主委员会新增投票项目
-(void)postCouncilAddNewVoteThemeBApitWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;
// -业主委员会修改投票项目
-(void)postCouncilChangeVoteThemeApiApitWithParam:(NSDictionary *)paramDic returnBlock:(ReturnBlock)infoBlock;



@end
