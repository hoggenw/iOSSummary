//
//  YLWebViewController.m
//  Vote
//
//  Created by 王留根 on 2018/6/26.
//  Copyright © 2018年 OwnersVote. All rights reserved.
//

#import "YLWebViewController.h"
#import "YLWKWebView.h"

@interface YLWebViewController ()<WKNavigationDelegate>

@end

@implementation YLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //下一个页面返回按钮去掉文字
    
    YLWKWebView *webView = [[YLWKWebView alloc]initWithFrame:CGRectMake(0,kNavigationHeight , ScreenWidth, ScreenHeight - kNavigationHeight)];
    webView.backgroundColor = [UIColor clearColor];
    webView.progressCorlor = [UIColor greenColor];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    
    //在iOS开发中，特别是在对Web服务调用的时候，经常会遇到请求参数为中文的情况，那么这时候就需要将Url转成UTF-8编码才能进行请求。
    //显示用户须知
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    [webView loadRequest:request];
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
