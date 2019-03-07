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
#import "ChatListViewController.h"
#import "DatePickerView.h"
#import "YLAddressPickerUtil.h"
#import "YLAreaHelper.h"
#import "IJKFrameworkViewController.h"
#import "ToWordsViewController.h"
#import "BaiduMapViewController.h"
#import "ChangeLanguageViewController.h"
#import "Animation1ViewController.h"
#import "ShowPSDViewController.h"
#import "Animation2ViewController.h"

@interface Page1ViewController ()<NormalActionWithInfoDelegate,YLTableViewDelete,YLScanViewControllerDelegate,DatePickerViewDelegate>
@property (nonatomic, strong) YLTableView  * tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (strong, nonatomic) YLAreaData * selectAreaData;


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
    
    
    DefualtCellModel *model8 = [DefualtCellModel new];
    model8.title = [NSString stringWithFormat:@"聊天页面与功能"];
    model8.desc = [NSString stringWithFormat:@"聊天页面与功能"];
    model8.leadImageName = @"tabbar-icon-selected-1";
    model8.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model8];
    
    
    DefualtCellModel *model9 = [DefualtCellModel new];
    model9.title = [NSString stringWithFormat:@"日历选择器"];
    model9.desc = [NSString stringWithFormat:@"日历选择器"];
    model9.leadImageName = @"tabbar-icon-selected-1";
    model9.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model9];
    
    
    DefualtCellModel *model10 = [DefualtCellModel new];
    model10.title = [NSString stringWithFormat:@"地址选择器"];
    model10.desc = [NSString stringWithFormat:@"地址选择器"];
    model10.leadImageName = @"tabbar-icon-selected-1";
    model10.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model10];
    
    
    DefualtCellModel *model11 = [DefualtCellModel new];
    model11.title = [NSString stringWithFormat:@"直播功能"];
    model11.desc = [NSString stringWithFormat:@"直播功能"];
    model11.leadImageName = @"tabbar-icon-selected-1";
    model11.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model11];
    
    
    DefualtCellModel *model12 = [DefualtCellModel new];
    model12.title = [NSString stringWithFormat:@"语音转文字"];
    model12.desc = [NSString stringWithFormat:@"语音转文字"];
    model12.leadImageName = @"tabbar-icon-selected-1";
    model12.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model12];
    
    
    DefualtCellModel *model13 = [DefualtCellModel new];
    model13.title = [NSString stringWithFormat:@"地图"];
    model13.desc = [NSString stringWithFormat:@"百度地图跟随"];
    model13.leadImageName = @"tabbar-icon-selected-1";
    model13.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model13];
    
    
    DefualtCellModel *model14 = [DefualtCellModel new];
    model14.title = [NSString stringWithFormat:@"解锁"];
    model14.desc = [NSString stringWithFormat:@"九宫格解锁"];
    model14.leadImageName = @"tabbar-icon-selected-1";
    model14.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model14];
    
    
    DefualtCellModel *model15 = [DefualtCellModel new];
    model15.title = [NSString stringWithFormat:@"核心动画"];
    model15.desc = [NSString stringWithFormat:@"动画1"];
    model15.leadImageName = @"tabbar-icon-selected-1";
    model15.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.dataArray addObject: model15];
    
    DefualtCellModel *model16 = [DefualtCellModel new];
    model16.title = [NSString stringWithFormat:@"国际化"];
    model16.desc = [NSString stringWithFormat:@"APP内国际化及app名称国际化"];
    model16.leadImageName = @"tabbar-icon-selected-1";
    model16.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model16];
    
    
    DefualtCellModel *model17 = [DefualtCellModel new];
    model17.title = [NSString stringWithFormat:@"核心动画"];
    model17.desc = [NSString stringWithFormat:@"动画2"];
    model17.leadImageName = @"tabbar-icon-selected-1";
    model17.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.dataArray addObject: model17];
  
    
    
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
//    NSString * url = @"http://192.168.0.108:8888/admin/changeStandards";
//    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
//    dictionary[@"catalog_id"] = @"10001";
    NSMutableArray * values =  [NSMutableArray array];
    NSMutableDictionary * dictionaryValue = [NSMutableDictionary dictionary];
