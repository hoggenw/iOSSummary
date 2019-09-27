//
//  YLLoadingView.m
//  iOSProject
//
//  Created by 王留根 on 2019/9/10.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#define AutoSize(px) ((kScreenHeight > kScreenWidth) ? ([UIScreen mainScreen].bounds.size.width/750)*(px) : ([UIScreen mainScreen].bounds.size.height/750)*(px))
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "YLLoadingView.h"


@interface YLLoadingView()
@property(nonatomic,strong)UIImageView *loadingImgView;

@end

@implementation YLLoadingView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.loadingImgView = [[UIImageView alloc]init];
        self.loadingImgView.image = [UIImage imageNamed:@"loading_video_"];
        [self addSubview:self.loadingImgView];
        
    }
    [self setLoadingAnimation];
    return self;
}
-(void)layoutSubviews
{
    self.loadingImgView.frame = CGRectMake(self.bounds.size.width * 0.5 - AutoSize(60), self.bounds.size.height * 0.5 - AutoSize(60), AutoSize(120), AutoSize(120));
    
}
-(void)setLoadingAnimation
{
    if (self.loadingImgView.layer.animationKeys) {
        return;
    }
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = 0;
    rotateAnimation.toValue = @(M_PI * 2);
    rotateAnimation.duration = 1.0;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    [self.loadingImgView.layer addAnimation:rotateAnimation forKey:@"rotation"];
}
-(void)showAndStartAnimation
{
    
    if (self.loadingImgView.layer.animationKeys) {
        self.hidden = NO;
        return;
    }
    self.hidden = NO;
    [self setLoadingAnimation];
}
-(void)hideAndStopAnimation
{
    if (self.loadingImgView.layer.animationKeys) {
        [self.loadingImgView.layer removeAllAnimations];
    }
    self.hidden = YES;
}

@end
