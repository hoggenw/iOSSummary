//
//  ReponderTestViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/14.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ReponderTestViewController.h"
#import "CustomResonderTestButton.h"
#import "CircleButton.h"

@interface ReponderTestViewController ()

@end

@implementation ReponderTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button1 = [self creatNormalButtonWithName:@"扩大范围"];
    button1.frame =CGRectMake(40, kNavigationHeight + 40, 80, 40);
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button2 = [self creatNormalButtonWithName:@"圆圈"];
    button2.frame =CGRectMake(40, kNavigationHeight + 140, 60, 60);
    button2.layer.cornerRadius = 30;
    button2.clipsToBounds = true;
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

-(void)button1Action {
    NSLog(@"扩大范围");
    [YLHintView showMessageOnThisPage:@"扩大范围"];
}

-(void)button2Action {
    NSLog(@"圆圈");
    NSDictionary * dic = @{@"name":@"圆圈点击事件"};
    [self routerEventWithName:@"circlehit" userInfo:dic];
    //[YLHintView showMessageOnThisPage:@"圆圈"];
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


-(UIButton *)creatCircleButtonWithName:(NSString *)name{
    
    CircleButton * button = [CircleButton new];
    [self.view addSubview: button];
    button.titleLabel.textColor = [UIColor blackColor];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState: UIControlStateNormal];
    [button setTitle: name forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    return button;
    
}


-(void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"circlehit"]) {
        [YLHintView showMessageOnThisPage:[NSString stringWithFormat:@"controller收到button点击事件参数为：%@",userInfo[@"name"]]];
    }
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
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
