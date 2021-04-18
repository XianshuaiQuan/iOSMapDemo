//
//  MMCMapView.m
//  MTMapViewDemo
//
//  Created by 全先帅 on 2021/4/15.
//

#import "MMCMapView.h"

@interface MMCMapView()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIButton *myLocationButton;
@property (nonatomic, strong) UIButton *largerButton;
@property (nonatomic, strong) UIButton *smallerButton;

@end

@implementation MMCMapView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

#pragma mark - loadsubviews
- (void)loadSubViews {
    [self addSubview:self.segmentedControl];
    [self addSubview:self.myLocationButton];
    [self addSubview:self.largerButton];
    [self addSubview:self.smallerButton];
}

/**
 MKMapTypeStandard = 0,
 MKMapTypeSatellite,
 MKMapTypeHybrid,
 MKMapTypeSatelliteFlyover NS_ENUM_AVAILABLE(10_11, 9_0),
 MKMapTypeHybridFlyover NS_ENUM_AVAILABLE(10_11, 9_0),
 MKMapTypeMutedStandard NS_ENUM_AVAILABLE(10_13, 11_0) __TVOS_AVAILABLE(11_0),
 */
#pragma mark - segmentEventValueChanged
- (void)segmentEventValueChanged {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

#pragma mark - 按钮事件
- (void)backToMyLocation {
    //设置中心点坐标
    [self setCenterCoordinate:self.userLocation.location.coordinate animated:YES];
    //设置范围
    [self setRegion:MKCoordinateRegionMake(self.userLocation.location.coordinate, MKCoordinateSpanMake(0.024, 0.017)) animated:YES];
}

- (void)becomeLarger {
    [self setRegion:MKCoordinateRegionMake(self.userLocation.coordinate, MKCoordinateSpanMake(self.region.span.latitudeDelta * 0.5, self.region.span.longitudeDelta * 0.5)) animated:YES];
}

- (void)becomeSmaller {
    [self setRegion:MKCoordinateRegionMake(self.userLocation.location.coordinate, MKCoordinateSpanMake(self.region.span.latitudeDelta * 2,self.region.span.longitudeDelta * 2)) animated:YES];
}

#pragma mark - lazy
- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"标准地图",@"卫星云图",@"混合地图"]];
        _segmentedControl.frame = CGRectMake(0, 100, 300, 50);
        NSDictionary *titleAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
        [_segmentedControl setTitleTextAttributes:titleAttributes forState:UIControlStateNormal];
        _segmentedControl.backgroundColor = [UIColor systemGray5Color];
        
        [_segmentedControl addTarget:self action:@selector(segmentEventValueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (UIButton *)myLocationButton {
    if (!_myLocationButton) {
        _myLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _myLocationButton.frame = CGRectMake(10, CGRectGetMaxY(self.segmentedControl.frame) + 30, 50, 50);
        [_myLocationButton setImage:[UIImage imageNamed:@"myLocation"] forState:UIControlStateNormal];
        
        [_myLocationButton addTarget:self action:@selector(backToMyLocation) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _myLocationButton;
}

- (UIButton *)largerButton {
    if (!_largerButton) {
        _largerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _largerButton.frame = CGRectMake(10, CGRectGetMaxY(self.myLocationButton.frame) + 30, 50, 50);
        [_largerButton setImage:[UIImage imageNamed:@"larger"] forState:UIControlStateNormal];
        
        [_largerButton addTarget:self action:@selector(becomeLarger) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _largerButton;
}

- (UIButton *)smallerButton {
    if (!_smallerButton) {
        _smallerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _smallerButton.frame = CGRectMake(10, CGRectGetMaxY(self.largerButton.frame) + 30, 50, 50);
        [_smallerButton setImage:[UIImage imageNamed:@"smaller"] forState:UIControlStateNormal];
        
        [_smallerButton addTarget:self action:@selector(becomeSmaller) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _smallerButton;
}
@end
