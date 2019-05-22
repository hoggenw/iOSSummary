//
//  YLArea.h
//  iOSProject
//
//  Created by 王留根 on 2019/1/8.
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

NS_ASSUME_NONNULL_END
