//
//  YLUIWebView.m
//  iOSProject
//
//  Created by 王留根 on 2018/11/26.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import "YLUIWebView.h"

@interface YLUIWebView ()<UIWebViewDelegate>
@property (nonatomic, strong) CAShapeLayer * progressLayer;
@property (nonatomic, strong) UIView * progressView;
@property (nonatomic, assign) float oldValue;
@end

@implementation YLUIWebView

-(void)dealloc {
    
}


- (void)initProgressView {
    self.progressView = [UIView new];
    self.oldValue = 0;
    self.progressLayer = [[CAShapeLayer alloc] initWithLayer: self.progressView.layer];
    self.progressView.frame = CGRectMake(0, 64, self.bounds.size.width, 4);
    self.progressView.backgroundColor = [UIColor clearColor];
    
    [self addSubview: self.progressView];
    _progressLayer.borderWidth = 1;
    _progressLayer.lineWidth = 4;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];
    [self tintColorDidChange];
    [self.progressView.layer addSublayer: self.progressLayer];
    
}

-(void)tintColorDidChange {
    if ([self.superclass instancesRespondToSelector:@selector(tintColorDidChange)]) {
        [super tintColorDidChange];
    }
    _progressLayer.strokeColor = self.progressCorlor.CGColor;
    _progressLayer.borderColor = self.progressCorlor.CGColor;
    
}

- (void)loadRequest:(NSURLRequest *)request {
     //[self initProgressView];
     return  [super loadRequest: request];
}


- (void)update:(CGFloat) progress {
    [CATransaction begin];
    [CATransaction setValue: kCFBooleanTrue forKey: kCATransactionDisableActions];
    self.progressLayer.strokeEnd = progress;
    self.progressLayer.strokeStart = 0;
    [CATransaction commit];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.progressLayer.path = [self shapeLayerPath].CGPath;
}


- (UIBezierPath *)shapeLayerPath {
    CGFloat width = self.frame.size.width;
    CGFloat borderWidth = self.progressLayer.borderWidth;
    UIBezierPath * path = [UIBezierPath new];
    path.lineWidth = borderWidth;
    path.lineJoinStyle = kCGLineJoinRound;
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(width, 0)];
    return  path;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}




@end
