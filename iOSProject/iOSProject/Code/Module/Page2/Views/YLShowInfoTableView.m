//
//  YLShowInfoTableView.m
//  iOSProject
//
//  Created by 王留根 on 2019/4/16.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "YLShowInfoTableView.h"
#import "ShowMessageModel.h"
#import "ShowInfoTableViewCell.h"


@interface  YLShowInfoTableView()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)NSIndexPath *scrollIndexPath;
//暂无数据
@property (nonatomic, strong) UIImageView * noDataView;

@property(nonatomic,assign)double arryCount;


@end

@implementation YLShowInfoTableView


- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _dataArray = [NSMutableArray array];
        [self initSubViews];
    }
    return self;
}

-(void)setCellType:(CellType)cellType {
    _cellType = cellType;
}


-(void)initSubViews
{
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.noDataView setHidden: true];
    [self addSubview: self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(218));
        make.height.equalTo(@(192));
    }];
    //添加刷新View
    [self addRefreshView];
    [self.tableView reloadData];
    [self bringSubviewToFront: self.noDataView];
}
// getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView * tableView = [UITableView new];
        _tableView = tableView;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [self addSubview: _tableView];
        // 配置
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.rowHeight = UITableViewAutomaticDimension;
        // 分割线样式
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 约束
        [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
    }
    return _tableView;
}



//添加刷新View
- (void)addRefreshView
{
    
    __weak __typeof(self)weakSelf = self;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshAction];
    }];
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreAction];
    }];
    [(MJRefreshAutoGifFooter *) self.tableView.mj_footer setTitle:@"" forState:MJRefreshStateIdle];
    
}
//下拉刷新
- (void)refreshAction
{
    
    if (self.delegate != nil) {
        [self.delegate YLTableViewRefreshAction:(UIView *)self];
        
    }
    
    
}
//上拉刷新
- (void)loadMoreAction
{
    if (self.delegate != nil) {
        
        [self.delegate YLTableViewLoadMoreAction: self];
    }
    
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    
    if (self.dataArray.count == 0 )
    {
        self.arryCount = dataArray.count;
    }
    if (self.arryCount >= dataArray.count)
    {
        self.scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        self.arryCount = dataArray.count;
    }
    
    
    
    _dataArray = dataArray;
    [self.tableView reloadData];
    
    
    if (self.dataArray.count > 0)
    {
        [self.tableView scrollToRowAtIndexPath:self.scrollIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: true ];
    }
}


// 分组(section)数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 指定分组(section)下的cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count <= 0) {
        [self.noDataView setHidden: false];
    }else{
        [self.noDataView setHidden: true];
    }
    return self.dataArray.count;
}

// 指定位置(indexPath)处的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // cell重用机制
    ShowInfoTableViewCell * cell = [ShowInfoTableViewCell cellInTableView:tableView];
    // cell数据展示
    ShowMessageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - delegate <UITableViewDelegate>

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.01)];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.01)];
    return view;
}

// 指定位置(indexPath)处的celldazhi高度
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShowMessageModel * model = self.dataArray[indexPath.row];
    if (model.showType == TextType) {
        return  [self heightForLabelText: model.content];
    }
    
    if (model.showType == ImageType) {
        return  model.image.size.height;
    }
    return 45;
}

// 指定位置(indexPath)处的cell选中响应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(didselectedCell:)]) {
        [self.delegate didselectedCell: indexPath.row];
    }
    // 取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





-(void)click:(UIButton *)sender
{
    [self.delegate buttonaction:sender];
}


-(UIImageView *)noDataView {
    if(_noDataView == nil){
        UIImageView *noData = [UIImageView new];
        noData.image = [UIImage imageNamed:@"common_nodata_icon"];
        CGRect frame = noData.frame;
        frame.size = CGSizeMake(106, 95);
        noData.frame = frame;
        _noDataView = noData;
    }
    //    106 95
    return _noDataView;
}

- (float) heightForLabelText: (NSString *) strText{
    CGSize constraint = CGSizeMake(ScreenWidth - 20 , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                        context:nil];
    float textHeight = size.size.height + 22;
    return textHeight;
}

@end
