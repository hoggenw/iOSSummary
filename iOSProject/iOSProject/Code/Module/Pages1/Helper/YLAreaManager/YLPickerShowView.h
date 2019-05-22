//
//  YLPickerShowView.h
//  iOSProject
//
//  Created by 王留根 on 2019/1/7.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLPickerShowView : UIView
/** 便利构造 */
+ (instancetype)showView;


/**
 *  显示pickerView
 *
 *  @param pickerView   待显示的pickerView
 *  @param pickerHeight pickerView的高度
 */
- (void)showPicker:(UIPickerView *)pickerView pickerHeight:(CGFloat)pickerHeight;


/** 右上角完成按钮 响应block */
@property (copy, nonatomic) void(^doneBtnClickAction)(UIPickerView * pickerView);

@end

NS_ASSUME_NONNULL_END
