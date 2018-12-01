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
#import "YLScanViewManager.h"
#import "QRCreatViewController.h"
#import "FaceStreamDetectorViewController.h"
#import "RecordVideoViewController.h"
#import "AutographViewController.h"
#import "YLWebViewController.h"
#import "FileViewController.h"

@interface Page1ViewController ()<NormalActionWithInfoDelegate,YLTableViewDelete,YLScanViewControllerDelegate>
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden: false];
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
    model1.title = [NSString stringWithFormat:@"微信登录"];
    model1.desc = [NSString stringWithFormat:@"微信三方登录"];
    model1.leadImageName = @"tabbar-icon-selected-1";
    model1.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model1];
    
    
    DefualtCellModel *model2 = [DefualtCellModel new];
    model2.title = [NSString stringWithFormat:@"二维码"];
    model2.desc = [NSString stringWithFormat:@"二维码生成"];
    model2.leadImageName = @"tabbar-icon-selected-1";
    model2.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model2];
    
    
    DefualtCellModel *model3 = [DefualtCellModel new];
    model3.title = [NSString stringWithFormat:@"人脸识别"];
    model3.desc = [NSString stringWithFormat:@"活体识别"];
    model3.leadImageName = @"tabbar-icon-selected-1";
    model3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model3];
    
    DefualtCellModel *model4 = [DefualtCellModel new];
    model4.title = [NSString stringWithFormat:@"小视频录制"];
    model4.desc = [NSString stringWithFormat:@"视频录制"];
    model4.leadImageName = @"tabbar-icon-selected-1";
    model4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model4];
    
    DefualtCellModel *model5 = [DefualtCellModel new];
    model5.title = [NSString stringWithFormat:@"手写签名"];
    model5.desc = [NSString stringWithFormat:@"手写签名"];
    model5.leadImageName = @"tabbar-icon-selected-1";
    model5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model5];
    
    DefualtCellModel *model6 = [DefualtCellModel new];
    model6.title = [NSString stringWithFormat:@"WebView"];
    model6.desc = [NSString stringWithFormat:@"vpn加载及进度条"];
    model6.leadImageName = @"tabbar-icon-selected-1";
    model6.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model6];
    
    
    DefualtCellModel *model7 = [DefualtCellModel new];
    model7.title = [NSString stringWithFormat:@"资源文件选择"];
    model7.desc = [NSString stringWithFormat:@"iCloud与相册"];
    model7.leadImageName = @"tabbar-icon-selected-1";
    model7.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model7];
    
    
    self.tableView.dataArray = [NSMutableArray arrayWithArray: self.dataArray];
    
    [self.tableView.tableView reloadData];
    
}
- (void)initialUI {
    UIButton * button = [UIButton new];
    button.frame  = CGRectMake(0, 0, 60, 25);
    
    [button setTitle:@"二维码" forState:UIControlStateNormal];
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
    NSString * url = @"http://192.168.20.17:8888/admin/changeStandards";
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[@"catalog_id"] = @"10001";
    NSMutableArray * values =  [NSMutableArray array];
    NSMutableDictionary * dictionaryValue = [NSMutableDictionary dictionary];
    dictionaryValue[@"standardTitle"] = @"标题1";
    dictionaryValue[@"min"] = @"1";
    dictionaryValue[@"max"] = @"10";
    dictionaryValue[@"color"] = @"#6495ED";
    dictionaryValue[@"standardId"] = @"100011";
    [values addObject: dictionaryValue];
    
    
    NSMutableDictionary * dictionaryValue1 = [NSMutableDictionary dictionary];
    dictionaryValue1[@"standardTitle"] = @"标题2";
    dictionaryValue1[@"min"] = @"1";
    dictionaryValue1[@"max"] = @"10";
    dictionaryValue1[@"color"] = @"#6495ED";
    [values addObject: dictionaryValue1];
    
    NSMutableDictionary * dictionaryValue2 = [NSMutableDictionary dictionary];
    dictionaryValue2[@"standardTitle"] = @"标题2";
    dictionaryValue2[@"min"] = @"1";
    dictionaryValue2[@"max"] = @"10";
    dictionaryValue2[@"color"] = @"#6495ED";
    [values addObject: dictionaryValue2];
    
    NSMutableDictionary * dictionaryValue3 = [NSMutableDictionary dictionary];
    dictionaryValue3[@"standardTitle"] = @"标题2";
    dictionaryValue3[@"min"] = @"1";
    dictionaryValue3[@"max"] = @"10";
    dictionaryValue3[@"color"] = @"#6495ED";
    [values addObject: dictionaryValue3];
    
    NSMutableDictionary * dictionaryValue4 = [NSMutableDictionary dictionary];
    dictionaryValue4[@"standardTitle"] = @"标题2";
    dictionaryValue4[@"min"] = @"1";
    dictionaryValue4[@"max"] = @"10";
    dictionaryValue4[@"color"] = @"#6495ED";
    [values addObject: dictionaryValue4];
    
    NSMutableDictionary * dictionaryValue5 = [NSMutableDictionary dictionary];
    dictionaryValue5[@"standardTitle"] = @"标题2";
    dictionaryValue5[@"min"] = @"1";
    dictionaryValue5[@"max"] = @"10";
    dictionaryValue5[@"color"] = @"#6495ED";
    [values addObject: dictionaryValue5];
    NSString * jsonString = [values yy_modelToJSONString];
    dictionary[@"values"] = jsonString;
    NSLog(@"jsonString: %@", jsonString);
    [[NetworkManager sharedInstance] postWithURL:url param:dictionary needToken:true returnBlock:^(NSDictionary *returnDict) {
        NSLog(@"returnDict: %@", returnDict);
    }];
    
    return;
    YLScanViewManager * manager = [YLScanViewManager sharedInstance];
    manager.imageStyle = secondeNetGrid;
    manager.delegate = self;
    [manager showScanView: self];
}

