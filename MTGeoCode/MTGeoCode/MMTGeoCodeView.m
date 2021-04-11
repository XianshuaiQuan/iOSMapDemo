//
//  MMTGeoCodeView.m
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import "MMTGeoCodeView.h"
#import <Masonry/Masonry.h>

@interface MMTGeoCodeView()

@property (nonatomic, strong) UITextField *adressTextFild;
@property (nonatomic, strong) UIButton *geoCodeButton;
@property (nonatomic, strong) UILabel *latName;
@property (nonatomic, strong) UILabel *latValue;
@property (nonatomic, strong) UILabel *logName;
@property (nonatomic, strong) UILabel *logValue;
@property (nonatomic, strong) UILabel *detailAdressName;
@property (nonatomic, strong) UILabel *detailAdressValue;

@end

@implementation MMTGeoCodeView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubviews];
        [self loadSubViews];
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
    
}

#pragma mark - lazy
- (UITextField *)adressTextFild {
    if (!_adressTextFild) {
        _adressTextFild = [[UITextField alloc] init];
        _adressTextFild.font = [UIFont systemFontOfSize:25];
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
    }
    return _latName;
}

- (UILabel *)latValue {
    if (!_latValue) {
        _latValue = [[UILabel alloc] init];
        _latValue.font = [UIFont systemFontOfSize:25];
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
    }
    return _detailAdressValue;
}
@end
