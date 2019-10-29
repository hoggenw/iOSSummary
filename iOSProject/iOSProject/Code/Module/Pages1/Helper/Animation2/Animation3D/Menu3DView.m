//
//  Menu3DView.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/11.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "Menu3DView.h"

@interface Menu3DView ()
//展示视图
@property (nonatomic, strong)UIView *navView;
@property (nonatomic, strong)UIButton *menuButton;
@property (nonatomic, strong)UIView * backGroudView;
@property (nonatomic, strong)UIView *tvView;

//翻转视图
@property (nonatomic, strong)UIView *sideMenu;
@property (nonatomic, strong)CAGradientLayer *gradLayer;
@property (nonatomic, strong)UIView * containHelperView;
@property (nonatomic, strong)UIView *containView;

//判断参数
@property (nonatomic, assign)CGFloat rota;
@property (nonatomic, assign)BOOL ifOpen;


@end

@implementation Menu3DView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kNavigationHeight)];
        _menuButton = [UIButton new];
        _sideMenu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, ScreenHeight)];
        _ifOpen = false;
        
        [self intialUI];
        [self intialSideMenu];
        [self intialSideMenuUI];
        
    }
    return  self;
}

-(void)intialUI{
    _backGroudView = [[UIView alloc] initWithFrame: self.bounds];
    self.backGroudView.backgroundColor = [UIColor whiteColor];
    _tvView = [[UIView alloc] initWithFrame: self.bounds];
    _tvView.backgroundColor = [UIColor greenColor];
    _navView.backgroundColor = [UIColor brownColor];
    
    [self addSubview: _sideMenu];
    [self addSubview: _backGroudView];
    [_backGroudView addSubview:_tvView];
    [_backGroudView addSubview: _navView];
    _menuButton.frame = CGRectMake(0, 30, 54, 32);
    _menuButton.centerY = kNavigationHeight/2 + 16;
    [_menuButton setImage:[self getPathImage] forState:UIControlStateNormal];
    [_navView addSubview: _menuButton];
    [_menuButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [self addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)]];

}

-(void)gestureRecognizer:(UIPanGestureRecognizer *)gesture {
    //获取手势在相对指定视图的移动距离，即在X,Y轴上移动的像素，应该是没有正负的，
    //于是考虑用velocityInView:这个方法，这个方法是获取手势在指定视图坐标系统的移动速度，结果发现这个速度是具有方向的，
    /**
     CGPoint velocity = [recognizer velocityInView:recognizer.view];
     if(velocity.x>0) {
     　　//向右滑动
     }else{
     //向左滑动
     }
     */
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView: self];
        CGFloat rato = point.x/80;
        [self getRato: rato];
        _rota = rato;
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        [self doAnimation];
    }
}

-(void)getRato:(CGFloat)rato {
    CATransform3D tran = [self getTran];
    CGFloat rota = rato;
    if (_ifOpen == false) {
        if (rota <= 0) {
            rota = 0;
        }
        if (rota > M_PI/2) {
            rota = M_PI/2;
        }
        self.menuButton.transform = CGAffineTransformMakeRotation(rota);
        _gradLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:(((0.5-rota/2.0) > 0) ? 0.5 - rota/2 : 0)].CGColor];
        CATransform3D contaTran = CATransform3DRotate(tran, -M_PI/2+rota, 0, 1, 0);
        self.containHelperView.layer.transform = contaTran;
        CATransform3D contaTran2 = CATransform3DMakeTranslation(_containHelperView.width - 100, 0, 0);
        self.containView.layer.transform = CATransform3DConcat(contaTran, contaTran2);
        _backGroudView.transform = CGAffineTransformMakeTranslation(_containHelperView.width, 0);
    }else{
        if (rota >= 0) {
            rota = 0;
        }
        if (rota < -M_PI/2) {
            rota = -M_PI/2;
        }
        self.menuButton.transform = CGAffineTransformMakeRotation(rota + M_PI/2);
        _gradLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:(((-rota/2.0) < 0.5) ? -rota/2 : 0.5)].CGColor];
        CATransform3D contaTran = CATransform3DRotate(tran, rota, 0, 1, 0);
        self.containHelperView.layer.transform = contaTran;
        CATransform3D contaTran2 = CATransform3DMakeTranslation(_containHelperView.width - 100, 0, 0);
        self.containView.layer.transform = CATransform3DConcat(contaTran, contaTran2);
        _backGroudView.transform = CGAffineTransformMakeTranslation(_containHelperView.width, 0);
    }
}

-(void)doAnimation {
    if (_ifOpen == false) {
        if (_rota > M_PI/4) {
            [self open];
        }else{
            [self close];
        }
    }else{
        if (_rota > -M_PI/4) {
            [self open];
        }else{
            [self close];
        }
    }
}

