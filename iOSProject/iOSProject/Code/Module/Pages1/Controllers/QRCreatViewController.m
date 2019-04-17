//
//  QRCreatViewController.m
//  iOSProject
//
//  Created by 王留根 on 2018/11/22.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import "QRCreatViewController.h"
#import "YLScanViewManager.h"

@interface QRCreatViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *codeView;
/** 生成二维码信息 输入框 */
@property (nonatomic, strong) UITextField * contentQRField;
@property (nonatomic, strong)UIButton * creatButton;

@end

@implementation QRCreatViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialUI];
    
    
}

-(void)initialUI {
    
    
    //波浪动画
     self.creatButton = [self creatNormalBUttonWithName:@"生成二维码" frame: CGRectMake(self.view.size.width/2 - 60 , self.view.size.height - 100, 120, 40)];
    [self.creatButton addTarget: self action:@selector(creatQRView) forControlEvents: UIControlEventTouchUpInside];
    // 1.电话 输入框
    UIView *phoneView = ({
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        [self setUpLineView:view leftTitle:@"二维码内容" bottomNeedLine:YES];
        UITextField *textField = nil;
        [self setUpRightInLineView:view rightField:&textField placeHolder:@"输入要生成二维码的内容" widthString:@"二维码内容"];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.bottom.equalTo(self.creatButton.mas_top).offset(-20);
            make.height.equalTo(@(40));
        }];
        self.contentQRField = textField;
        self.contentQRField.keyboardType = UIKeyboardTypeDefault;
        view;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events
-(void)creatQRView {
    [self.view endEditing: true];
    NSString * contentString;
    if (self.contentQRField.text.length > 0) {
        contentString = self.contentQRField.text;
    }else{
        contentString = @"wlg's test Message";
    }
    YLScanViewManager * manager = [YLScanViewManager sharedInstance];
    self.codeView = [manager produceQRcodeView:CGRectMake((self.view.bounds.size.width - 200)/2, kNavigationHeight + 60, 200, 200) logoIconName:@"device_scan" codeMessage:@"wlg's test Message"];
    [self.view addSubview:self.codeView ];
    
   
}

#pragma mark - Private Methods


- (void)setUpRightInLineView:(UIView *)lineView rightField:(UITextField **)rightField placeHolder:(NSString *)placeHolder widthString:(NSString *)titleString
{
    CGFloat leftViewW = [titleString sizeWithFont:[UIFont systemFontOfSize: 14] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineMargin:0].width;
    CGFloat leftMargin = 10 + leftViewW + 20;
    CGFloat rightMargin = 10;
    
    UITextField *textField = [[UITextField alloc] init];
    [lineView addSubview:textField];
    textField.placeholder = placeHolder;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor blackColor];
    textField.delegate = self;
    // 添加监听，设置长度限定
    //[textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView).offset(leftMargin);
        make.right.equalTo(lineView).offset(-rightMargin);
        make.top.and.bottom.equalTo(lineView);
    }];
    
    
    *rightField = textField;
}

- (void)setUpLineView:(UIView *)lineView leftTitle:(NSString *)leftTitle bottomNeedLine:(BOOL)bottomNeedLine
{
    CGFloat leftMargin = 10;
    
    // left Label
    UILabel *label = [[UILabel alloc] init];
    [lineView addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.text = leftTitle;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView).offset(leftMargin);
        make.centerY.equalTo(lineView);
        // 右侧使用
        //        CGFloat width = [@"区域选择" sizeWithFont:[[PSTheme sharedInstance] fontNormal] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineMargin:0].width;
        //        make.width.equalTo(@(width));
    }];
    
    // bottom Line
    if (bottomNeedLine) {
        lineView.layer.borderWidth = 0.5;
        lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        lineView.layer.cornerRadius = 2;
        lineView.clipsToBounds = true;
        UIView *lineView2 = [[UIView alloc] init];
        [lineView addSubview:lineView2];
        //TODO 这里的约束应修正为最原生的约束，实现完全独立，而不是依赖masonry
        lineView2.backgroundColor = [UIColor lightGrayColor];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(label.mas_right).offset(10);
            
            make.top.equalTo(lineView).offset(10);
            make.bottom.equalTo(lineView).offset(-10);
            make.width.equalTo(@(0.5));
            
        }];
        
    }
    
}

-(UIButton *)creatNormalBUttonWithName:(NSString *)name frame:(CGRect)frame {
    
    UIButton * button = [UIButton new];
    button.frame = frame;
    [self.view addSubview: button];
    button.titleLabel.textColor = [UIColor blackColor];
    [button setTitle: name forState: UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    button.layer.borderWidth = 0.5;
    button.layer.cornerRadius = 4;
    button.clipsToBounds = true;
    
    return button;
    
}

#pragma mark - Extension Delegate or Protocol
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField ==self.contentQRField) {
        if (self.codeView != nil) {
            [self.codeView removeFromSuperview];
            self.codeView = nil;
        }
      
    }
    return  true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField ==self.contentQRField) {
        [self.creatButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(self.view.size.height - 300);
             make.centerX.equalTo (self.view.mas_centerX);
            make.width.equalTo(@(120));
        }];
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (textField ==self.contentQRField) {
        [self.creatButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(self.view.size.height - 100);
            make.centerX.equalTo (self.view.mas_centerX);
            make.width.equalTo(@(120));
        }];
        
    }
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan: touches withEvent: event];
    //NSLog(@"点击");
    [self.view endEditing: true];
}
@end
