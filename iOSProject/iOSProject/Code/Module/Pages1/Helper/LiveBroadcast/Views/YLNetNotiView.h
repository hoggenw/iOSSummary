//
//  YLNetNotiView.h
//  iOSProject
//
//  Created by 王留根 on 2019/9/10.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,YLNetNotiViewType ) {
    YLNetNotiViewTypeOfNoNetWork   = 0,//没有网络的时候的提示类型
    YLNetNotiViewTypeOfBecomeWWAN  = 1,//切换成3G/4G时候的提示类型
};
typedef void(^SelectBtnClickBlock)(void);
typedef void(^backbtnCLickBlock)(void);

@interface YLNetNotiView : UIView
/*
 背景View
 */
@property(nonatomic,strong)UIView *bgView;

/*
 上方的提示文字
 */
@property(nonatomic,strong)UILabel *showLabel;

/*
 下面的选择按钮
 */
@property(nonatomic,strong)UIButton *selectBtn;

/*
 提示类型
 */
@property (nonatomic, assign) YLNetNotiViewType netWorkNotiViewType;

/*
 提示界面的返回按钮
 */
@property(nonatomic,strong)UIButton *backBtn;
/*
 点击按钮的回调方法
 */
@property(nonatomic,copy)SelectBtnClickBlock btnClickblock;
/*
 点击返回按钮的回调方法
 */
@property(nonatomic,copy)backbtnCLickBlock backBlock;
/*
 显示并且设定显示的类型
 */
-(void)showNetNotiViewWithType:(YLNetNotiViewType)type;

/*
 隐藏提示框
 */
-(void)hideNetNotiView;


@end

NS_ASSUME_NONNULL_END
