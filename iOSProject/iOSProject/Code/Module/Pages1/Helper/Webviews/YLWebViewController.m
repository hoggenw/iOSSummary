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
    if (self.webType == 0) {
        [self.wkWebView setHidden: true];
    }else{
        [self.uiWebView setHidden: true];
    }
    
}


-(YLWKWebView *)wkWebView {
    if (_wkWebView == nil) {
        _wkWebView = [[YLWKWebView alloc]initWithFrame:CGRectMake(0,kNavigationHeight , ScreenWidth, ScreenHeight - kNavigationHeight - 50)];
        _wkWebView.backgroundColor = [UIColor clearColor];
        _wkWebView.progressCorlor = [UIColor greenColor];
        _wkWebView.navigationDelegate = self;
        [self.view addSubview:_wkWebView];
    }
    return  _wkWebView;
}

-(YLGradientWKWebview *)uiWebView {
    if (_uiWebView == nil) {
        _uiWebView =  [[YLGradientWKWebview alloc] initWithFrame:CGRectMake(0,kNavigationHeight , ScreenWidth, ScreenHeight - kNavigationHeight - 50)];//[[YLUIWebView alloc]initWithFrame:CGRectMake()];
        _uiWebView.backgroundColor = [UIColor clearColor];
        _uiWebView.navigationDelegate = self;
        [self.view addSubview:_uiWebView];
    }
    return _uiWebView;
}

#pragma mark - Extension Delegate or Protocol
#pragma mark 选择器代理
-(void)buttonAction:(NSInteger)index {
    //在iOS开发中，特别是在对Web服务调用的时候，经常会遇到请求参数为中文的情况，那么这时候就需要将Url转成UTF-8编码才能进行请求。
    //显示用户须知
  
    NSLog(@"index = %@",@(index));
    if (index == 200)//UIwebview
    {
        self.url = @"http://hainan.jkscw.com.cn/";
        [self.wkWebView setHidden: true];
        [self.uiWebView setHidden: false];
          NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        [self.uiWebView loadRequest:request];
    }
    else if (index == 201)//Wkwebview
    {
        self.url = @"http://customer-h5.hlwyyrc.schlwyy.com/";
        [self.wkWebView setHidden: false];
        [self.uiWebView setHidden: true];
          NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
         [self.wkWebView loadRequest:request];
        
    }
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
       // 拦截的url字符串
    NSString *urlString = navigationAction.request.URL.absoluteString;
    
    urlString = [urlString stringByRemovingPercentEncoding];
   if (!navigationAction.request.allHTTPHeaderFields[@"Referer"]) {
               NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:navigationAction.request.URL];
               [request setValue:@"hainan.jkscw.com.cn://" forHTTPHeaderField:@"Referer"];
               [webView loadRequest:request];
           }
    // 判断是否为支付链接，可能会加载多个链接，只有包含"weixin://wap/pay?"才是可以跳转微信APP的链接，注意应用间跳转关键的scheme："weixin://"
      if([urlString containsString:@"weixin://wap/pay?"]) {
           NSLog(@"跳转连接%@",urlString);
          //weixin://wap/pay?prepayid=wx171536115627695aa95851111821435800&package=4062882817&noncestr=1584430571&sign=79e05fad31c99309ffff60a7836e0b49
          actionPolicy = WKNavigationActionPolicyCancel; // 不允许webView加载

          // 判断是否安装微信
          if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
              UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"未检测到微信客户端，请安装后重试" preferredStyle:UIAlertControllerStyleAlert];
              UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  [self.navigationController popViewControllerAnimated:YES];
              }];
              [alertVC addAction:sureAction];
              [self presentViewController:alertVC animated:YES completion:nil];
              
              decisionHandler(actionPolicy);
              return;
          }
          // 设置webView的头部参数Referer
        
          NSURL * newUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&redirect_url=hainan.jkscw.com.cn://",urlString]];
          // 跳转微信进行支付
          if (@available(iOS 10.0, *)) { // 10.0以上的版本
              if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                  [[UIApplication sharedApplication] openURL:newUrl options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:nil];
              }
          } else { // 10.0以下的版本
              if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:)]) {
                  [[UIApplication sharedApplication] openURL:newUrl];
              }
          }
      }
      // 必须加的一行代码，不然会Crash
      decisionHandler(actionPolicy);
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    return  true;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    webView.
//    webView.evaluateJavaScript(, completionHandler: nil);
//    [webView evaluateJavaScript:@"javascript:(function(){var styleElem=null,doc=document,ie=doc.all,fontColor=50,sel='body,body *';styleElem=createCSS(sel,setStyle(fontColor),styleElem);function setStyle(fontColor){var colorArr=[fontColor,fontColor,fontColor];return'background-color:#000 !important;color:RGB('+colorArr.join('%,')+'%) !important;'};function createCSS(sel,decl,styleElem){var doc=document,h=doc.getElementsByTagName('head')[0],styleElem=styleElem;if(!styleElem){s=doc.createElement('style');s.setAttribute('type','text/css');styleElem=ie?doc.styleSheets[doc.styleSheets.length-1]:h.appendChild(s)};if(ie){styleElem.addRule(sel,decl)}else{styleElem.innerHTML='';styleElem.appendChild(doc.createTextNode(sel+' {'+decl+'}'))};return styleElem}})();" completionHandler:^(id _Nullable rest, NSError * _Nullable error) {
//
//    }];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}


@end
