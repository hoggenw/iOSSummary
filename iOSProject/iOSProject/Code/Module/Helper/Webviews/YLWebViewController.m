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
#import "YLGradientWKWebview.h"

@interface YLWebViewController ()<ActionSelcetControlDelegate,WKNavigationDelegate,UIWebViewDelegate>
@property (nonatomic, strong) YLSliderSelectView * selectView;
@property (nonatomic, assign) int  webType;
@property (nonatomic, strong) YLWKWebView *wkWebView;
@property (nonatomic, strong) YLGradientWKWebview *uiWebView;

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
    NSArray <NSString *> * titles = @[@"GradientWKWebview", @"YLWKWebview"];
    [self.view addSubview: self.selectView];
    self.selectView.delegate = self;
    self.selectView.titles = titles;
    [self.selectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.equalTo(@(50));
    }];
    self.webType = 0;
    
    _wkWebView = [[YLWKWebView alloc]initWithFrame:CGRectMake(0,kNavigationHeight , ScreenWidth, ScreenHeight - kNavigationHeight - 50)];
    _wkWebView.backgroundColor = [UIColor clearColor];
    _wkWebView.progressCorlor = [UIColor greenColor];
    _wkWebView.navigationDelegate = self;
    [self.view addSubview:_wkWebView];
    
    
    _uiWebView =  [[YLGradientWKWebview alloc] initWithFrame:CGRectMake(0,kNavigationHeight , ScreenWidth, ScreenHeight - kNavigationHeight - 50)];//[[YLUIWebView alloc]initWithFrame:CGRectMake()];
    _uiWebView.backgroundColor = [UIColor clearColor];
    _uiWebView.navigationDelegate = self;
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
        self.url = @"https://www.baidu.com/";
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
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    webView.
//    webView.evaluateJavaScript(, completionHandler: nil);
    [webView evaluateJavaScript:@"javascript:(function(){var styleElem=null,doc=document,ie=doc.all,fontColor=50,sel='body,body *';styleElem=createCSS(sel,setStyle(fontColor),styleElem);function setStyle(fontColor){var colorArr=[fontColor,fontColor,fontColor];return'background-color:#000 !important;color:RGB('+colorArr.join('%,')+'%) !important;'};function createCSS(sel,decl,styleElem){var doc=document,h=doc.getElementsByTagName('head')[0],styleElem=styleElem;if(!styleElem){s=doc.createElement('style');s.setAttribute('type','text/css');styleElem=ie?doc.styleSheets[doc.styleSheets.length-1]:h.appendChild(s)};if(ie){styleElem.addRule(sel,decl)}else{styleElem.innerHTML='';styleElem.appendChild(doc.createTextNode(sel+' {'+decl+'}'))};return styleElem}})();" completionHandler:^(id _Nullable rest, NSError * _Nullable error) {
        
    }];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}


@end
