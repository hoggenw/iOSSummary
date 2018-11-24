//
//  RecordVideoViewController.m
//  UnitTestDemo
//
//  Created by 王留根 on 2018/7/30.
//  Copyright © 2018年 王留根. All rights reserved.
//

#import "RecordVideoViewController.h"
#import "YLRecordVideoView.h"



@interface RecordVideoViewController ()<YLRecordVideoControlDelegate>

@end

@implementation RecordVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //本方法穿件录制视图，然后才可以赋值
    YLRecordVideoView * recordView = [[YLRecordVideoView alloc] initWithFrame:self.view.bounds];
    recordView.videoQuality = NormalQuality;
    recordView.delegate = self;
    recordView.totalSeconds = 15;
    [self.view addSubview:recordView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)choiceVideoWith:(NSString *)path {
    NSLog(@"path: %@",path);
}

- (void)cancelRecordWith:(NSString *)path {
    [self.navigationController popViewControllerAnimated: true];
}


- (void)restartRecordDelegate {
    
}


- (void)startRecordDelegate {
    
}


- (void)stopRecordWith:(NSString *)path {
    
}


@end
