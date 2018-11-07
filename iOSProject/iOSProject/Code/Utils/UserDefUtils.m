//
//  UserDefUtils.m
//  qianjituan2.0
//
//  Created by ios-mac on 16/4/13.
//  Copyright © 2016年 ios-mac. All rights reserved.
//

#import "UserDefUtils.h"
#import "YYModel.h"

@implementation UserDefUtils
/**
 *字典本地化存储
 */
+(void)saveDictionary:(NSDictionary *)dictionary forKey:(NSString *)key{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSData *json = [dictionary yy_modelToJSONData];
    [userDef setObject:json forKey:key];
    [userDef synchronize];
    
    
}
/**
 *  字典本地化取出
 */
+(NSDictionary *)getDictionaryForKey:(NSString *)key{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSData *json = [userDef dataForKey:key];
    NSDictionary *returnDictionary = [NSDictionary dictionary];
    if (json.length > 0) {
    returnDictionary=[NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    }

    return returnDictionary;
}
/**
 *  数组本地化存储
 */
+(void)saveArray:(NSArray *)saveArray forKey:(NSString *)key{
  ;

    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:saveArray forKey:key];
    [userDef synchronize];
}
/**
 *  数组本地化取出
 */
+(NSArray *)getArrayForKey:(NSString *)key{
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSArray *getArray = [userDef arrayForKey:key];

    return getArray;
}
/**
 *  字符串本地化存储
 */
+ (void) saveString:(NSString*)saveString forKey:(NSString *)key {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:saveString forKey:key];
    [userDef synchronize];
}

/**
 *  字符串本地取出
 */
+ (NSString *) getStringForKey:(NSString *)key {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *string=[userDef stringForKey:key];
    return string;
}

@end
