//
//  ViewController.m
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import "GeoCodeViewController.h"
#import "ReverseGeoCodeViewController.h"
#import "MMTGeoCodeView.h"
#import <Masonry/Masonry.h>
#import <CoreLocation/CoreLocation.h>

@interface GeoCodeViewController ()

@property (nonatomic, strong) ReverseGeoCodeViewController *reverseViewController;
@property (nonatomic, strong) MMTGeoCodeView *geoCodeView;

@end

@implementation GeoCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    
    [self loadSubViews];
}

#pragma mark - loadSubViews
- (void)loadSubViews {
    [self.view addSubview:self.geoCodeView];
    [self.geoCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
}

#pragma mark - navigationController
- (void)setNavigationController {
    self.navigationItem.title = @"正向地理编码";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStyleDone target:self action:@selector(pushViewController)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)pushViewController {
    [self.navigationController pushViewController:self.reverseViewController animated:NO];
}

#pragma mark - geoCodeViewButton
- (void)geoCodeViewButton {
    [self.geoCodeView adverseGeoCoding];
    [self.geoCodeView endEditing:YES];
}

#pragma mark - lazy
- (ReverseGeoCodeViewController *)reverseViewController {
    if (!_reverseViewController) {
        _reverseViewController = [[ReverseGeoCodeViewController alloc] init];
    }
    return _reverseViewController;
}

- (MMTGeoCodeView *)geoCodeView {
    if (!_geoCodeView) {
        _geoCodeView = [[MMTGeoCodeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [_geoCodeView.geoCodeButton addTarget:self action:@selector(geoCodeViewButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _geoCodeView;
}

@end
