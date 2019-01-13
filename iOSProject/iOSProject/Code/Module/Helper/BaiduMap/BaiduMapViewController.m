//
//  BaiduMapViewController.m
//  iOSProject
//
//  Created by 王留根 on 2019/1/12.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//


#import "BaiduMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import "MapCarAnnotationView.h"
#import <BMKLocationkit/BMKLocationComponent.h>

//百度地图秘钥
//NS6lYC0TtQdaKmuWseunZ5pqobicYbyY

@interface BaiduMapViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationManagerDelegate> {//BMKLocationServiceDelegate,
    BMKMapView * mapView;
    BMKPointAnnotation *pointAnnotation ;
   // BMKLocationService *_locService;
    BMKGeoCodeSearch *_geoCodeSearch;
}

@property (nonatomic, strong) MapCarAnnotationView *busAnnotationView;
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置对象
@property (nonatomic, strong) BMKLocationManager *locationManager; //定位对象

@end

@implementation BaiduMapViewController


#pragma mark - Override Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    mapView = [[BMKMapView alloc]initWithFrame: self.view.bounds];
    mapView.zoomLevel = 16; //地图等级，数字越大越清晰
    mapView.showsUserLocation = YES;//是否显示定位小蓝点，no不显示，我们下面要自定义的(这里显示前提要遵循代理方法，不可缺少)
    mapView.userTrackingMode = BMKUserTrackingModeNone;
    mapView.rotateEnabled = NO;
    mapView.overlookEnabled = NO;
    mapView.delegate = self;
    pointAnnotation = [[BMKPointAnnotation alloc] init];
    [mapView addAnnotation: pointAnnotation];
    self.view = mapView;
    self.title = @"跟随变换";
    //初始化BMKLocationService
   // [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"NS6lYC0TtQdaKmuWseunZ5pqobicYbyY" authDelegate:self];
    _userLocation = [[BMKUserLocation alloc]init];
    BMKLocationManager *locationManager = [[BMKLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    locationManager.pausesLocationUpdatesAutomatically = NO;
    locationManager.allowsBackgroundLocationUpdates = NO;// YES的话是可以进行后台定位的，但需要项目配置，否则会报错，具体参考开发文档
    locationManager.locationTimeout = 10;
    locationManager.reGeocodeTimeout = 10;
    _locationManager = locationManager;
    
    //开始定位
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
    // 初始化编码服务
    _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
 
    
}

//遵循代理写在viewwillappear中
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [mapView viewWillAppear];
    
    //_locService.delegate = self;
    _geoCodeSearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [mapView viewWillDisappear];
    mapView.delegate = nil;
    //_locService.delegate = nil;
    _geoCodeSearch.delegate = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Public Methods


#pragma mark - Events


#pragma mark - Private Methods


#pragma mark - Extension Delegate or Protocol
#pragma mark - <BMKLocationServiceDelegate>
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser{
    NSLog(@"start locate");
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser{
    NSLog(@"stop locate");
}


#pragma mark - BMKLocationManagerDelegate
/**
 *  @brief 连续定位回调函数。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param location 定位结果，参考BMKLocation。
 *  @param error 错误信息。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error{
    
    self.userLocation.location = location.location;

    [mapView removeAnnotation: pointAnnotation];
    [mapView setCenterCoordinate:_userLocation.location.coordinate animated:YES];
    if (![mapView.annotations containsObject: pointAnnotation]) {
        
    }
    if (![mapView.annotations containsObject:pointAnnotation]) {
        pointAnnotation.coordinate = _userLocation.location.coordinate;
        [mapView  addAnnotation:pointAnnotation];
    }
    pointAnnotation.coordinate = _userLocation.location.coordinate;
    
}


/**
 * @brief 该方法为BMKLocationManager提供设备朝向的回调方法。
 * @param manager 提供该定位结果的BMKLocationManager类的实例
 * @param heading 设备的朝向结果
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
          didUpdateHeading:(CLHeading * _Nullable)heading{
    self.userLocation.heading = heading;
    [UIView animateWithDuration:0.25 animations:^{
        self.busAnnotationView.busImageView.transform = CGAffineTransformMakeRotation(self->_userLocation.heading.trueHeading*M_PI/180);
    }];
}

#pragma mark - <BMKMapViewDelegate>

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    NSString *AnnotationViewID = @"renameMark";
    MapCarAnnotationView *annotationView = (MapCarAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil)
    {
        annotationView = [[MapCarAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        annotationView.image = [UIImage imageNamed:@"bus_backView"];
        
        annotationView.busImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(annotationView.frame), CGRectGetHeight(annotationView.frame))];
        annotationView.busImageView.image = [UIImage imageNamed:@"bus_location"];
        [annotationView addSubview:annotationView.busImageView];
        annotationView.canShowCallout = NO;
        
        [annotationView.superview bringSubviewToFront:annotationView];
    }
    
    self.busAnnotationView = annotationView;
    
    return annotationView;
}

@end
