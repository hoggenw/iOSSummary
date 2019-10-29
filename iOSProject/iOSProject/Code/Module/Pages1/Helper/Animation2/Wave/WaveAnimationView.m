//
//  WaveAnimationView.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/11.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "WaveAnimationView.h"


#define waveHight 8.0
#define waveHight2 5.0

@interface WaveAnimationView ()


@property (nonatomic, assign)CGFloat offset;
@property (nonatomic, assign)CGFloat offset2;
@property (nonatomic, assign)CGFloat speed;
@property (nonatomic, assign)CGFloat speed2;
@property (nonatomic, assign)CGFloat waveWidth;
@property (nonatomic, assign)CGFloat standerPonitY;
@property (nonatomic, strong)CADisplayLink * caLink;
@property (nonatomic, strong)CAShapeLayer *layerA;
@property (nonatomic, strong)CAShapeLayer *layerB;

@end

@implementation WaveAnimationView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _waveWidth = self.frame.size.width;
        _layerA = [CAShapeLayer new];
        _layerB = [CAShapeLayer new];
        _layerA.opacity = 0.5;
        _layerA.frame = self.bounds;
        _layerB.frame = self.bounds;
        _layerB.opacity = 0.5;
        _standerPonitY = self.frame.size.height/2;
        _speed = 3;
        _speed2 = 3;
        //waveHight = self.frame.size.height/5;
        [self.layer addSublayer: _layerA];
        [self.layer addSublayer:_layerB];
    }
    return  self;
}

-(void)doAnimation {
    //NSLog(@"sdsadasdas");
    
    _offset += _speed;
    _offset2 += _speed2;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGFloat startY = waveHight * sinf(_offset * M_PI / _waveWidth) + _standerPonitY;
    CGPathMoveToPoint(pathRef, NULL, 0.0, startY);
    int viewWidth = (int)_waveWidth;
    for(int i = 0; i < viewWidth; i ++){
        CGFloat Y = waveHight * sinf(M_PI*2.5/_waveWidth * i + _offset* M_PI/_waveWidth) + _standerPonitY;
        CGPathAddLineToPoint(pathRef, NULL, i, Y);
    }
    CGPathAddLineToPoint(pathRef, NULL, _waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, self.frame.size.height);
    CGPathCloseSubpath(pathRef);
    _layerA.path = pathRef;
    
    CGMutablePathRef pathRefB = CGPathCreateMutable();
    CGFloat startYB = waveHight2 * sinf(_offset2 * M_PI / _waveWidth + M_PI/4) + _standerPonitY;
    CGPathMoveToPoint(pathRefB, NULL, 0.0, startYB);
    for(int i = 0; i < viewWidth; i ++){
        CGFloat YB = waveHight2 * sinf(M_PI*4/_waveWidth * i + _offset2* M_PI/_waveWidth  +  M_PI/4) + _standerPonitY;
        CGPathAddLineToPoint(pathRefB, NULL, i, YB);
    }
    CGPathAddLineToPoint(pathRefB, NULL, _waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(pathRefB, NULL, 0, self.frame.size.height);
    CGPathCloseSubpath(pathRefB);
    _layerB.path = pathRefB;
    
    
}

-(void)animationBegin {
    if (_caLink == nil) {
        _caLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationAction)];
    }
    
    [_caLink addToRunLoop:[NSRunLoop currentRunLoop] forMode: NSRunLoopCommonModes];
}

-(void)animationStop {
    if (_caLink != nil) {
        [_caLink invalidate];
        _caLink = nil;
    }
    
}


-(void)animationAction {
    [self doAnimation];
}
@end
