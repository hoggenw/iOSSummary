//
//  YLAddressPickerUtil.h
//  iOSProject
//
//  Created by 王留根 on 2019/1/7.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN
@class YLAreaData;
@interface YLAddressPickerUtil : NSObject
/**
 *  显示地址选择器
 *
 *  @param areaId 默认选中的areaId，没有默认值时传0
 */
- (void)showWithAreaId:(NSInteger)areaId;

/** 完成按钮点击响应 */
@property (copy, nonatomic) void(^doneBtnClickAction)(YLAreaData *selectAreaData);

@end

NS_ASSUME_NONNULL_END