-(void)initialTrans {
    CATransform3D tran = [self getTran];
    /**
     //contaTran沿Y轴翻转是在tran的基础之上
     CATransform3D contaTran = CATransform3DRotate(tran,-M_PI_2, 0, 1, 0);
     
     //初始的位置是被折叠起来的，也就是上面的contaTran变换是沿着右侧翻转过去，但是我们需要翻转之后的位置是贴着屏幕左侧，于是需要一个位移
     CATransform3D contaTran2 = CATransform3DMakeTranslation(-self.frame.size.width, 0, 0);
     //两个变换的叠加
     _containView.layer.transform = CATransform3DConcat(contaTran, contaTran2);
     */
    
    //  沿着sidebar区域的右侧翻转比较简单，设置layer的anchorPoint为(1,0.5)即可。
    _containView.layer.anchorPoint = CGPointMake(1, 0.5);
    CATransform3D contaTRan = CATransform3DRotate(tran, -M_PI/2, 0, 1, 0);////(后面3个 数字分别代表不同的轴来翻转，本处为y轴)-CGFloat(Double.pi/Double(2))控制反转方向
    //CATransform3DMakeTranslation实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位,在z轴方向上平移z单位
    CATransform3D contaTran2 = CATransform3DMakeTranslation(-_sideMenu.width, 0, 0);
    //连结两个变换
    _containView.layer.transform = CATransform3DConcat(contaTRan, contaTran2);
    _containHelperView.layer.anchorPoint = CGPointMake(1, 0.5);
    _containHelperView.layer.transform = contaTRan;
}

-(CATransform3D)getTran {
    CATransform3D tran = CATransform3DIdentity;
    tran.m34 = -1/500.0;
    return tran;
}


-(void)intialSideMenu{
    
    
    _containView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, _sideMenu.frame.size.width, _sideMenu.height)];
    _containHelperView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, _sideMenu.frame.size.width, _sideMenu.height)];
    [_sideMenu addSubview: _containView];
    _containView.backgroundColor = [UIColor orangeColor];
    
    _gradLayer = [[CAGradientLayer alloc] init];
    _gradLayer.frame = _containView.bounds;
    _gradLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor];
    _gradLayer.startPoint = CGPointMake(0, 0.5);
    _gradLayer.endPoint = CGPointMake(1, 0.5);
    _gradLayer.locations = @[@(0.2),@(1)];
    [_containView.layer addSublayer:_gradLayer];
    _sideMenu.backgroundColor = [UIColor blackColor];
    
    
}


-(void)intialSideMenuUI{
    
    UILabel * titleLable = [self createLabel];
    titleLable.frame = CGRectMake(0, 0, _containView.width, kNavigationHeight);
    titleLable.text = @"题目";
    titleLable.backgroundColor = [UIColor greenColor];
    [_containView addSubview: titleLable];
    [titleLable addLineWithSide: LineViewSideInBottom lineColor: [UIColor blackColor] lineHeight: 0.5 leftMargin:0 rightMargin:0];
    
    UILabel * listLable = [self createLabel];
    listLable.frame = CGRectMake(0, kNavigationHeight, _containView.width, 64);
    listLable.text = @"内容一";
    [_containView addSubview: listLable];
    
    UIButton * button = [UIButton new];
    button.frame  = CGRectMake(0, kNavigationHeight + 64, _containView.width, 35);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
     [_containView addSubview: button];
    
    [self initialTrans];
    
    
    
    
}


-(void)back {
    if (self.backBlock != nil) {
        self.backBlock();
    }
}

-(UIImage * )getPathImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(32, 32), false, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, [self getPath].CGPath);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 3);
    CGContextStrokePath(context);
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
    
}

-(UIBezierPath *)getPath{
    UIBezierPath * path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(4, 4)];
    [path addLineToPoint:CGPointMake(24, 4)];
    
    [path moveToPoint: CGPointMake(4, 11)];
    [path addLineToPoint:CGPointMake(24, 11)];
    
    [path moveToPoint: CGPointMake(4, 18)];
    [path addLineToPoint:CGPointMake(24, 18)];
    
    return path;
}


-(UILabel *)createLabel {
    UILabel * label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    return  label;
}

-(void)openMenu {
    if (_ifOpen) {
        [self close];
    }else {
        [self open];
    }
}

-(void)close {
    _ifOpen = false;
    self.gradLayer.colors =@[(id)[UIColor clearColor].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor];
    [UIView animateWithDuration:0.5 delay:0 options:3 << 10 animations:^{
        self.menuButton.transform = CGAffineTransformIdentity;
        self.backGroudView.layer.transform = CATransform3DIdentity;
        [self initialTrans];
    } completion:^(BOOL finished) {

    }];
}

-(void)open {
    CATransform3D tran = [self getTran];
    _ifOpen = true;
    
    [UIView animateWithDuration:0.5 delay:0 options:3 << 10 animations:^{
        self.menuButton.transform = CGAffineTransformMakeRotation(M_PI/2);

    } completion:^(BOOL finished) {
        self.gradLayer.colors =@[(id)[UIColor clearColor].CGColor,(id)[UIColor clearColor].CGColor];
    }];
    
    CABasicAnimation *tranAni2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    tranAni2.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    tranAni2.fromValue = [NSValue valueWithCATransform3D: _backGroudView.layer.transform];
    tranAni2.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeTranslation(100, 0, 0)];
    tranAni2.duration = 0.5;
    [_backGroudView.layer addAnimation:tranAni2 forKey:@"openForContainerAni"];
    _backGroudView.layer.transform = CATransform3DMakeTranslation(100, 0, 0);
    
    
    CABasicAnimation *tranAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    tranAni.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    tranAni.fromValue = [NSValue valueWithCATransform3D: _containView.layer.transform];
    tranAni.toValue = [NSValue valueWithCATransform3D: tran];
    tranAni.duration = 0.5;
    [_containView.layer addAnimation:tranAni forKey:@"openForContainerAni"];
    _containView.layer.transform = tran;
    _containHelperView.layer.transform = tran;
    
    
}
@end
