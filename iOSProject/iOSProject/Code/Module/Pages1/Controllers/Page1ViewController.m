//
//  Page1ViewController.m
//  iOSProject
//
//  Created by 王留根 on 2018/11/19.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import "Page1ViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"


@interface Page1ViewController ()<NormalActionWithInfoDelegate,YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;


@end

@implementation Page1ViewController

#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self initialUI];
    [self initialDataSource];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}


#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@"分享"];
    model.desc = [NSString stringWithFormat:@"点击进入分享"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    
    DefualtCellModel *model1 = [DefualtCellModel new];
    model1.title = [NSString stringWithFormat:@"分享"];
    model1.desc = [NSString stringWithFormat:@"点击进入分享"];
    model1.leadImageName = @"tabbar-icon-selected-1";
    model1.cellAccessoryType = UITableViewCellAccessoryNone;
    [self.dataArray addObject: model1];
    [self.tableView.dataArray addObject: model1];
    
    
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@"分享"];
    model2.desc = [NSString stringWithFormat:@"点击进入分享"];
    model2.leadImageName = @"";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    [self.tableView.dataArray addObject: model2];
    
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@""];
    model3.desc = [NSString stringWithFormat:@"点击进入分享"];
    model3.leadImageName = @"";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    [self.tableView.dataArray addObject: model3];
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@"分享"];
    model4.desc = [NSString stringWithFormat:@""];
    model4.leadImageName = @"";
    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model4];
    [self.tableView.dataArray addObject: model4];
    
    [self.tableView.tableView reloadData];
    
}
- (void)initialUI {
    UIButton * button = [UIButton new];
    button.frame  = CGRectMake(0, 0, 60, 25);
    
    [button setTitle:@"待定" forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setImage: [UIImage imageNamed:@"vote_screen_icon"] forState: UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget: self action:@selector(rightButtonAction) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [YLTableView new];
    self.tableView.cellType = Default;
    self.tableView.delegate = self;
    self.tableView.tableView.backgroundColor =  [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavigationHeight);
        make.left.right.bottom.equalTo(self.view);
        //        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    
    
    
    
}

-(void)sureButtonAction{
    
}



#pragma mark - Events
-(void)rightButtonAction{
    
}

#pragma mark - Public Methods

#pragma mark - Extension Delegate or Protocol



- (void)actionWithInfo:(id )obj {
    if ([obj isKindOfClass:[NSNumber class]] && ([(NSNumber *)obj integerValue] == 3)) {
        
    }
    if ([obj isKindOfClass:[NSDictionary class]] ) {
        
    }
}

#pragma mark - YLTableViewDelete

-(void)didselectedCell:(NSInteger)index {
    
    NSLog(@"%@",@(index));
    if (index == 0) {
        [YLUMengHelper shareTitle:@"HoggenProject" subTitle:@"for love" thumbImage:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542628890298&di=65ec554f0ecd05cd5062f7ed3ec04142&imgtype=0&src=http%3A%2F%2Fpic19.photophoto.cn%2F20110415%2F0012024449042016_b.jpg" shareURL:@"https://github.com/hoggenw"];
    }
    
}
-(void)buttonaction:(UIButton *)sender {
    
}

//下拉刷新
-(void)YLTableViewRefreshAction:(UIView *)view {
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self initialDataSource];
}
//上拉刷新
-(void)YLTableViewLoadMoreAction:(UIView *)view {
    self.page++;
    [self initialDataSource];
    
}
@end

