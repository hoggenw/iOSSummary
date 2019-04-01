//
//  GradientProgressView.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/14.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "GradientProgressView.h"


@interface GradientProgressView ()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer * maskLayer;

@end


@implementation GradientProgressView

- (instancetype)initWithFrame:(CGRect )frame
{
    if ([super initWithFrame:frame])
    {
        CAGradientLayer * layer = (CAGradientLayer *)[self layer];
        [layer setStartPoint:CGPointMake(0.0, 0.5)];
        [layer setEndPoint:CGPointMake(1.0, 0.5)];
        
        NSMutableArray *colors = [NSMutableArray array];
        for (NSInteger hue = 0; hue <= 360; hue += 5)
        {
            UIColor * color = [UIColor colorWithHue:1.0 * hue / 360
                                         saturation:1.0
                                         brightness:1.0
                                              alpha:1.0];
            [colors addObject:(id)[color CGColor]];
        }
        [layer setColors:[NSArray arrayWithArray:colors]];
        
        
        self.maskLayer = [CALayer layer];
        [self.maskLayer setFrame:CGRectMake(0.0, 0.0, 0.0, frame.size.height)];
        [self.maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        [layer setMask:self.maskLayer];
        
        
        //Start the animation
        [self performAnimation];
        
    }
    return self;
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}


- (void)performAnimation
{
    CAGradientLayer * layer = (CAGradientLayer *)[self layer];
    NSMutableArray * colorArray = [[layer colors] mutableCopy];
    UIColor * lastColor = [colorArray lastObject];
    [colorArray removeLastObject];
    [colorArray insertObject:lastColor atIndex:0];
    NSArray * shiftedColors = [NSArray arrayWithArray:colorArray];
    
    [layer setColors:shiftedColors];
    NSLog(@"colorArray count %@",@(colorArray.count));
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.08];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    
    if (self.progress >= 1.0) {
        [self setHidden: true];
    }else if (self.progress <= 0){
       [self setHidden: false];
    }else{
         [self performAnimation];
    }
}


-(void)setProgress:(CGFloat)progress {
    NSLog(@"更新内容： %@",@(progress));
    if (_progress != progress)
    {
        _progress = MIN(1.0, fabs(progress));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    CGRect maskRect = [self.maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * self.progress;
    NSLog(@"frame:%@",NSStringFromCGRect( maskRect));
    [self.maskLayer setFrame:maskRect];
    
}




@end
