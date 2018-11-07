//
//  LocalSQliteManager.m
//  FTXExperienceStore
//
//  Created by 王留根 on 2018/1/10.
//  Copyright © 2018年 hoggen. All rights reserved.
//

#import "LocalSQliteManager.h"
#include <FMDB/FMDB.h>

@implementation LocalSQliteManager{
    FMDatabase *fmdb;
}



-(instancetype)init {
    @throw [NSException exceptionWithName:@"单例类" reason:@"不能用此方法构造" userInfo:nil];
}

-(instancetype)initPrivate {
    if (self = [super init]) {
        //[self creatDataBase];
    }
    return  self;
}
+(instancetype)sharedInstance {
    static LocalSQliteManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[self alloc] initPrivate];
            
        }
    });
    return  manager;
}

////初始化数据库
//-(void)creatDataBase{
//
//    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *dbPath = [[documentsPath firstObject] stringByAppendingPathComponent:@"experenceStore.db"];
//    if (!fmdb) {
//        fmdb=[[FMDatabase alloc]initWithPath:dbPath];
//    }
//    if ([fmdb open]) {
///**
// json={
//
// "envelopeId" : //红包唯一id，本地存储key
//
// "status" : //红包目前状态（默认为未领取）
//
// "descripe" : ,//红包描述
//
// "envelopeFrom": //红包发送人
//
// "envelopeType": //发送红包类型 ， 随机或者固定
//
// "cionType" : //红包币种
// "gainUserPhoneNUmber" //红包领取人
//
// }
// **/
//        //红包信息
//        [fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS EnvelopeTabel (envelopeId TEXT PRIMARY KEY NOT NULL,status INTEGER,envelopeType INTEGER,descripeString TEXT NOT NULL,envelopeFrom TEXT NOT NULL,cionType TEXT NOT NULL,gainUserPhoneNumber TEXT,otherInfo TEXT,envelopeDate TEXT)"];
//        NSLog(@"creat success");
//
//    }
//}
//
///**判断数据是否存在*/
//-(BOOL)isExist:(EnvelopeModel *)model{
//    //登录不同的钱包在同一个数据库中领取
//    FMResultSet *rs=[fmdb executeQuery:@"SELECT *FROM EnvelopeTabel WHERE envelopeId=?",model.envelopeId];
//    if ([rs next]) {
//        return YES;
//    }
//    return NO;
//}
//
///**获取模型*/
//-(EnvelopeModel *)getEnvelopeModel:(NSString *)envelopeId{
//    //登录不同的钱包在同一个数据库中领取
//    FMResultSet *rs=[fmdb executeQuery:@"SELECT *FROM EnvelopeTabel WHERE envelopeId=?",envelopeId];
//    EnvelopeModel *model = nil;
//    while ([rs next]) {
//        model =  [EnvelopeModel new];
//        model.envelopeId =[rs stringForColumn: @"envelopeId"];
//        model.status=[[rs stringForColumn:@"status"] intValue];
//        model.descripeString=[rs stringForColumn:@"descripeString"];
//        model.envelopeFrom=[rs stringForColumn:@"envelopeFrom"];
//        model.envelopeType=[[rs stringForColumn:@"envelopeType"] intValue];
//        model.gainUserPhoneNumber=[rs stringForColumn:@"gainUserPhoneNumber"];
//        model.cionType=[rs stringForColumn:@"cionType"];
//        model.otherInfo=[rs stringForColumn:@"otherInfo"];
//        model.envelopeDate = [rs stringForColumn:@"envelopeDate"];
//    }
//    return model;
//}
//
///**存入相应模块的数据*/
//-(BOOL)saveDataToTabel:(EnvelopeModel *)model{
//    if (![self isExist:model]) {
//        BOOL success=[fmdb executeUpdate:@"INSERT into EnvelopeTabel values(?,?,?,?,?,?,?,?,?)", model.envelopeId, @(model.status), @(model.envelopeType), model.descripeString,model.envelopeFrom,model.cionType,model.gainUserPhoneNumber,model.otherInfo,model.envelopeDate];
//        return success;
//
//    }else{
//
//        BOOL success=[fmdb executeUpdate:@"update EnvelopeTabel set status= ?,envelopeType = ?,descripeString = ?,envelopeFrom = ?,cionType = ?,gainUserPhoneNumber = ?,otherInfo = ?, envelopeDate = ? where envelopeId= ? ",  @(model.status), @(model.envelopeType), model.descripeString,model.envelopeFrom,model.cionType,model.gainUserPhoneNumber,model.otherInfo,model.envelopeDate,model.envelopeId];
//
//        return success;
//
//
//    }
//    return YES;
//}
//
//
///**取出相应模块的数据*/
//-(NSArray *)catchLoactionData{
//
//    FMResultSet *rs=[fmdb executeQuery:@"select * from EnvelopeTabel ORDER BY date DESC"];
//    //遍历结果集
//    NSMutableArray *array=[NSMutableArray array];
//    while ([rs next]) {
//        EnvelopeModel *model = [EnvelopeModel new];
//        model.envelopeId =[rs stringForColumn: @"envelopeId"];
//        model.status=[[rs stringForColumn:@"status"] intValue];
//        model.descripeString=[rs stringForColumn:@"descripeString"];
//        model.envelopeFrom=[rs stringForColumn:@"envelopeFrom"];
//        model.envelopeType=[[rs stringForColumn:@"envelopeType"] intValue];
//        model.gainUserPhoneNumber=[rs stringForColumn:@"gainUserPhoneNumber"];
//        model.cionType=[rs stringForColumn:@"cionType"];
//        model.otherInfo=[rs stringForColumn:@"otherInfo"];
//        model.envelopeDate=[rs stringForColumn:@"envelopeDate"];
//        [array addObject:model];
//    }
//    return array;
//
//}
//
//
//
//
///**删除数据库中指定数据*/
//-(BOOL)deletALLModel:(NSArray *)array{
//    if (array.count != 0) {
//        BOOL isSuccess = YES;
//        for ( EnvelopeModel *model in array) {
//
//            BOOL success =[ fmdb executeUpdate:@"DELETE from EnvelopeTabel where envelopeId=?",model.envelopeId ];
//            if (!success) {
//                isSuccess = NO;
//            }
//        }
//        return isSuccess;
//    }
//
//    return YES;
//}
///**删除数据库中指定数据*/
//-(BOOL)deletePSConcernCommodityViewModel:(EnvelopeModel *)model{
//
//    BOOL success =[ fmdb executeUpdate:@"DELETE from EnvelopeTabel where envelopeId=?",model.envelopeId ];
//
//    return success;
//
//
//}


@end
