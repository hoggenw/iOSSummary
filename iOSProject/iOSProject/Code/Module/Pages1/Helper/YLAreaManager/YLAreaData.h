//
//  YLAreaData.h
//  iOSProject
//
//  Created by 王留根 on 2019/1/8.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  地区模型 (哪个省  哪个市  哪个区)
 */
@interface YLAreaData : NSObject

// 如果不存在，则为nil
@property (copy, nonatomic) NSString * provinceTitle;
@property (copy, nonatomic) NSString * cityTitle;
@property (copy, nonatomic) NSString * zoneTitle;

@property (assign, nonatomic) NSInteger provinceRow;
@property (assign, nonatomic) NSInteger cityRow;
@property (assign, nonatomic) NSInteger zoneRow;

//@property (assign, nonatomic) NSInteger provinceId;
//@property (assign, nonatomic) NSInteger cityId;
//@property (assign, nonatomic) NSInteger zoneId;

/** Id (省 或 市 或 区 Id) */
@property (assign, nonatomic) NSInteger areaId;

@end

NS_ASSUME_NONNULL_END
