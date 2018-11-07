//
//  UserDefUtils.h
//  qianjituan2.0
//
//  Created by ios-mac on 16/4/13.
//  Copyright © 2016年 ios-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TemporaryPhoneNumber @"temporaryPhoneNumber"
#define TemporaryCountryNumber @"TemporaryCountryNumber"

@interface UserDefUtils : NSObject
/**
 *字典本地化存储
 */
+(void)saveDictionary:(NSDictionary *)dictionary forKey:(NSString *)key;
/**
 *  字典本地化取出
 */
+(NSDictionary *)getDictionaryForKey:(NSString *)key;
/**
 *  数组本地化存储
 */
+(void)saveArray:(NSArray *)saveArray forKey:(NSString *)key;
/**
 *  数组本地化取出
 */
+(NSArray *)getArrayForKey:(NSString *)key;
/**
 *  字符串本地化存储
 */
+ (void) saveString:(NSString*)saveString forKey:(NSString *)key;
/**
 *  字符串本地取出
 */
+ (NSString *) getStringForKey:(NSString *)key;
@end
