//
//  YLGradientWKWebview.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/14.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "YLGradientWKWebview.h"
#import "GradientProgressView.h"


@interface YLGradientWKWebview()

@property (nonatomic, strong) CAShapeLayer * progressLayer;
@property (nonatomic, strong) GradientProgressView * progressView;
@property (nonatomic, assign) float oldValue;


@end


@implementation YLGradientWKWebview

-(void)dealloc {
    @try {
        [self removeObserver:self forKeyPath: @"estimatedProgress"];
    }
    @catch (NSException *exception) {
    }
    
    
    
    
}

- (instancetype)init {
    if (self = [super init]) {
        _progressView = [[GradientProgressView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 4.0)];
        [self addSubview:_progressView];

    }
    return self;
}




-(WKNavigation *)loadRequest:(NSURLRequest *)request {
    self.oldValue = 0;
    [self update: 0];
    [self addObserver: self forKeyPath: @"estimatedProgress" options: NSKeyValueObservingOptionNew context:nil];
    return  [super loadRequest: request];
}

- (void)update:(CGFloat) progress {
    NSLog(@"更新内容： %@",@(progress));
    _progressView.progress = progress;
    
}

-(void)layoutSubviews {
    [super layoutSubviews];

}




-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (keyPath != nil && change != nil) {
        if ([keyPath isEqualToString: @"estimatedProgress"]) {
            NSNumber *newValue = change[NSKeyValueChangeNewKey];
            if (newValue.floatValue < self.oldValue) {
                return;
            }
            self.oldValue = newValue.floatValue;
            [self update: newValue.floatValue];
            if (newValue.intValue == 1) {
                self.oldValue = 0;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self update: 0];
                });
            }
            
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
