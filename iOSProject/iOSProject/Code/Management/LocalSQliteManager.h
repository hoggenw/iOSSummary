//
//  LocalSQliteManager.h
//  FTXExperienceStore
//
//  Created by 王留根 on 2018/1/10.
//  Copyright © 2018年 hoggen. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LocalSQliteManager : NSObject


+(instancetype)sharedInstance;

//-(BOOL)isExist:(EnvelopeModel *)model;
//
///**存入相应模块的数据*/
//-(BOOL)saveDataToTabel:(EnvelopeModel *)model;
//
///**删除数据库中指定数据*/
//-(BOOL)deletePSConcernCommodityViewModel:(EnvelopeModel *)model;
//
///**获取模型*/
//-(EnvelopeModel *)getEnvelopeModel:(NSString *)envelopeId;



@end
