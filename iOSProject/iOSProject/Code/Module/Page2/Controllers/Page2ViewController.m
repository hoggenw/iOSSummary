//
//  Page2ViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/2/18.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "Page2ViewController.h"
#import "YLTableView.h"
#import "DefualtCellModel.h"

@interface Page2ViewController ()<YLTableViewDelete>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation Page2ViewController


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

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods
-(void)initialDataSource {
    
    DefualtCellModel *model = [DefualtCellModel new];
    model.title = [NSString stringWithFormat:@"运行时"];
    model.desc = [NSString stringWithFormat:@"运行时"];
    model.leadImageName = @"tabbar-icon-selected-1";
    model.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model];
    [self.tableView.dataArray addObject: model];
    
    
//    DefualtCellModel *model1 = [DefualtCellModel new];
//    model1.title = [NSString stringWithFormat:@"微信登录"];
//    model1.desc = [NSString stringWithFormat:@"微信三方登录"];
//    model1.leadImageName = @"tabbar-icon-selected-1";
//    model1.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    [self.dataArray addObject: model1];
//    
//    
//    DefualtCellModel *model2 = [DefualtCellModel new];
//    model2.title = [NSString stringWithFormat:@"二维码"];
//    model2.desc = [NSString stringWithFormat:@"二维码生成"];
//    model2.leadImageName = @"tabbar-icon-selected-1";
//    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    [self.dataArray addObject: model2];
//    
//    
//    DefualtCellModel *model3 = [DefualtCellModel new];
//    model3.title = [NSString stringWithFormat:@"人脸识别"];
//    model3.desc = [NSString stringWithFormat:@"活体识别"];
//    model3.leadImageName = @"tabbar-icon-selected-1";
//    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    [self.dataArray addObject: model3];
//    
//    DefualtCellModel *model4 = [DefualtCellModel new];
//    model4.title = [NSString stringWithFormat:@"小视频录制"];
//    model4.desc = [NSString stringWithFormat:@"视频录制"];
//    model4.leadImageName = @"tabbar-icon-selected-1";
//    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model4];
//    
//    DefualtCellModel *model5 = [DefualtCellModel new];
//    model5.title = [NSString stringWithFormat:@"手写签名"];
//    model5.desc = [NSString stringWithFormat:@"手写签名"];
//    model5.leadImageName = @"tabbar-icon-selected-1";
//    model5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model5];
//    
//    DefualtCellModel *model6 = [DefualtCellModel new];
//    model6.title = [NSString stringWithFormat:@"WebView"];
//    model6.desc = [NSString stringWithFormat:@"vpn加载及进度条"];
//    model6.leadImageName = @"tabbar-icon-selected-1";
//    model6.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model6];
//    
//    
//    DefualtCellModel *model7 = [DefualtCellModel new];
//    model7.title = [NSString stringWithFormat:@"资源文件选择"];
//    model7.desc = [NSString stringWithFormat:@"iCloud与相册"];
//    model7.leadImageName = @"tabbar-icon-selected-1";
//    model7.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model7];
//    
//    
//    DefualtCellModel *model8 = [DefualtCellModel new];
//    model8.title = [NSString stringWithFormat:@"聊天页面与功能"];
//    model8.desc = [NSString stringWithFormat:@"聊天页面与功能"];
//    model8.leadImageName = @"tabbar-icon-selected-1";
//    model8.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model8];
//    
//    
//    DefualtCellModel *model9 = [DefualtCellModel new];
//    model9.title = [NSString stringWithFormat:@"日历选择器"];
//    model9.desc = [NSString stringWithFormat:@"日历选择器"];
//    model9.leadImageName = @"tabbar-icon-selected-1";
//    model9.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model9];
//    
//    
//    DefualtCellModel *model10 = [DefualtCellModel new];
//    model10.title = [NSString stringWithFormat:@"地址选择器"];
//    model10.desc = [NSString stringWithFormat:@"地址选择器"];
//    model10.leadImageName = @"tabbar-icon-selected-1";
//    model10.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model10];
//    
//    
//    DefualtCellModel *model11 = [DefualtCellModel new];
//    model11.title = [NSString stringWithFormat:@"直播功能"];
//    model11.desc = [NSString stringWithFormat:@"直播功能"];
//    model11.leadImageName = @"tabbar-icon-selected-1";
//    model11.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model11];
//    
//    
//    DefualtCellModel *model12 = [DefualtCellModel new];
//    model12.title = [NSString stringWithFormat:@"语音转文字"];
//    model12.desc = [NSString stringWithFormat:@"语音转文字"];
//    model12.leadImageName = @"tabbar-icon-selected-1";
//    model12.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model12];
//    
//    
//    DefualtCellModel *model13 = [DefualtCellModel new];
//    model13.title = [NSString stringWithFormat:@"地图"];
//    model13.desc = [NSString stringWithFormat:@"百度地图跟随"];
//    model13.leadImageName = @"tabbar-icon-selected-1";
//    model13.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model13];
//    
//    
//    DefualtCellModel *model14 = [DefualtCellModel new];
//    model14.title = [NSString stringWithFormat:@"解锁"];
//    model14.desc = [NSString stringWithFormat:@"九宫格解锁"];
//    model14.leadImageName = @"tabbar-icon-selected-1";
//    model14.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    [self.dataArray addObject: model14];
    
    
    
    self.tableView.dataArray = [NSMutableArray arrayWithArray: self.dataArray];
    
    [self.tableView.tableView reloadData];
    
}
- (void)initialUI {

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

#pragma mark - Extension Delegate or Protocol

#pragma mark - YLTableViewDelete

-(void)didselectedCell:(NSInteger)index {
    
    NSLog(@"%@",@(index));
    if (index == 0) {

    }else if (index == 1){
      
    }else if (index == 2){
        
    }else if (index == 3){
        
        
    }else if (index == 4){
        
    }else if(index == 5){
        
    }else if(index == 6){
       
    }else if(index == 7){
       
    }
    else if(index == 8){
        
    }else if (index == 9){
        
    }else if (index == 10){
        
        
    }else if(index == 11){
        
    }
    
    else if(index == 12){
        
    }
    else if(index == 13){
       
    }
    
    
}
-(void)buttonaction:(UIButton *)sender {
    
}

//下拉刷新
-(void)YLTableViewRefreshAction:(UIView *)view {
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self initialDataSource];
    [self.tableView.tableView.mj_header endRefreshing];
    
}
//上拉刷新
-(void)YLTableViewLoadMoreAction:(UIView *)view {
    self.page++;
    [self.tableView.tableView.mj_footer endRefreshing];
    
}

@end
