//
//  Menu3DViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/3/11.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "Menu3DViewController.h"
#import "Menu3DView.h"

@interface Menu3DViewController ()

@end

@implementation Menu3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    Menu3DView * menuView = [[Menu3DView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview: menuView];
    menuView.backBlock = ^{
     [self.navigationController popViewControllerAnimated: true];
    };
    
//    UIButton * button = [UIButton new];
//    button.frame  = CGRectMake(0, 0, 60, 25);
//    
//    [button setTitle:@"返回" forState:UIControlStateNormal];
//    button.titleLabel.textAlignment = NSTextAlignmentRight;
//    button.titleLabel.font = [UIFont systemFontOfSize:13];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    [button addTarget: self action:@selector(rightButtonAction) forControlEvents: UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    // Do any additional setup after loading the view.
}

-(void)rightButtonAction {
    [self.navigationController popViewControllerAnimated: true];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
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
