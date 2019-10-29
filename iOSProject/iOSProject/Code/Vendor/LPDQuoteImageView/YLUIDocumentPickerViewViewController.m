//
//  YLUIDocumentPickerViewViewController.m
//  AFNetworking
//
//  Created by 王留根 on 2018/6/26.
//

#import "YLUIDocumentPickerViewViewController.h"


@interface YLUIDocumentPickerViewViewController ()

@end

@implementation YLUIDocumentPickerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle: @"取消" forState:UIControlStateNormal];
    [button setTitleColor: [UIColor greenColor] forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 16];
    button.enabled = true;
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 22 , 60, 40);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction {
    [self dismissViewControllerAnimated: true completion: nil];
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
