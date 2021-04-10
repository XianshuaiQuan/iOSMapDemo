//
//  ViewController.m
//  MTLocationOnce
//
//  Created by 全先帅 on 2021/4/10.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManger;
@property (nonatomic, strong) UILabel *latLogLabel;
@property (nonatomic, strong) UIButton *latlogButton;
@property (nonatomic, strong) CLLocation *location;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.latLogLabel];
    [self.view addSubview:self.latlogButton];
    
    [self locationOnce];
    
    
}

#pragma mark - 实现一次定位
- (void)locationOnce {
    //1、创建locationManger对象
    
    //2、请求用户授权(ios8开始要配置plist文件)
    //先判断self.locationManger是否有requestWhenInUseAuthorization方法
    if ([self.locationManger respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManger requestWhenInUseAuthorization];
    }
    
    //3、设置代理
    self.locationManger.delegate = self;
    
    //4、调用开始定位方法
    [self.locationManger startUpdatingLocation];
    
}

- (void)getLatlog {
    self.latLogLabel.text = [NSString stringWithFormat:@"经度：%f \n纬度：%f",self.location.coordinate.latitude,self.location.coordinate.longitude];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.location = locations.lastObject;
    NSLog(@"locations:%@",self.location);
}

#pragma mark - lazy
- (CLLocationManager *)locationManger {
    if (!_locationManger) {
        _locationManger = [[CLLocationManager alloc] init];
    }
    return _locationManger;
}

- (UILabel *)latLogLabel {
    if (!_latLogLabel) {
        _latLogLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,150, self.view.frame.size.width - 40, 200)];
        _latLogLabel.numberOfLines = 0;
        _latLogLabel.font = [UIFont systemFontOfSize:30];
//        [_latLogLabel sizeToFit];
    }
    return _latLogLabel;
}

- (UIButton *)latlogButton {
    if (!_latlogButton) {
        _latlogButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _latlogButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(self.latLogLabel.frame) + 50, 200, 100);
        [_latlogButton setTitle:@"获取经纬度" forState:UIControlStateNormal];
        [_latlogButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _latlogButton.titleLabel.font = [UIFont systemFontOfSize:30];
        
        [_latlogButton addTarget:self action:@selector(getLatlog) forControlEvents:UIControlEventTouchUpInside];
    }
    return _latlogButton;
}

- (CLLocation *)location {
    if (!_location) {
        _location = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    }
    return _location;
}

@end
