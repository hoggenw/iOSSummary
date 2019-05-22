//
//  CircleView.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/7.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "CircleView.h"



@interface CircleView ()
@property (nonatomic, strong) CAShapeLayer * circleLayer1;
@property (nonatomic, strong) CAGradientLayer *circleGradientLayer;
@property (nonatomic, strong) CAShapeLayer * arrows1 ;
@property (nonatomic, strong) UIBezierPath *arrow1StartPath;
@property (nonatomic, strong) UIBezierPath *arrow1EndPath;

@property (nonatomic, strong) CAShapeLayer * circleLayer2 ;
@property (nonatomic, strong) CAShapeLayer * arrows2Layer ;
@property (nonatomic, strong) UIBezierPath *arrow2StartPath;
@property (nonatomic, strong) UIBezierPath *arrow2EndPath;

@property (nonatomic, strong) CABasicAnimation *baseAnimation1;// = CABasicAnimation(keyPath: "transform.rotation.z");
@property (nonatomic, strong) CABasicAnimation *baseAnimation2;// = CABasicAnimation(keyPath: "transform.rotation.z");

@property (nonatomic, strong) CAKeyframeAnimation* keyAnimation2;// = CAKeyframeAnimation(keyPath: "path");
@property (nonatomic, strong) CAKeyframeAnimation* keyAnimation1;// = CAKeyframeAnimation(keyPath: "path");

@property (nonatomic, strong) UIView *circle2View;// UIView = UIView()

@property (nonatomic, strong)  NSTimer * progressTimer;


@end

@implementation CircleView



-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.circle2View.frame = self.bounds;
        self.circle2View.backgroundColor = [UIColor clearColor];
        [self addSubview: self.circle2View];
        self.backgroundColor = [UIColor clearColor];
        
        self.circleLayer1 = [CAShapeLayer new];
        self.circleLayer1.frame = self.bounds;
        self.circleLayer1.borderWidth = 1;
        self.circleLayer1.lineWidth = 3;
        self.circleLayer1.fillColor = [UIColor clearColor].CGColor;
        self.circleLayer1.lineCap = kCALineCapRound;
        
        
        self.arrows1 = [CAShapeLayer new];
        self.arrows1.frame = self.bounds;
        self.arrows1.borderWidth = 1;
        self.arrows1.lineWidth = 3;
        self.arrows1.fillColor = [UIColor clearColor].CGColor;
        self.arrows1.lineCap = kCALineCapRound;
        
        
        
        self.circleLayer2 = [CAShapeLayer new];
        self.circleLayer2.frame = self.bounds;
        self.circleLayer2.borderWidth = 1;
        self.circleLayer2.lineWidth = 3;
        self.circleLayer2.fillColor = [UIColor clearColor].CGColor;
        self.circleLayer2.lineCap = kCALineCapRound;
        
        
        self.arrows2Layer = [CAShapeLayer new];
        self.arrows2Layer.frame = self.bounds;
        self.arrows2Layer.borderWidth = 1;
        self.arrows2Layer.lineWidth = 3;
        self.arrows2Layer.fillColor = [UIColor clearColor].CGColor;
        self.arrows2Layer.lineCap = kCALineCapRound;
        
        [self tintColorDidChange];
        [self.layer addSublayer:self.circleLayer1];
        [self.circleLayer1 addSublayer:self.arrows1];
        [self.circle2View.layer addSublayer:self.circleLayer2];
        [self.circleLayer2 addSublayer:self.arrows2Layer];
        

        
        self.baseAnimation1 = [self installAnimation];
        
        self.baseAnimation2 = [self installAnimation];
        
         NSLog(@"开始动画 %@===%@",@(_baseAnimation1.duration),@(_baseAnimation2.duration));
    }
    
    return self;
}


-(void)tintColorDidChange{
    [super tintColorDidChange];
    
    self.circleLayer1.strokeColor = [UIColor greenColor].CGColor;
    self.circleLayer1.borderColor = [UIColor clearColor].CGColor;
    
    self.arrows1.strokeColor = [UIColor greenColor].CGColor;
    self.arrows1.borderColor = [UIColor clearColor].CGColor;
    
    self.circleLayer2.strokeColor = [UIColor redColor].CGColor;
    self.circleLayer2.borderColor = [UIColor clearColor].CGColor;
    
    self.arrows2Layer.strokeColor = [UIColor redColor].CGColor;
    self.arrows2Layer.borderColor = [UIColor clearColor].CGColor;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    self.circleLayer1.cornerRadius = self.frame.size.width / 2.0;
    self.circleLayer1.path = [self circleLayer1Path].CGPath;
    
    self.circleLayer2.cornerRadius = self.frame.size.width / 2.0;
    self.circleLayer2.path = [self circleLayer2Path].CGPath;
}


