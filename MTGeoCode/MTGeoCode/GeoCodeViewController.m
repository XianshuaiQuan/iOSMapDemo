//
//  ViewController.m
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import "GeoCodeViewController.h"
#import "ReverseGeoCodeViewController.h"

@interface GeoCodeViewController ()

@property (nonatomic, strong) ReverseGeoCodeViewController *reverseViewController;

@end

@implementation GeoCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
}

#pragma mark - navigationController
- (void)setNavigationController {
    self.navigationItem.title = @"正向地理编码";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStyleDone target:self action:@selector(pushViewController)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)pushViewController {
    [self.navigationController pushViewController:self.reverseViewController animated:YES];
}

#pragma mark - lazy
- (ReverseGeoCodeViewController *)reverseViewController {
    if (!_reverseViewController) {
        _reverseViewController = [[ReverseGeoCodeViewController alloc] init];
    }
    return _reverseViewController;
}

@end
