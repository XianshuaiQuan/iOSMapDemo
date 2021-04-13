//
//  MMTReverseGeoCodeView.m
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import "MMTReverseGeoCodeView.h"
#import <Masonry/Masonry.h>
#import <CoreLocation/CoreLocation.h>

@interface MMTReverseGeoCodeView()

@property (nonatomic, strong) UILabel *latName;
@property (nonatomic, strong) UILabel *logName;
@property (nonatomic, strong) UITextField *latValue;
@property (nonatomic, strong) UITextField *logVlaue;
@property (nonatomic, strong) UILabel *cityName;
@property (nonatomic, strong) UILabel *cityValue;
@property (nonatomic, strong) UILabel *detailAdressName;
@property (nonatomic, strong) UILabel *detailAdressValue;

@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

@implementation MMTReverseGeoCodeView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
        [self layoutSubviews];
    }
    return self;
}

#pragma mark - loadSubViews
- (void)loadSubViews {
    [self addSubview:self.cityName];
    [self addSubview:self.cityValue];
    [self addSubview:self.detailAdressName];
    [self addSubview:self.detailAdressValue];
    [self addSubview:self.latName];
    [self addSubview:self.latValue];
    [self addSubview:self.logName];
    [self addSubview:self.logVlaue];
    [self addSubview:self.reverseGeoCoder];
}

#pragma mark - layoutSubViews
- (void)layoutSubviews {
    [self.latName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(120);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(160, 50));
    }];
    
    [self.latValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(120);
        make.left.mas_equalTo(self.latName.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    [self.logName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.latName.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(160, 50));
    }];
    
    [self.logVlaue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.latValue.mas_bottom).offset(30);
        make.left.mas_equalTo(self.logName.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    [self.reverseGeoCoder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logName.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
    
    [self.cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.reverseGeoCoder.mas_bottom).offset(50);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    
    [self.cityValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.reverseGeoCoder.mas_bottom).offset(50);
        make.left.mas_equalTo(self.cityName.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    [self.detailAdressName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cityName.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(160, 50));
    }];
    
    [self.detailAdressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cityValue.mas_bottom).offset(30);
        make.left.mas_equalTo(self.detailAdressName.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
}

#pragma mark - buttonAction
- (void)reverseGeoCoding {
    double lat = [self.latValue.text doubleValue];
    double log = [self.logVlaue.text doubleValue];
    CLLocation *location =[[CLLocation alloc] initWithLatitude:(lat?:0) longitude:(log?:0)];
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!placemarks.count || error) {
            self.detailAdressValue.text = @"解析出错";
            return;
        }
        for (CLPlacemark *placemark in placemarks) {
            self.cityValue.text = placemark.locality;
            self.detailAdressValue.text = placemark.name;
        }
        
    }];
}

#pragma mark - lazy
- (UILabel *)latName {
    if (!_latName) {
        _latName = [[UILabel alloc] init];
        _latName.font = [UIFont systemFontOfSize:25];
        _latName.text = @"请输入经度：";
//        _latName.backgroundColor = [UIColor greenColor];
    }
    return _latName;
}

- (UILabel *)logName {
    if (!_logName) {
        _logName = [[UILabel alloc] init];
        _logName.font = [UIFont systemFontOfSize:25];
        _logName.text = @"请输入维度：";
//        _logName.backgroundColor = [UIColor greenColor];
    }
    return _logName;
}

- (UITextField *)latValue {
    if (!_latValue) {
        _latValue = [[UITextField alloc] init];
        _latValue.font = [UIFont systemFontOfSize:25];
        _latValue.clearButtonMode = UITextFieldViewModeWhileEditing;
        _latValue.borderStyle = UITextBorderStyleRoundedRect;
//        _latValue.backgroundColor = [UIColor greenColor];
    }
    return _latValue;
}

- (UITextField *)logVlaue {
    if (!_logVlaue) {
        _logVlaue = [[UITextField alloc] init];
        _logVlaue.font = [UIFont systemFontOfSize:25];
        _logVlaue.clearButtonMode = UITextFieldViewModeWhileEditing;
        _logVlaue.borderStyle = UITextBorderStyleRoundedRect;
//        _logVlaue.backgroundColor = [UIColor greenColor];
    }
    return _logVlaue;
}

- (UIButton *)reverseGeoCoder {
    if (!_reverseGeoCoder) {
        _reverseGeoCoder = [UIButton buttonWithType:UIButtonTypeSystem];
        [_reverseGeoCoder setTitle:@"反向地理编码" forState:UIControlStateNormal];
        [_reverseGeoCoder setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _reverseGeoCoder.titleLabel.font = [UIFont systemFontOfSize:25];
    }
    return _reverseGeoCoder;
}

- (UILabel *)cityName {
    if (!_cityName) {
        _cityName = [[UILabel alloc] init];
        _cityName.font = [UIFont systemFontOfSize:25];
        _cityName.text = @"城市：";
//        _cityName.backgroundColor = [UIColor greenColor];
    }
    return _cityName;
}

- (UILabel *)detailAdressName {
    if (!_detailAdressName) {
        _detailAdressName = [[UILabel alloc] init];
        _detailAdressName.font = [UIFont systemFontOfSize:25];
        _detailAdressName.text = @"详细地址：";
//        _detailAdressName.backgroundColor = [UIColor greenColor];
    }
    return _detailAdressName;
}

- (UILabel *)cityValue {
    if (!_cityValue) {
        _cityValue = [[UILabel alloc] init];
        _cityValue.font = [UIFont systemFontOfSize:25];
//        _cityValue.backgroundColor = [UIColor greenColor];
    }
    return _cityValue;
}

- (UILabel *)detailAdressValue {
    if (!_detailAdressValue) {
        _detailAdressValue = [[UILabel alloc] init];
        _detailAdressValue.font = [UIFont systemFontOfSize:25];
        _detailAdressValue.numberOfLines = 0;
//        _detailAdressValue.backgroundColor = [UIColor greenColor];
    }
    return _detailAdressValue;
}

- (CLGeocoder *)geoCoder {
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}
@end