-(UIBezierPath *)circleLayer1Path {
    CGFloat startAngle = M_PI ;
    CGFloat endAngle = startAngle + M_PI * 0.8;
    
    float width = self.frame.size.width;
    float borderWidth = self.circleLayer1.borderWidth;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 - borderWidth startAngle:startAngle endAngle:endAngle clockwise:true];
    
                           path.lineWidth     = borderWidth;
                           path.lineJoinStyle =  kCGLineJoinRound;//终点处理
    
    CGFloat pointX = 0 ;
    CGFloat pointY = 0 + self.frame.size.height/2;
    CGPoint originPoint = CGPointMake( pointX + 0.5,  pointY + 0.5 );
    CGPoint leftPonit = CGPointMake( pointX - 8,  pointY - 10);
    CGPoint rightPoint = CGPointMake( pointX + 12,  pointY - 8);
    
    self.arrow1StartPath = [UIBezierPath new];
    [self.arrow1StartPath moveToPoint: leftPonit];
    [self.arrow1StartPath addLineToPoint: originPoint];
    [self.arrow1StartPath addLineToPoint: rightPoint];
    self.arrow1StartPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    
    CGPoint leftUpPonit = CGPointMake(pointX - 2,  pointY - 12 );
    CGPoint rightUPPoint = CGPointMake( pointX + 6,  pointY - 10);
    
    self.arrow1EndPath = [UIBezierPath new];
    [self.arrow1EndPath moveToPoint: leftUpPonit];
    [self.arrow1EndPath addLineToPoint: originPoint];
    [self.arrow1EndPath addLineToPoint: rightUPPoint];
    self.arrow1EndPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    self.arrows1.path = self.arrow1StartPath.CGPath;
    
    return path;
}


-(UIBezierPath *)circleLayer2Path {
    CGFloat startAngle = 0 ;
    CGFloat endAngle = startAngle + M_PI * 0.85;
    
    float width = self.frame.size.width;
    float borderWidth = self.circleLayer1.borderWidth;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, width/2) radius:width/2 - borderWidth startAngle:startAngle endAngle:endAngle clockwise:true];
    
    path.lineWidth     = borderWidth;
    path.lineJoinStyle =  kCGLineJoinRound;//终点处理
    
    CGFloat pointX = 0 + self.frame.size.width ;
    CGFloat pointY = 0 + self.frame.size.height/2;
    CGPoint originPoint = CGPointMake( pointX - 0.5,  pointY - 0.5 );
    CGPoint leftPonit = CGPointMake( pointX - 12,  pointY + 8);
    CGPoint rightPoint = CGPointMake( pointX + 8,  pointY + 10 );
    
    self.arrow2StartPath = [UIBezierPath new];
    [self.arrow2StartPath moveToPoint: leftPonit];
    [self.arrow2StartPath addLineToPoint: originPoint];
    [self.arrow2StartPath addLineToPoint: rightPoint];
    self.arrow2StartPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    
    CGPoint leftUpPonit = CGPointMake(pointX - 14,  pointY - 14 );
    CGPoint rightUPPoint = CGPointMake( pointX + 6.6,  pointY - 16);
    
    self.arrow2EndPath = [UIBezierPath new];
    [self.arrow2EndPath moveToPoint: leftUpPonit];
    [self.arrow2EndPath addLineToPoint: originPoint];
    [self.arrow2EndPath addLineToPoint: rightUPPoint];
    self.arrow2EndPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    self.arrows2Layer.path = self.arrow2StartPath.CGPath;
    
    return path;
}


-(void)beginAnimation{

    self.baseAnimation1.beginTime = CACurrentMediaTime() + 0.1;
   
    NSLog(@"开始动画 %@===%@",@(self.baseAnimation1.duration),@(self.baseAnimation2.duration));
    NSArray * values2 = @[ (id)self.arrow2StartPath.CGPath,(id)self.arrow2EndPath.CGPath,(id)self.arrow2StartPath.CGPath,(id)self.arrow2EndPath.CGPath,(id)self.arrow2StartPath.CGPath];
    
    [self installKeyframeAnimation:self.keyAnimation2 values:values2 duration:2.5];
    
    NSArray * values1 = @[(id)self.arrow1StartPath.CGPath,(id)self.arrow1EndPath.CGPath,(id)self.arrow1StartPath.CGPath,(id)self.arrow1EndPath.CGPath,(id)self.arrow1StartPath.CGPath];
    [self installKeyframeAnimation:self.keyAnimation1 values:values1 duration:2.5];
    [self.circleLayer1 addAnimation: self.baseAnimation1 forKey:@"baseanimation1"];
    [self.circleLayer2 addAnimation: self.baseAnimation2 forKey: @"baseanimation2"];
    [self.arrows2Layer addAnimation: self.keyAnimation2 forKey: @"keyAnimation2"];
    [self.arrows1 addAnimation: self.keyAnimation1 forKey: @"keyAnimation1"];
    
}
-(CABasicAnimation *)installAnimation{

    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [baseAnimation setFromValue: [NSNumber numberWithFloat:  M_PI * 2 ]];
    baseAnimation.toValue = 0;
    baseAnimation.duration = 2.5;
    baseAnimation.repeatCount = HUGE;
    //kCAMediaTimingFunctionEaseInEaseOut 使用该值，动画在开始和结束时速度较慢，中间时间段内速度较快。
    baseAnimation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]; //CAMediaTimingFunction(name:  kCAMediaTimingFunctionEaseOut);
    return  baseAnimation;
}
-(void)installKeyframeAnimation:(CAKeyframeAnimation *)keyAnimation values:(NSArray *)values duration:(CFTimeInterval)duration {
    keyAnimation.values = values;
    keyAnimation.keyTimes = @[@0.1,@0.2,@0.3,@0.4,@0.5];
    keyAnimation.autoreverses = false;
    keyAnimation.repeatCount = HUGE;
    keyAnimation.duration = duration;
}



-(CAKeyframeAnimation *)keyAnimation2 {
    if (_keyAnimation2 == nil) {
        _keyAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    }
    return _keyAnimation2;
}

-(CAKeyframeAnimation *)keyAnimation1 {
    if (_keyAnimation1 == nil) {
        _keyAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    }
    return _keyAnimation1;
}

-(UIView *)circle2View {
    if (_circle2View == nil) {
        _circle2View = [UIView new];
    }
    return _circle2View;
}

@end