//    dictionaryValue[@"standardTitle"] = @"标题1";
//    dictionaryValue[@"min"] = @"1";
//    dictionaryValue[@"max"] = @"10";
//    dictionaryValue[@"color"] = @"#6495ED";
//    dictionaryValue[@"standardId"] = @"100011";
//    [values addObject: dictionaryValue];
//
//
//    NSMutableDictionary * dictionaryValue1 = [NSMutableDictionary dictionary];
//    dictionaryValue1[@"standardTitle"] = @"标题2";
//    dictionaryValue1[@"min"] = @"1";
//    dictionaryValue1[@"max"] = @"10";
//    dictionaryValue1[@"color"] = @"#6495ED";
//    [values addObject: dictionaryValue1];
//
//    NSMutableDictionary * dictionaryValue2 = [NSMutableDictionary dictionary];
//    dictionaryValue2[@"standardTitle"] = @"标题3";
//    dictionaryValue2[@"min"] = @"1";
//    dictionaryValue2[@"max"] = @"10";
//    dictionaryValue2[@"color"] = @"#6495ED";
//    [values addObject: dictionaryValue2];
//
//    NSMutableDictionary * dictionaryValue3 = [NSMutableDictionary dictionary];
//    dictionaryValue3[@"standardTitle"] = @"标题4";
//    dictionaryValue3[@"min"] = @"1";
//    dictionaryValue3[@"max"] = @"10";
//    dictionaryValue3[@"color"] = @"#6495ED";
//    [values addObject: dictionaryValue3];
//
//    NSMutableDictionary * dictionaryValue4 = [NSMutableDictionary dictionary];
//    dictionaryValue4[@"standardTitle"] = @"标题5";
//    dictionaryValue4[@"min"] = @"1";
//    dictionaryValue4[@"max"] = @"10";
//    dictionaryValue4[@"color"] = @"#6495ED";
//    [values addObject: dictionaryValue4];
//
//    NSMutableDictionary * dictionaryValue5 = [NSMutableDictionary dictionary];
//    dictionaryValue5[@"standardTitle"] = @"标题6";
//    dictionaryValue5[@"min"] = @"1";
//    dictionaryValue5[@"max"] = @"10";
//    dictionaryValue5[@"color"] = @"#6495ED";
//    [values addObject: dictionaryValue5];
//    [values addObject:@"20181207_a8a9504f-aa5a-4b7a-ae12-ea10d6670064"];
//    [values addObject:@"20181207_a8a9504f-aa5a-4b7a-ae12-ea10d6670064"];
    NSString * jsonString = [values yy_modelToJSONString];
 //   dictionary[@"values"] = jsonString;
//    NSLog(@"jsonString: %@", jsonString);
////    [[NetworkManager sharedInstance] postWithURL:url param:dictionary needToken:true returnBlock:^(NSDictionary *returnDict) {
////        NSLog(@"returnDict: %@", returnDict);
////    }];
//    [[NetworkManager sharedInstance] postWithURL:url paramBody:(NSDictionary *)dictionary needToken: true returnBlock:^(NSDictionary *returnDict) {
//        
//    }];
//    
//    return;
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
    else if(index == 8){
        ChatListViewController * VC = [ChatListViewController new];
        VC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (index == 9){
        DatePickerView * pickView = [[DatePickerView alloc] initWithFrame: CGRectMake(0, ScreenHeight - 260,  ScreenWidth,  260)];
        [self.view addSubview: pickView];
        pickView.delegate = self;
        [pickView showDateTimePickerView];
    }else if (index == 10){
        
        NSInteger areaId = 0;
        if (self.selectAreaData && self.selectAreaData.zoneTitle) {
            areaId = self.selectAreaData.areaId;
        }
        YLAddressPickerUtil *addressUtil = [[YLAddressPickerUtil alloc] init];
        addressUtil.doneBtnClickAction = ^(YLAreaData *selectAreaData){
            // 数据保存
            self.selectAreaData = selectAreaData;
            
            // 数据展示
            NSString * provinceTitle = selectAreaData.provinceTitle;
            NSString * cityTitle = selectAreaData.cityTitle;
            NSString * zoneTitle = selectAreaData.zoneTitle;
            NSString * regionTitle = [NSString stringWithFormat:@"%@ %@ %@", provinceTitle, cityTitle, zoneTitle];
            [YLHintView showMessageOnThisPage: regionTitle];
        };
        [addressUtil showWithAreaId:areaId];
    }else if(index == 11){
        IJKFrameworkViewController * VC = [IJKFrameworkViewController new];
        VC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    else if(index == 12){
        ToWordsViewController * VC = [ToWordsViewController new];
        VC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if(index == 13){
        BaiduMapViewController * VC = [BaiduMapViewController new];
        VC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if(index == 14){
        ShowPSDViewController * VC = [ShowPSDViewController new];
        VC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if(index == 15){
        Animation1ViewController * VC = [Animation1ViewController new];
        VC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:VC animated:YES];
    }else if(index == 16){
        ChangeLanguageViewController * VC = [ChangeLanguageViewController new];
        VC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:VC animated:YES];
    }else if(index == 17){
        Animation2ViewController * VC = [Animation2ViewController new];
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

#pragma mark -DatePickerViewDelegate
-(void)didClickFinishDateTimePickerView:(NSString*)date {
    
    [YLHintView showMessageOnThisPage:date];
    NSLog(@"%@",date);
}

-(void)cancelDateTimePickerView{
    
}
@end


