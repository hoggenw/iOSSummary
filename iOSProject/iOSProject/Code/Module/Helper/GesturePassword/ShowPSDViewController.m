//
//  ShowPSDViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/2/28.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ShowPSDViewController.h"
#import "GesturePasswordView.h"

@interface ShowPSDViewController ()<GesturePasswordViewDelegate>
@property (nonatomic,strong)UIView *psdWordView;
//标记是否是重置密码
@property(nonatomic ,assign)BOOL resetPassword;

@property(nonatomic, strong)UILabel * titleLabel;


@end

@implementation ShowPSDViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events

-(void)resetButtonAction:(UIButton *)sender{
    self.titleLabel.text=@"确认旧手势密码";
    
    self.resetPassword=YES;
}


#pragma mark - Private Methods
-(void)InitUI{
    self.resetPassword = false;
    UILabel * titleLabel = [UILabel new];
    [self.view addSubview: titleLabel];
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xf3f3f3"];
    titleLabel.text = @"设置手势密码";
    titleLabel.font = [UIFont boldSystemFontOfSize: 15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(20 + kNavigationHeight);
        make.height.equalTo(@(21));
    }];
    self.titleLabel = titleLabel;
    
    
    UIButton * button =  [self creatNormalBUttonWithName:@"重新设置"];
    [button addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: button];
    
    
    self.psdWordView = [UIView new];
    self.psdWordView.backgroundColor = [UIColor colorWithHexString:@"0xf3f3f3"];
    [self.view addSubview: _psdWordView];
    [_psdWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(titleLabel.mas_bottom).offset(50);
        make.height.width.equalTo(@(300));
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.psdWordView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    
    GesturePasswordView  *lockView = [GesturePasswordView new];
    lockView.delegate = self;
    [self.psdWordView addSubview:lockView];
    [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.psdWordView);
    }];
    
}

-(UIButton *)creatNormalBUttonWithName:(NSString *)name {
    
    UIButton * button = [UIButton new];
    [self.view addSubview: button];
    button.titleLabel.textColor = [UIColor blueColor];
    [button setTitle: name forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
    
    return button;
    
}

#pragma mark - Extension Delegate or Protocol
//显示的的Toast
-(void)submitPsd:(NSString *)toast
{
    self.titleLabel.text = toast;
}


-(BOOL)GesturePasswordView:(GesturePasswordView *)gesturePasswordView withPassword:(NSString *)password
{
    
    NSString *Psd = [UserDefUtils getStringForKey:@"Psd"];//每次验证的密码
    
    if ([password isEqualToString:Psd]) {//做密码的验证,无论是改密码,还是二次确认密码都拿第一个“newPsd”做判断
        
        
        if (self.resetPassword) {//判断是否重新设置密码
            
            self.titleLabel.text=@"设置新密码";
            self.resetPassword=NO;
            [UserDefUtils saveString:nil forKey:@"Psd"];
            [UserDefUtils saveString:nil forKey:@"SavePsd"];
        }
        else{
            
            [self.navigationController popViewControllerAnimated: true];
        }
        
        
        
        return YES;
        
        
    }
    
    
    
    return NO;
    
    
    
}
@end
