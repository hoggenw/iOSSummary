//
//  YLAreaHelper.m
//  iOSProject
//
//  Created by 王留根 on 2019/1/7.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import "YLAreaHelper.h"


@interface YLAreaHelper()

/** 省份列表 */
@property (strong, nonatomic) NSArray<YLArea *> *provinceList;


/** 从数组中加载 */
- (void)loadDataWithArray:(NSArray<NSDictionary *> *)array;

/**
 *  网络请求
 */
- (void)loadDataWithNetWork;

/**
 *  本地加载
 */
- (void)loadDataWithLocal;
/** 本地保存 */
- (void)storeDataWithArray:(NSArray<NSDictionary *> *)array;



/** 保存的文件名字 */
@property (copy, nonatomic) NSString *fileName;


- (void)loadData;

@end

@implementation YLAreaHelper
#pragma mark - public function

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fileName = @"Address.plist";
    }
    return self;
}

// 单例
+ (instancetype)shareInstance
{
    static YLAreaHelper *defaultAreaManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAreaManager = [[YLAreaHelper alloc] init];
        [defaultAreaManager loadData];
    });
    return defaultAreaManager;
}

// 数据加载
- (void)reloadData
{
    if (self.provinceList) {
        return;
    }
    
    [self loadData];
    
}

// 通过areaId构造AreaData
- (YLAreaData *)areaDataWithAreaId:(NSInteger)areaId
{
    if (!self.provinceList) {
        return nil;
    }
    
    YLAreaData *areaData = [[YLAreaData alloc] init];
    areaData.areaId = areaId;
    
    // 根据areaId去省市区遍历
    // 省级遍历
    NSInteger provinceCount = self.provinceList.count;
    for (int i=0; i<provinceCount; i++)
    {
        YLArea *provinceModel = self.provinceList[i];
        if (areaId == provinceModel.areaId)
        {
            areaData.provinceTitle = provinceModel.title;
            areaData.provinceRow = i;
            break;
        }
        
        // 市级遍历
        BOOL findFlag = NO;
        NSInteger cityCount = provinceModel.childs.count;
        for (int j=0; j<cityCount; j++)
        {
            YLArea *cityModel = provinceModel.childs[j];
            if (areaId == cityModel.areaId)
            {
                areaData.provinceTitle = provinceModel.title;
                areaData.provinceRow = i;
                areaData.cityTitle = cityModel.title;
                areaData.cityRow = j;
                // 标记
                findFlag = YES;
                break;
            }
            
            // 区级遍历
            NSInteger zoneCount = cityModel.childs.count;
            for (int p=0; p<zoneCount; p++)
            {
                YLArea *zoneModel = cityModel.childs[p];
                if (areaId == zoneModel.areaId)
                {
                    areaData.provinceTitle = provinceModel.title;
                    areaData.provinceRow = i;
                    areaData.cityTitle = cityModel.title;
                    areaData.cityRow = j;
                    areaData.zoneTitle = zoneModel.title;
                    areaData.zoneRow = p;
                    // 标记
                    findFlag = YES;
                    break;
                }
            }
            
            if (findFlag)   // 找到的是区级别的
            {
                break;
            }
        }
        
        if (findFlag)   // 找到了，可能市级，也可能区级
        {
            break;
        }
        
    }
    
    return areaData;
}

- (NSString *)areaStringWithAreaId:(NSInteger)areaId {
    YLAreaData *area = [self areaDataWithAreaId:areaId];
    NSString *str = [NSString stringWithFormat:@"%@%@%@", area.provinceTitle, area.cityTitle, area.zoneTitle];
    return str;
}

#pragma mark - private function

#pragma mark - private fileManager function

// 本地文件是否存在
// 删除本地文件

// 本地文件路径
- (NSString *)localFilePath
{
    //检索Documents目录
    NSString *fileName = self.fileName;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths lastObject];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

#pragma mark - private other


- (void)loadData
{
    // 先判断本地文件是否存在，没有则下载，有则无需下载
    NSString *filePath = [self localFilePath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])    // 本地不存在
    {
        [self loadDataWithNetWork]; // 网络加载
    }
    else
    {
        [self loadDataWithLocal];   // 本地加载
    }
}


// 从数组中加载
- (void)loadDataWithArray:(NSArray<NSDictionary *> *)array
{
    
    NSMutableArray<YLArea *> *provinceList = [NSMutableArray array];
    NSMutableArray<YLArea *> *cityList   = [NSMutableArray array];
    NSMutableArray<YLArea *> *zoneList   = [NSMutableArray array];
    
    // 循环1，获取省级列表
    for (NSDictionary *dicInfo in array)
    {
        // dicInfo -> model
        YLArea *area = [YLArea yy_modelWithDictionary:dicInfo];
        
        // 数据筛选(后台数据可能异常，没有title者一律抛弃)
        if (!area.title) {
            continue;
        }
        
        if (0 == area.parentId) // 省级Id
        {
            [provinceList addObject:area];
        }
        else
        {
            [cityList addObject:area];
        }
    }
    
    // 循环2，获取市级列表
    for (YLArea *cityModel in cityList)
    {
        //现在区级必选
        //        // 添加占位区级(区可不选)
        //        PSArea *spaceZone = [[PSArea alloc] init];
        //        spaceZone.title = @"";
        //        [cityModel.childs addObject:spaceZone];
        
        BOOL isCityFlag = NO;
        for (YLArea *provinceModel in provinceList)
        {
            if (cityModel.parentId == provinceModel.areaId) // 该省级下的市级
            {
                isCityFlag = YES;
                [provinceModel.childs addObject:cityModel];
                break;
            }
        }
        
        if (!isCityFlag)
        {
            [zoneList addObject:cityModel];
        }
    }
    
    // 循环3，获取区级列表
    for (YLArea *zoneModel in zoneList)
    {
        BOOL isAddFlag = NO;
        for (YLArea *provinceModel in provinceList)
        {
            for (YLArea *cityModel in provinceModel.childs)    // 该市级下的区级
            {
                if (zoneModel.parentId == cityModel.areaId)
                {
                    isAddFlag = YES;
                    [cityModel.childs addObject:zoneModel];
                    break;
                }
            }
            
            if (isAddFlag) {
                break;
            }
        }
    }
    
    // 数据保存
    self.provinceList = provinceList;
}




// 网络请求
- (void)loadDataWithNetWork
{
//    // 获取地址列表
//    [NetWorkManager getAddressListWithSuccess:^(id  _Nullable responseObject) {
//        NSArray *array = responseObject[@"Body"];
//        if (array.count > 0){
//            [self loadDataWithArray:array];
//            
//            // 本地保存
//            [self storeDataWithArray:array];
//        }
//        
//        
//    } failure:^(id  _Nullable responseObject) {
//        NSLog(@"getAddressListWithSuccess failure, result : %@", responseObject);
//    } error:^(NSError * _Nonnull error) {
//        NSLog(@"getAddressListWithSuccess error, info : %@", error.localizedDescription);
//    } showMsg:NO];
}


// 本地加载
- (void)loadDataWithLocal
{
    NSString *filePath = [self localFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])    // 本地存在
    {
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        
        [self loadDataWithArray:array];
    }
    else
    {
        [self loadDataWithNetWork];
    }
}

// 本地保存
- (void)storeDataWithArray:(NSArray<NSDictionary *> *)array
{
    NSString *filePath = [self localFilePath];
    BOOL isSuccess = [array writeToFile:filePath atomically:YES];
    NSLog(@"write area to local %d",isSuccess);
}






@end
