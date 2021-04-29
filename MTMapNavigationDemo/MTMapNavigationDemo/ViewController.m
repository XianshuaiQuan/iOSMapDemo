//
//  ViewController.m
//  MTMapNavigationDemo
//
//  Created by 全先帅 on 2021/4/29.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) UILabel *destinationLabel;
@property (nonatomic, strong) UITextField *destinationTextField;
@property (nonatomic, strong) UIButton *navigationButton;
@property (nonatomic, strong) UIButton *drawRoad;

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    [self loadSubviews];
}

#pragma mark - navigationController
- (void)setNavigationController {
    self.navigationItem.title = @"地图导航";
}

#pragma mark - loadSubviews
- (void)loadSubviews {
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.destinationLabel];
    [self.view addSubview:self.destinationTextField];
    [self.view addSubview:self.navigationButton];
    [self.view addSubview:self.drawRoad];
}

#pragma mark - beginNavigation
- (void)beginNavigation {
    //通过正向地理编码，获取用户输入位置
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.destinationTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            return;
        }
        
        CLPlacemark* placeMark = placemarks.lastObject;
        
        //创建MKPlaceMark对象
        MKPlacemark *mkplaceMark = [[MKPlacemark alloc] initWithPlacemark:placeMark];
        
        //创建MKItem
        MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:mkplaceMark];
        
        //调用open方法（跳转到导航app）
        [MKMapItem openMapsWithItems:@[destination] launchOptions:nil];
    }];
   
}

- (void)beginDrawRoad {
    //通过正向地理编码，获取用户输入位置
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.destinationTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            return;
        }
        
        CLPlacemark* placeMark = placemarks.lastObject;
        
        //创建MKPlaceMark对象
        MKPlacemark *mkplaceMark = [[MKPlacemark alloc] initWithPlacemark:placeMark];
        
        //起点位置
        MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
        
        //创建MKItem
        MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:mkplaceMark];
        
        //画线
        
        //创建方向请求对象
        MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
        //设置起点
        directionRequest.source = sourceItem;
        //设置重终点
        directionRequest.destination = destinationItem;
        //创建方向对象
        MKDirections *directions = [[MKDirections alloc] initWithRequest:directionRequest];
        //计算两点之间的路线
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            if (response.routes.count == 0 || error) {
                return ;
            }
            //获取路线信息
            for (MKRoute *route in response.routes) {
                //获取折现(多段线)
                MKPolyline *polyline = route.polyline;
                //添加覆盖物(需要加渲染才能显示)
                [self.mapView addOverlay:polyline];
            }
            
        }];
        
    }];
}

#pragma mark - 设置渲染物
//为地图添加遮盖物时调用此方法
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    //创建渲染物对象
    MKPolylineRenderer *polyline = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    //设置颜色
    polyline.strokeColor = [UIColor redColor];
    
    return polyline;
}


#pragma mark - lazy
- (UILabel *)destinationLabel {
    if (!_destinationLabel) {
        _destinationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 150, 50)];
        _destinationLabel.text = @"请输入目的地:";
        _destinationLabel.font = [UIFont systemFontOfSize:20];
//        _destinationLabel.backgroundColor = [UIColor greenColor];
    }
    return _destinationLabel;
}

- (UITextField *)destinationTextField {
    if (!_destinationTextField) {
        _destinationTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.destinationLabel.frame), 100, self.view.frame.size.width - CGRectGetMaxX(self.destinationLabel.frame) - 20, 50)];
        _destinationTextField.font = [UIFont systemFontOfSize:20];
        _destinationTextField.borderStyle = UITextBorderStyleRoundedRect;
        _destinationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _destinationTextField.backgroundColor = [UIColor greenColor];
    }
    return _destinationTextField;
}

- (UIButton *)navigationButton {
    if (!_navigationButton) {
        _navigationButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _navigationButton.frame = CGRectMake(40, CGRectGetMaxY(self.destinationLabel.frame) + 20, 150, 50);
        [_navigationButton setTitle:@"开始导航" forState:UIControlStateNormal];
        _navigationButton.titleLabel.font = [UIFont systemFontOfSize:25];
        [_navigationButton addTarget:self action:@selector(beginNavigation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationButton;
}

- (UIButton *)drawRoad {
    if (!_drawRoad) {
        _drawRoad = [UIButton buttonWithType:UIButtonTypeSystem];
        _drawRoad.frame = CGRectMake(CGRectGetMaxX(self.navigationButton.frame) + 30, CGRectGetMaxY(self.destinationLabel.frame) + 20, 150, 50);
        [_drawRoad setTitle:@"开始画线" forState:UIControlStateNormal];
        _drawRoad.titleLabel.font = [UIFont systemFontOfSize:25];
        [_drawRoad addTarget:self action:@selector(beginDrawRoad) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drawRoad;
}

- (MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
        _mapView.delegate = self;
    }
    return _mapView;
}

@end
