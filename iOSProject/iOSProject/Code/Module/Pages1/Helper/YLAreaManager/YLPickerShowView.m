//
//  YLPickerShowView.m
//  iOSProject
//
//  Created by 王留根 on 2019/1/7.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import "YLPickerShowView.h"

@interface YLPickerShowView ()

/** 遮罩按钮 */
@property (weak, nonatomic) UIButton * coverBtn;
/** 遮罩点击响应 */
- (void)coverBtnClick:(UIButton *)button;


/** pickerView上 左、右上角的按钮 点击响应 */
- (void)pickerLeftBtnClick:(UIButton *)button;
- (void)pickerRightBtnClick:(UIButton *)button;


/** 展示的pickerView */
@property (weak, nonatomic) UIPickerView * pickerView;

@end


@implementation YLPickerShowView
#pragma mark - public function

// 便利构造
+ (instancetype)showView
{
    YLPickerShowView * showView = [[YLPickerShowView alloc] init];
    showView.bounds = [UIScreen mainScreen].bounds;
    showView.backgroundColor = [UIColor clearColor];
    return showView;
}

//  显示pickerView
- (void)showPicker:(UIPickerView *)pickerView pickerHeight:(CGFloat)pickerHeight
{
    self.pickerView = pickerView;
    
    // 1.创建遮罩
    UIButton * coverBtn = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [[UIApplication sharedApplication].keyWindow addSubview:button];
        button.frame = [UIScreen mainScreen].bounds;
        // 设置透明度且不影响子视图，使用下面这种方式
        button.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65];
        [button addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    self.coverBtn = coverBtn;
    
    // 2.添加picker选择器
    [coverBtn addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(coverBtn);
        make.centerX.equalTo(coverBtn);
        make.bottom.equalTo(coverBtn);
        make.height.equalTo(@(pickerHeight));
    }];
    
    // 3.选择器上添加的一行view
    UIView * topView =
    ({
        // 创建并添加
        UIView * view = [[UIView alloc] init];
        [coverBtn addSubview:view];
        // 基本配置
        view.backgroundColor = [UIColor colorWithHex:0xd9d9d9];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(coverBtn);
            make.right.equalTo(coverBtn);
            make.bottom.equalTo(pickerView.mas_top);
            make.height.equalTo(@(40));
        }];
        
        //        [view mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(coverBtn);
        //            make.right.equalTo(coverBtn);
        //            make.bottom.equalTo(pickerView.mas_top);
        //            make.height.equalTo(@(40));
        //        }];
        
        view;
    });
    // 4.topView上添加左右工具按钮
    // 4.1topView上 添加取消按钮 左侧
    UIButton * leftBtn =
    ({
        // 创建并添加
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [topView addSubview:button];
        // 基本配置
        button.layer.cornerRadius = 5;
        [button setTitle:@"取消" forState:UIControlStateNormal];
        //        UIColor * leftTitleColor = [UIColor colorWithRed:34/255.0f green:88/255.0f blue:226/255.0f alpha:1];
        //        [button setTitleColor:leftTitleColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:0x008ae0] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setContentEdgeInsets:UIEdgeInsetsMake(5, 8, 5, 8)];
        [button addTarget:self action:@selector(pickerLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topView).offset(10);
            make.centerY.equalTo(topView);
        }];
        
        button;
    });
    leftBtn.backgroundColor = [UIColor clearColor];
    // 4.2topView上 添加完成按钮 右侧
    UIButton * rightBtn =
    ({
        // 创建并添加
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [topView addSubview:button];
        // 基本配置
        //        button.backgroundColor = [UIColor colorWithRed:47/255.0f green:113/255.0f blue:212/255.0f alpha:1];
        //        button.layer.cornerRadius = 5;
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:0x008ae0] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setContentEdgeInsets:UIEdgeInsetsMake(5, 8, 5, 8)];
        [button addTarget:self action:@selector(pickerRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topView).offset(-10);
            make.centerY.equalTo(topView);
        }];
        
        button;
    });
    rightBtn.backgroundColor = [UIColor clearColor];
}

#pragma mark - extension function


#pragma mark - extension 事件响应



/** 遮罩点击响应 */
- (void)coverBtnClick:(UIButton *)button
{
    [button removeFromSuperview];   // 遮罩移除
    [self removeFromSuperview];
}

/** pickerView上 左上角的取消按钮 点击响应 */
- (void)pickerLeftBtnClick:(UIButton *)button
{
    [self.coverBtn removeFromSuperview];     // 移除遮罩
    [self removeFromSuperview];
}

/** pickerView上 右上角的完成按钮 点击响应 */
- (void)pickerRightBtnClick:(UIButton *)button
{
    // 移除遮罩
    [self.coverBtn removeFromSuperview];
    [self removeFromSuperview];
    
    // block 回调
    if (self.doneBtnClickAction) {
        self.doneBtnClickAction(self.pickerView);
    }
    
}






@end

