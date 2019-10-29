//
//  YLAreaHelper.h
//  iOSProject
//
//  Created by 王留根 on 2019/1/7.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLArea.h"
#import "YLAreaData.h"

NS_ASSUME_NONNULL_BEGIN




@interface YLAreaHelper : NSObject


+ (instancetype)shareInstance;

/** 省份列表 */
@property (readonly, strong, nonatomic) NSArray<YLArea *> *provinceList;


/**
 *  数据加载
 */
- (void)reloadData;

/** 通过areaId构造AreaData */
- (YLAreaData *)areaDataWithAreaId:(NSInteger)areaId;
/** 通过areaId构造AreaString */
- (NSString *)areaStringWithAreaId:(NSInteger)areaId;


@end

NS_ASSUME_NONNULL_END
