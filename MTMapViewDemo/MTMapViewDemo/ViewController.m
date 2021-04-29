//
//  ViewController.m
//  MTMapViewDemo
//
//  Created by 全先帅 on 2021/4/15.
//

#import "ViewController.h"
#import "MMCMapView.h"
#import <CoreLocation/CoreLocation.h>
#import "MMCAnnotationModel.h"

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) MMCMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManger;
@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mapView];
    [self showUserLocation];
    [self addMKPointAnnotation];
}

#pragma mark - 显示用户位置
- (void)showUserLocation {
    //申请权限
    if ([self.locationManger respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManger requestWhenInUseAuthorization];
    }
    //显示用户位置(跟踪用户位置)
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //显示用户位置时设置默认显示范围
    [self.mapView setRegion:MKCoordinateRegionMake(self.mapView.userLocation.location.coordinate, MKCoordinateSpanMake(0.024, 0.017)) animated:YES];
}

#pragma mark - 添加大头针
- (void)addMKPointAnnotation {
    //添加系统定义的大头针
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] initWithCoordinate:self.mapView.userLocation.location.coordinate title:@"大头针" subtitle:@"MKPointAnnotation"];
    [self.mapView addAnnotation:pointAnnotation];
}

#pragma mark - touchBegin
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int annotationNum = 0;
    if (annotationNum >= 3) {
        return;
    }
    //获取点击的点
    CGPoint touchPoint = [[touches anyObject] locationInView:self.mapView];
    //将点转化为经纬度
    CLLocationCoordinate2D coordination = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    //添加用户自定义大头针
    MMCAnnotationModel *annotation = [[MMCAnnotationModel alloc] init];
    annotation.coordinate = coordination;
    annotation.title = @"aa";
    annotation.subtitle = @"bb";
    [self.mapView addAnnotation:annotation];
    annotationNum ++;
}

#pragma mark - mapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    //点击大头针，显示当前位置（需设置大头针视图的canShowCallout属性）
    [self.geoCoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            return ;
        }
        NSString *subtitleName = [NSString stringWithFormat:@"%@%@%@",placemarks.lastObject.administrativeArea,placemarks.lastObject.locality,placemarks.lastObject.subLocality];
        
        userLocation.title = placemarks.lastObject.name;
        userLocation.subtitle = subtitleName;
    }];
    //更新显示范围
    [self.mapView setRegion:MKCoordinateRegionMake(mapView.userLocation.location.coordinate, mapView.region.span) animated:YES];
}

//在添加大头针时调用，且在图像出现之前调用
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    for (MKAnnotationView *annotationView in views) {
        if ([annotationView.annotation isKindOfClass:[MKUserLocation class]]) {
            return;
        }
        //记录原位置
        CGRect frame = annotationView.frame;
        //更改view的y值
        annotationView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
        //设置动画
        [UIView animateWithDuration:0.5 animations:^{
            annotationView.frame = frame;
        }];
    }
}

//添加大头针视图  当添加大头针时，该方法被自动调用
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"MKAnnotationViewIdentifier";
    //系统自定义的大头针模型
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (!pinAnnotationView) {
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pinAnnotationView.canShowCallout = YES;
            pinAnnotationView.pinTintColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
            pinAnnotationView.animatesDrop = YES;
        }
        return pinAnnotationView;
    }
    //用户自定义的大头针模型
    if ([annotation isKindOfClass:[MMCAnnotationModel class]]) {
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.image = [UIImage imageNamed:@"annotation"];
        }
        return annotationView;
    }
    //不需要自定义，完全由系统处理
    return nil;
}

//地图范围改变时调用
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
}

#pragma mark - lazy
- (MMCMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MMCMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        _mapView.zoomEnabled = YES;
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.showsScale = YES;
    }
    return _mapView;
}

- (CLLocationManager *)locationManger {
    if (!_locationManger) {
        _locationManger = [[CLLocationManager alloc] init];
    }
    return _locationManger;
}

- (CLGeocoder *)geoCoder {
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

@end
