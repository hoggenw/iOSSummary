//
//  YLAddressPickerUtil.m
//  iOSProject
//
//  Created by 王留根 on 2019/1/7.
//  Copyright © 2019年 hoggenWang.com. All rights reserved.
//

#import "YLAddressPickerUtil.h"
#import "YLAreaHelper.h"
#import "YLPickerShowView.h"

@interface YLAddressPickerUtil () <UIPickerViewDataSource, UIPickerViewDelegate>

// picker source list 省市区
@property (strong, nonatomic) NSArray<YLArea *> *provinceList;
@property (strong, nonatomic) NSArray<YLArea *> *cityList;
@property (strong, nonatomic) NSArray<YLArea *> *zoneList;

@end


@implementation YLAddressPickerUtil
#pragma mark - public function

// 显示地址选择器
- (void)showWithAreaId:(NSInteger)areaId
{
    self.provinceList = [YLAreaHelper shareInstance].provinceList;
    
    CGFloat pickerHeight = 200;
    // 创建选择器
    UIPickerView * picker = [[UIPickerView alloc] init];
    picker.backgroundColor = [UIColor  colorWithHex:0xf3f4f5];
    picker.dataSource = self;
    picker.delegate = self;
    // 设置默认选择
    NSInteger provinceRow = 0;
    NSInteger cityRow = 0;
    NSInteger zoneRow = 0;
    YLAreaData *areaData = [[YLAreaHelper shareInstance] areaDataWithAreaId:areaId];
    if (areaData && areaData.zoneTitle) {
        provinceRow = areaData.provinceRow;
        cityRow = areaData.cityRow;
        zoneRow = areaData.zoneRow;
    }
    YLArea * province = [self.provinceList objectAtIndex:provinceRow];
    self.cityList = province.childs;
    YLArea * city = [self.cityList objectAtIndex:cityRow];
    self.zoneList = city.childs;
    [picker selectRow:provinceRow inComponent:0 animated:NO];
    [picker selectRow:cityRow inComponent:1 animated:NO];
    [picker selectRow:zoneRow inComponent:2 animated:NO];
    // 添加 显示选择器
    YLPickerShowView * showView = [YLPickerShowView showView];
    [[UIApplication sharedApplication].keyWindow addSubview:showView];
    [showView showPicker:picker pickerHeight:pickerHeight];
    
    // 确定回调
    showView.doneBtnClickAction = ^(UIPickerView * pickerView){
        NSInteger selectRowZone     = [pickerView selectedRowInComponent:2];
        // 数据保存
        NSInteger areaId = self.zoneList[selectRowZone].areaId;
        YLAreaData *selectAreaData = [[YLAreaHelper shareInstance] areaDataWithAreaId:areaId];
        
        // 确定回调
        if (self.doneBtnClickAction) {
            self.doneBtnClickAction(selectAreaData);
        }
    };
}

#pragma mark - extension function / private function




#pragma mark - delegate function


#pragma mark - delegate <UIPickerViewDataSource>

// 选择器的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger components = 3;
    
    return components;
}

// 选择器里指定列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = 1;
    if (0 == component) {
        count = self.provinceList.count;
    } else if (1 == component) {
        count = self.cityList.count;
    } else {
        count = self.zoneList.count;
    }
    
    return count;
    
}


#pragma mark - delegate <UIPickerViewDelegate>


// 选择器 指定行列处 文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = @"";
    if (0 == component) //第0列  省级
    {
        YLArea * province = self.provinceList[row];
        title = province.title;
    }
    else if(1 == component)    // 第1列 市级
    {
        if (self.cityList) {
            YLArea * city = self.cityList[row];
            title = city.title;
        }
    }
    else    // 第2列 区级
    {
        if (self.zoneList) {
            YLArea * zone = self.zoneList[row];
            title = zone.title;
        }
    }
    
    return title;
}

// 选择器 选中指定列的指定行时 响应  若有联动，则联动处理
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 联动处理
    if (0 == component) // 第0列 省级
    {
        YLArea * province = self.provinceList[row];
        self.cityList = province.childs;
        [pickerView reloadComponent:1];
        
        if (self.cityList.count)
        {
            [pickerView selectRow:0 inComponent:1 animated:YES];
            
            YLArea *city = self.cityList[0];
            self.zoneList = city.childs;
            [pickerView reloadComponent:2];
            if (self.zoneList.count) {
                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
        }
        else
        {
            self.zoneList = nil;
            [pickerView reloadComponent:2];
        }
        
    }
    else if (1 == component)    // 第1列 市级
    {
        if (0 == self.cityList.count) {
            return;
        }
        
        YLArea * city = self.cityList[row];
        self.zoneList = city.childs;
        [pickerView reloadComponent:2];
        if (self.zoneList.count) {
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    
}

// 选择器 所在行的view配置
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0f;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    // Fill the label text here
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

//  选择器指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat componentW = [UIScreen mainScreen].bounds.size.width / 3.0f;
    return componentW;
}

// 选择器高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}

@end
