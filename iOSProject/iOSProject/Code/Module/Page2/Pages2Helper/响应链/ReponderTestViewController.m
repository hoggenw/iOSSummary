//
//  ReponderTestViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/14.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ReponderTestViewController.h"
#import "CustomResonderTestButton.h"
@interface ReponderTestViewController ()

@end

@implementation ReponderTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button1 = [self creatNormalButtonWithName:@"扩大范围"];
    button1.frame =CGRectMake(40, kNavigationHeight + 40, 80, 40);
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)button1Action {
    NSLog(@"扩大范围");
}

-(UIButton *)creatNormalButtonWithName:(NSString *)name{
    
    CustomResonderTestButton * button = [CustomResonderTestButton new];
    [self.view addSubview: button];
    button.titleLabel.textColor = [UIColor blackColor];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState: UIControlStateNormal];
    [button setTitle: name forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    return button;
    
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