#pragma mark - Public Methods

#pragma mark - Extension Delegate or Protocol

-(void)scanViewControllerSuccessWith:(YLScanResult *)result {
    NSLog(@"wlg====%@", result.strScanned);
}

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
    }else if (index == 1){
        [YLUMengHelper getUserInfoForPlatform:UMSocialPlatformType_WechatSession completion:^(UMSocialUserInfoResponse *result, NSError *error) {
            NSLog(@"%@", result);
        }];
    }else if (index == 2){
        QRCreatViewController * vc = [QRCreatViewController new];
        [self.navigationController pushViewController: vc animated: false];
    }else if (index == 3){
        FaceStreamDetectorViewController *faceVC = [FaceStreamDetectorViewController new];
        faceVC.hidesBottomBarWhenPushed = YES;
        //        __weak typeof(self) weakSelf = self;
        faceVC.signatureFishBlock = ^(NSString * urlString) {
            // NSString *strUrl = urlString;
            NSLog(@"%@",urlString);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [YLHintView showAlertMessage:urlString title:[FileManager getFileSizeWithPath:urlString]];
            });
            
            
        };
        [self.navigationController pushViewController:faceVC animated:YES];
        
    }else if (index == 4){
        RecordVideoViewController *faceVC = [[RecordVideoViewController alloc]init];
        faceVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:faceVC animated:YES];
    }else if(index == 5){
        AutographViewController *autographVC = [AutographViewController new];
        autographVC.hidesBottomBarWhenPushed = YES;
        autographVC.signatureFishBlock = ^(UIImage * image) {
            NSString * iamgeString = [NSString stringWithFormat:@"image.width:%f,image.height:%f",image.size.width,image.size.height];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [YLHintView showAlertMessage:iamgeString title:@"图片信息"];
            });
        };
        [self.navigationController pushViewController:autographVC animated:YES];
    }else if(index == 6){
        YLWebViewController * webVC = [YLWebViewController new];
        webVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if(index == 7){
        FileViewController * VC = [FileViewController new];
        VC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:VC animated:YES];
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


