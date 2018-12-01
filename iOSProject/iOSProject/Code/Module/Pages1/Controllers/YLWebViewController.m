//
//  YLWebViewController.m
//  iOSProject
//
//  Created by 王留根 on 2018/11/26.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import "YLWebViewController.h"
#import "YLSliderSelectView.h"
#import "YLWKWebView.h"
#import "YLUIWebView.h"

@interface YLWebViewController ()<ActionSelcetControlDelegate,WKNavigationDelegate,UIWebViewDelegate>
@property (nonatomic, strong) YLSliderSelectView * selectView;
@property (nonatomic, assign) int  webType;
@property (nonatomic, strong) YLWKWebView *wkWebView;
@property (nonatomic, strong) YLUIWebView *uiWebView;

@end

@implementation YLWebViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods
-(void)initialUI {
    //选择
    self.selectView = [[YLSliderSelectView alloc] initWithFrame: CGRectZero ];
    self.selectView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    NSArray <NSString *> * titles = @[@"YLUIWebView", @"YLWKWebview"];
    [self.view addSubview: self.selectView];
    self.selectView.delegate = self;
    self.selectView.titles = titles;
    [self.selectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight);
        make.height.equalTo(@(50));
    }];
    self.webType = 0;
    
    _wkWebView = [[YLWKWebView alloc]initWithFrame:CGRectMake(0,kNavigationHeight+50 , ScreenWidth, ScreenHeight - kNavigationHeight)];
    _wkWebView.backgroundColor = [UIColor clearColor];
    _wkWebView.progressCorlor = [UIColor greenColor];
    _wkWebView.navigationDelegate = self;
    [self.view addSubview:_wkWebView];
    
    
    _uiWebView =  [[YLUIWebView alloc] initWithFrame:CGRectMake(0,kNavigationHeight+50 , ScreenWidth, ScreenHeight - kNavigationHeight)];//[[YLUIWebView alloc]initWithFrame:CGRectMake()];
    _uiWebView.backgroundColor = [UIColor clearColor];
    _uiWebView.progressCorlor = [UIColor greenColor];
    _uiWebView.delegate = self;
    [self.view addSubview:_uiWebView];
    if (self.webType == 0) {
        [_wkWebView setHidden: true];
    }else{
        [_uiWebView setHidden: true];
    }
    
}

#pragma mark - Extension Delegate or Protocol
#pragma mark 选择器代理
-(void)buttonAction:(NSInteger)index {
    //在iOS开发中，特别是在对Web服务调用的时候，经常会遇到请求参数为中文的情况，那么这时候就需要将Url转成UTF-8编码才能进行请求。
    //显示用户须知
  
  
    if (index == 200)//UIwebview
    {
        self.url = @"https://twitter.com/";
        [_wkWebView setHidden: true];
        [_uiWebView setHidden: false];
          NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        [_uiWebView loadRequest:request];
    }
    else if (index == 201)//Wkwebview
    {
        self.url = @"https://www.baidu.com/";
        [_wkWebView setHidden: false];
        [_uiWebView setHidden: true];
          NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
         [_wkWebView loadRequest:request];
        
    }
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    return  true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}


@end