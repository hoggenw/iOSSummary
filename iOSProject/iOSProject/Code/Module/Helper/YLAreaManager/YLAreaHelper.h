//
//  YLAreaHelper.h
//  iOSProject
//
//  Created by 王留根 on 2019/1/7.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 省市区相关模型


/**
 *  省市区模型
 *  PSAreaModel 已被使用，除非弃用那个
 */
@interface YLArea : NSObject


/** 地区Id */
@property (assign, nonatomic) NSInteger areaId;

/** 父节点的Id */
@property (assign, nonatomic) NSInteger parentId;

/** 标题 */
@property (copy, nonatomic) NSString *title;

/** 子节点列表 */
@property (strong, nonatomic) NSMutableArray<YLArea *> *childs;


@end

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
