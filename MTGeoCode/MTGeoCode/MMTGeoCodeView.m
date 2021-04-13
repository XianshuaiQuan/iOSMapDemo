//
//  MMTGeoCodeView.m
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import "MMTGeoCodeView.h"
#import <Masonry/Masonry.h>
#import <CoreLocation/CoreLocation.h>

@interface MMTGeoCodeView()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *adressTextFild;
@property (nonatomic, strong) UILabel *latValue;
@property (nonatomic, strong) UILabel *detailAdressValue;
@property (nonatomic, strong) UILabel *logValue;
@property (nonatomic, strong) UILabel *latName;
@property (nonatomic, strong) UILabel *logName;
@property (nonatomic, strong) UILabel *detailAdressName;

@property (nonatomic, strong) CLGeocoder *geoCoder;

@end

@implementation MMTGeoCodeView
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
    [self addSubview:self.adressTextFild];
    [self addSubview:self.geoCodeButton];
    [self addSubview:self.latName];
    [self addSubview:self.latValue];
    [self addSubview:self.logName];
    [self addSubview:self.logValue];
    [self addSubview:self.detailAdressName];
    [self addSubview:self.detailAdressValue];
}

#pragma mark - layoutSubViews
- (void)layoutSubviews {
    [self.adressTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(100);
    }];
    
    [self.geoCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.adressTextFild.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.adressTextFild.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
    
    [self.latName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.geoCodeButton.mas_bottom).offset(50);
        make.left.mas_equalTo(self.adressTextFild.mas_left);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    
    [self.latValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.geoCodeButton.mas_bottom).offset(50);
        make.left.mas_equalTo(self.latName.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    [self.logName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.latName.mas_bottom).offset(50);
        make.left.mas_equalTo(self.latName.mas_left);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    
    [self.logValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.latValue.mas_bottom).offset(50);
        make.left.mas_equalTo(self.logName.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    [self.detailAdressName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logName.mas_bottom).offset(50);
        make.left.mas_equalTo(self.logName.mas_left);
        make.size.mas_equalTo(CGSizeMake(140, 50));
    }];
    
    [self.detailAdressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logValue.mas_bottom).offset(50);
        make.left.mas_equalTo(self.detailAdressName.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    
    [self layoutIfNeeded];
    
}

#pragma mark - buttonAction
- (void)adverseGeoCoding {
    [self.geoCoder geocodeAddressString:self.adressTextFild.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            NSLog(@"解析出错");
            self.detailAdressValue.text = @"解析出错";
            return;
        }
        for (CLPlacemark *placemark in placemarks) {
            CLLocation *location = placemark.location;
            self.latValue.text = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            self.logValue.text = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            self.detailAdressValue.text = placemark.name;
        }
    }];
}

#pragma mark - lazy
- (UITextField *)adressTextFild {
    if (!_adressTextFild) {
        _adressTextFild = [[UITextField alloc] init];
        _adressTextFild.font = [UIFont systemFontOfSize:25];
        _adressTextFild.placeholder = @"请输入地址";
        _adressTextFild.borderStyle = UITextBorderStyleRoundedRect;
        _adressTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _adressTextFild.keyboardType = UIKeyboardTypeDefault;
        _adressTextFild.delegate = self;
        
    }
    return _adressTextFild;
}

- (UIButton *)geoCodeButton {
    if (!_geoCodeButton) {
        _geoCodeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_geoCodeButton setTitle:@"正向地理编码" forState:UIControlStateNormal];
        _geoCodeButton.titleLabel.font = [UIFont systemFontOfSize:25];
    }
    return _geoCodeButton;
}

- (UILabel *)latName {
    if (!_latName) {
        _latName = [[UILabel alloc] init];
        _latName.text = @"经度：";
        _latName.font = [UIFont systemFontOfSize:25];
//        _latName.backgroundColor = [UIColor yellowColor];
    }
    return _latName;
}

- (UILabel *)latValue {
    if (!_latValue) {
        _latValue = [[UILabel alloc] init];
        _latValue.font = [UIFont systemFontOfSize:25];
//        _latValue.backgroundColor = [UIColor greenColor];
    }
    return _latValue;
}

- (UILabel *)logName {
    if (!_logName) {
        _logName = [[UILabel alloc] init];
        _logName.text = @"纬度：";
        _logName.font = [UIFont systemFontOfSize:25];
    }
    return _logName;
}

- (UILabel *)logValue {
    if (!_logValue) {
        _logValue = [[UILabel alloc] init];
        _logValue.font = [UIFont systemFontOfSize:25];
//        _logValue.backgroundColor = [UIColor greenColor];
    }
    return _logValue;
}

- (UILabel *)detailAdressName {
    if (!_detailAdressName) {
        _detailAdressName = [[UILabel alloc] init];
        _detailAdressName.text = @"详细地址：";
        _detailAdressName.font = [UIFont systemFontOfSize:25];
    }
    return _detailAdressName;
}

- (UILabel *)detailAdressValue {
    if (!_detailAdressValue) {
        _detailAdressValue = [[UILabel alloc] init];
        _detailAdressValue.font = [UIFont systemFontOfSize:25];
        _detailAdressValue.numberOfLines = 0;
        _detailAdressValue.textAlignment = NSTextAlignmentJustified;
        
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
