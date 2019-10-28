//
//  NSString+Extension.m
//  FTXExperienceStore
//
//  Created by 王留根 on 2018/1/10.
//  Copyright © 2018年 hoggen. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Base64.h"


static NSString * base64hash=@"T62tz1XHCUjk8NBveQaInA3GMswumo7gc~9VZRdqhbKyiOFlJS-xPfWE04rLY5Dp";

@implementation NSString (Extension)

/**
 *  字符串 size计算
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *  @param lineMargin 行间距
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineMargin:(CGFloat)lineMargin
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineMargin;    // 行间距
    
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    CGRect textBounds = [self boundingRectWithSize:maxSize options:options attributes:attributes context:nil];
    
    return textBounds.size;
}


/**
 *  是否为空 的判断
 */
- (BOOL)isEmpty
{
   if (self == nil || self == NULL)
    {
        return YES;
    }
    else if ([self isEqual:@"<null>"] || [self isMemberOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (self.length == 0)
    {
        return YES;
    }
    else
    {
        NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (str.length == 0)
        {
            return YES;
        }
    }
    return NO;
}



/**
 *  是否符合某种正字表达式
 */
- (BOOL)isMatchRegex:(NSString *)regex
{
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

/**
 *  电话号码判断
 */
- (BOOL)isPhoneNumber
{
    NSString * regex = @"^1+[0-9]{10}";
    
    return [self isMatchRegex:regex];
}

/**
 *  身份证号判断
 */
- (BOOL)isIdentityForChina
{
    NSString *regex = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    //判断是否为空
       if (self==nil||self.length <= 0) {
           return NO;
       }
       if(![self isMatchRegex:regex]){
           return NO;
       }      //判断生日是否合法
       NSRange range = NSMakeRange(6,8);
       NSString *datestr = [self substringWithRange:range];
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       [formatter setDateFormat : @"yyyyMMdd"];
       if([formatter dateFromString:datestr]==nil){
           return NO;
       }
       //判断校验位
       if(self.length==18)
       {
           NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
           NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
           int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
           for(int i=0;i<17;i++){
               idCardWiSum+=[[self substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
           }
           int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
           NSString *idCardLast=[self substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
           //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
           if(idCardMod==2){
               if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                   return YES;
               }else{
                   return NO;
               }
           }else{
               //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
               if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                   return YES;
               }else{
                   return NO;
               }
           }
       }
       return NO;
}

- (BOOL)checkNumber;
{
    if (self.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    return [self isMatchRegex: regex];
}

- (BOOL)checkChinese
{
    if (self.length == 0) return NO;
    NSString *regex = @"[\u4e00-\u9fa5]+";
    return [self isMatchRegex: regex];
}

// md5加密
- (NSString *)md5String
{
    // md5 加密
    const char * str = self.UTF8String;
    int length = (int)strlen(str);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, length, bytes);
    
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [md5String appendFormat:@"%02X", bytes[i]];
    }
    
    return [md5String lowercaseString];
}
+ (NSString *)md5ForString:(NSString *)string
{
    return [string md5String];
}

-(NSAttributedString *)attributedStringWith:(NSDictionary *)attributedStringDictionary {
    NSMutableAttributedString *attributrString = [[NSMutableAttributedString alloc] initWithString: self ];


    
    NSRange stringRange = [self rangeOfString: self];
    [attributrString setAttributes: attributedStringDictionary range: stringRange];
    
    return  [attributrString copy] ;
}

//+ (NSString *)encryptDESForString:(NSString *)strOrigin key:(NSString *)key
//{
//    return [self encrypt:strOrigin encryptOrDecrypt:kCCEncrypt key:key];
//}
//
//+ (NSString *)decryptDESWithString:(NSString*)strDES key:(NSString*)key
//{
//    //    return nil;
//
//    return [self encrypt:strDES encryptOrDecrypt:kCCDecrypt key:key];
//
//}

//+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
//{
//    const void *vplainText;
//    size_t plainTextBufferSize;
//
//    if (encryptOperation == kCCDecrypt)
//    {
//        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
//        plainTextBufferSize = [decryptData length];
//        vplainText = [decryptData bytes];
//    }
//    else
//    {
//        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
//        plainTextBufferSize = [encryptData length];
//        vplainText = (const void *)[encryptData bytes];
//    }
//
//    CCCryptorStatus ccStatus;
//    uint8_t *bufferPtr = NULL;
//    size_t bufferPtrSize = 0;
//    size_t movedBytes = 0;
//
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//
//    //    NSString *initVec = @"init Kurodo";
//    //    const void *vinitVec = (const void *) [initVec UTF8String];
//    char iv[8] = {(char)0xef, (char)0x34, (char)0x56, (char)0x78, (char)0x90, (char)0xab, (char)0xcd, (char)0xef};
//    const void *vkey = (const void *) [key UTF8String];
//
//    ccStatus = CCCrypt(encryptOperation,
//                       kCCAlgorithmDES,
//                       kCCOptionPKCS7Padding,
//                       vkey,
//                       kCCKeySizeDES,
//                       //                       vinitVec,
//                       iv,
//                       vplainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
//
//    NSString *result = nil;
//
//    if (encryptOperation == kCCDecrypt)
//    {
//        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
//    }
//    else
//    {
//        NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//        result = [GTMBase64 stringByEncodingData:data];
//    }
//
//    return result;
//}



+ (NSString*)encodeStringInBase64:(NSString*)string
{
    NSMutableString * strResult=[[NSMutableString alloc] initWithCapacity:10];
    NSData * bytes=[string dataUsingEncoding:NSUTF8StringEncoding];
    Byte   * theByte=(Byte*)[bytes bytes];
    NSInteger length=[bytes length];
    int mod=0;
    Byte prev=0;
    for (int i=0; i<length; i++) {
        mod=i%3;
        if (mod==0) {
            [strResult appendFormat:@"%c",[base64hash characterAtIndex:((theByte[i] >> 2) & 0x3F)]];
        }else if (mod==1){
            [strResult appendFormat:@"%c",[base64hash characterAtIndex:((prev << 4 | (theByte[i] >> 4  &0x0F) )& 0x3F)]];
        }else{
            [strResult appendFormat:@"%c",[base64hash characterAtIndex:(((theByte[i] >> 6 & 0x03) | prev << 2) & 0x3F)]];
            [strResult appendFormat:@"%c",[base64hash characterAtIndex:(theByte[i] & 0x3F)]];
        }
        prev=theByte[i];
    }
    if (mod==0) {
        [strResult appendFormat:@"%c",[base64hash characterAtIndex:(prev << 4 & 0x3C)]];
        [strResult appendString:@"=="];
    }else if (mod==1){
        [strResult appendFormat:@"%c",[base64hash characterAtIndex:(prev << 2 & 0x3F)]];
        [strResult appendString:@"="];
    }
    return strResult;
}
// Base64解码
+ (NSString*)decodeBase64String:(NSString*)strBase64
{
    NSMutableString * result=[[NSMutableString alloc] initWithCapacity:10];
    for (int i=0; i<[strBase64 length]; i++)
    {
        NSRange temp1=[base64hash rangeOfString:[NSString stringWithFormat:@"%c",[strBase64 characterAtIndex:i]]];
        if (temp1.length==0)
        {
            [result appendString:@"000000"];
        }
        else
        {
            //            NSMutableString * strT=[[NSMutableString alloc] initWithString:[UtilityTool decimalTOBinary:temp1.location backLength:6]];
            NSMutableString * strT=[[NSMutableString alloc] initWithString:[NSString decimalTOBinary:temp1.location backLength:6]];
            [result appendString:strT];
        }
    }
    while ([[result substringFromIndex:result.length-8] isEqualToString:@"00000000"])
    {
        result=[NSMutableString stringWithString:[result substringWithRange:NSMakeRange(0, result.length-8)]];
    }
    Byte * byte2=(Byte*)malloc(result.length/8);
    for (int i=0; i<(result.length/8); i++)
    {
        //        byte2[i]=(Byte)[[UtilityTool toDecimalSystemWithBinarySystem:[result substringWithRange:NSMakeRange(i*8,8)]] integerValue];
        byte2[i]=(Byte)[[NSString toDecimalSystemWithBinarySystem:[result substringWithRange:NSMakeRange(i*8,8)]] integerValue];
    }
    NSData * dTemp=[NSData dataWithBytes:byte2 length:result.length/8];
    NSString * strTemp = [[NSString alloc] initWithData:dTemp encoding:NSUTF8StringEncoding];
    free(byte2);
    return strTemp;
}







+ (NSString *)decimalTOBinary:(uint16_t)tmpid backLength:(int)length
{
    NSString *a = @"";
    while (tmpid)
    {
        a = [[NSString stringWithFormat:@"%d",tmpid%2] stringByAppendingString:a];
        if (tmpid/2 < 1)
        {
            break;
        }
        tmpid = tmpid/2 ;
    }
    
    if (a.length <= length)
    {
        NSMutableString *b = [[NSMutableString alloc]init];;
        for (int i = 0; i < length - a.length; i++)
        {
            [b appendString:@"0"];
        }
        
        a = [b stringByAppendingString:a];
    }
    return a;
}

+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}

- (NSData *)replaceNoUtf8:(NSData *)data
{
    char aa[] = {'A','A','A','A','A','A'};                      //utf8最多6个字符，当前方法未使用
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length])
    {
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0)
        {
            loc++;
            continue;
        }
        else if((buffer & 0xE0) == 0xC0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                continue;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else if((buffer & 0xF0) == 0xE0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80)
                {
                    loc++;
                    continue;
                }
                loc--;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else
        {
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
    }
    
    return md;
}

- (NSDictionary *)dictionaryWithJsonString {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
