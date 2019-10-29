//
//  FileViewController.m
//  iOSProject
//
//  Created by 王留根 on 2018/11/29.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import "FileViewController.h"
#import "LPDQuoteImagesView.h"

@interface FileViewController ()<LPDQuoteImagesViewDelegate>
@property (nonatomic, strong) LPDQuoteImagesView *quoteImagesView;
@property (nonatomic, strong)  UIView *pictureView;
@end

@implementation FileViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIView *pictureView = ({
//        UIView *view = [[UIView alloc] init];
//        [self.view addSubview:view];
//        [self setUpLineView:view leftTitle:@"文件 " bottomNeedLine:YES];
//        CGFloat width = (ScreenWidth- 50 )/4;
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.and.right.equalTo(self.view);
//            make.top.equalTo(self.view.mas_top).offset(kNavigationHeight);
//            make.height.equalTo(@(width + 60));
//
//        }];
//
//        [view addLineWithSide:LineViewSideInBottom lineColor: [UIColor colorWithHexString:@"0xdddddd"] lineHeight:0.5 leftMargin:10 rightMargin:10];
//        view;
//    });
    
    CGFloat width = (ScreenWidth- 50 )/4;
    _quoteImagesView =[[LPDQuoteImagesView alloc] initWithFrame:CGRectMake(10 , kNavigationHeight, ScreenWidth- 20 , (width + 20)) withCountPerRowInView:4 cellMargin:10 ];
    //初始化view的frame, view里每行cell个数， cell间距（上方的图片1 即为quoteImagesView）
    _quoteImagesView.totalSelectedCount = 12;
    //最大可选照片数
    //_quoteImagesView.backgroundColor = [UIColor colorWithHexString:@"f3f4f5"];
    _quoteImagesView.collectionView.scrollEnabled = NO;
    //view可否滑动
    _quoteImagesView.navcDelegate = self;    //self 至少是一个控制器。
    //委托（委托controller弹出picker，且不用实现委托方法）
    [_quoteImagesView addLineWithSide:LineViewSideInBottom lineColor: [UIColor colorWithHexString:@"0xdddddd"] lineHeight: 0.5 leftMargin: 0 rightMargin: 0];
    
    [self.view addSubview:_quoteImagesView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods
- (UILabel *)setUpLineView:(UIView *)lineView leftTitle:(NSString *)leftTitle bottomNeedLine:(BOOL)bottomNeedLine
{
    CGFloat leftMargin = 10;
    
    // left Label
    UILabel *label = [[UILabel alloc] init];
    [lineView addSubview:label];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithHexString:@"333333"];
    label.text = leftTitle;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView).offset(leftMargin);
        make.top.equalTo(lineView.mas_top).offset(15);
    }];
    
    return  label;
}

#pragma mark - Extension Delegate or Protocol
-(void)quoteImagesViewNeedUpdateView:(BOOL)bigger{
    if (bigger) {
        float height = _pictureView.size.height;
         CGFloat width = (ScreenWidth- 50 )/4;
        [_pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height + width + 20));
        }];
    }
    
}
@end
