//
//  ViewController.m
//  MTMapViewDemo
//
//  Created by 全先帅 on 2021/4/15.
//

#import "ViewController.h"
#import "MMCMapView.h"
#import <CoreLocation/CoreLocation.h>

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

//添加大头针视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"MKAnnotationViewIdentifier";
    MKAnnotationView *pinAnnotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pinAnnotationView) {
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] initWithCoordinate:self.mapView.userLocation.location.coordinate title:@"" subtitle:@""];
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:pointAnnotation reuseIdentifier:identifier];
        pinAnnotationView.canShowCallout = YES;
    }
    return pinAnnotationView;

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
