# YLOCScan

[![CI Status](https://img.shields.io/travis/hoggenw/YLOCScan.svg?style=flat)](https://travis-ci.org/hoggenw/YLOCScan)
[![Version](https://img.shields.io/cocoapods/v/YLOCScan.svg?style=flat)](https://cocoapods.org/pods/YLOCScan)
[![License](https://img.shields.io/cocoapods/l/YLOCScan.svg?style=flat)](https://cocoapods.org/pods/YLOCScan)
[![Platform](https://img.shields.io/cocoapods/p/YLOCScan.svg?style=flat)](https://cocoapods.org/pods/YLOCScan)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

YLOCScan is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YLOCScan'
```

## Author

hoggenw, 253192463@qq.com

## License

YLOCScan is available under the MIT license. See the LICENSE file for more info.

##调用方法
注意要在.plist设置相机相关的权限
```
      //初始化
      YLScanViewManager * manager = [YLScanViewManager sharedInstance];
      //视图UI相关的设置更改，可以不做设置，使用默认配置
       // 是否需要边框
       //manager.isNeedShowRetangle = true;
       //扫描框的宽高比
       // manager.whRatio = 1;
       //相对中心点Y的偏移
       //manager.centerUpOffset = -20;
       //扫描框的宽度
       // manager.scanViewWidth = 160;
       //扫描框的颜色
       //manager.colorRetangleLine = UIColor.red;
       //扫码区域4个角的线条宽度
       //manager.photoframeLineW = 4;  
       //自定义扫描动画
        manager.animationImage = image;
       //添加扫描成功返回代理
        manager.delegate = self;
       //扫描动画的样式，自带4种样式
        manager.imageStyle = secondeNetGrid;
        [manager showScanView: self];

```
在YLScanViewControllerDelegate的代理中处理成功后返回的数据

```
-(void)scanViewControllerSuccessWith:(YLScanResult *)result {
    NSLog(@"wlg====%@", result.strScanned);
}

```
二维码的生成

```
    YLScanViewManager * manager = [YLScanViewManager sharedInstance];
    UIView *codeView = [manager produceQRcodeView:CGRectMake((self.view.bounds.size.width - 200)/2, (self.view.bounds.size.width - 200)/2, 200, 200) logoIconName:@"device_scan" codeMessage:@"wlg's test Message"];
    [self.view addSubview:codeView];

```

















