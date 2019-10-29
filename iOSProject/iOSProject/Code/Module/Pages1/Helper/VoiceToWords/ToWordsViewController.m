//
//  ToWordsViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/1/8.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import "ToWordsViewController.h"
#import <iflyMSC/IFlySpeechRecognizer.h>
#import <iflyMSC/IFlySpeechUtility.h>
#import <iflyMSC/IFlySpeechConstant.h>

@interface ToWordsViewController ()<IFlySpeechRecognizerDelegate>
@property (nonatomic, strong)IFlySpeechRecognizer *recog;
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, copy) NSString * textString;
@property (nonatomic, assign)BOOL endRecord;


@end

@implementation ToWordsViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self config];
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events
-(void)startButtonAction:(UIButton *)sender {
    [self.recog startListening];
}

-(void)endButtonAction:(UIButton *)sender {
    [self.recog stopListening];
}


#pragma mark - Private Methods
- (void)config {
    [IFlySpeechUtility createUtility:[[NSString alloc] initWithFormat:@"appid=%@,",USER_APPID]];
    self.recog = [IFlySpeechRecognizer sharedInstance];
    [self.recog setParameter:@"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    [self.recog setParameter:@"16000" forKey: [IFlySpeechConstant SAMPLE_RATE]];
    [self.recog setParameter:@"plain" forKey: [IFlySpeechConstant RESULT_TYPE]];
    self.recog.delegate = self;
    self.endRecord = false;
}
-(void)initUI {
    
    UIButton * startButton = [UIButton new];
    [startButton setTitle:@"开始识别" forState: UIControlStateNormal];
    startButton.tag = 200;
    [startButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    startButton.titleLabel.textColor = [UIColor blackColor];
    startButton.frame = CGRectMake(20, kNavigationHeight + 10, 100, 45);
    [self.view addSubview:startButton];
    [startButton addTarget: self action: @selector(startButtonAction:) forControlEvents: UIControlEventTouchUpInside];
    
    
    
    UIButton * endButton = [UIButton new];
    [endButton setTitle:@"结束识别" forState: UIControlStateNormal];
    endButton.tag = 200;
    [endButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    endButton.titleLabel.textColor = [UIColor blackColor];
    endButton.frame = CGRectMake(ScreenWidth - 120, kNavigationHeight + 10, 100, 45);
    [self.view addSubview:endButton];
    [endButton addTarget: self action: @selector(endButtonAction:) forControlEvents: UIControlEventTouchUpInside];
    
    
    self.textView = [UITextView new];
    self.textView.frame = CGRectMake(0, kNavigationHeight + 55 , ScreenWidth, ScreenHeight -120);
    [self.view addSubview: self.textView];
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 0.5;
    self.textView.textColor = [UIColor blackColor];
    
    
}
#pragma mark - Extension Delegate or Protocol

#pragma mark - IFlySpeechRecognizerDelegate
- (void)onError:(IFlySpeechError *)errorCode {
    
}

-(void)onResults:(NSArray *)results isLast:(BOOL)isLast {
    NSString *resultStr = self.textView.text;
    if (results != nil && results.count >0) {
        NSDictionary * resultDictionary = results.firstObject;
        for (NSString * key  in  resultDictionary.allKeys) {
            resultStr = [resultStr stringByAppendingString: key];
        }
        self.textView.text = resultStr;
    }
    
}

- (void)onCancel {
    
}

- (void)onBeginOfSpeech{
    NSLog(@"=======开始录音===========");
}

- (void)onEndOfSpeech {
    NSLog(@"=======结束录音===========");
}

@end
