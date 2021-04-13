//
//  ReverseGeoCodeViewController.m
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import "ReverseGeoCodeViewController.h"
#import "MMTReverseGeoCodeView.h"
#import <Masonry/Masonry.h>

@interface ReverseGeoCodeViewController ()

@property (nonatomic, strong) MMTReverseGeoCodeView *reverseGeoCoderView;

@end

@implementation ReverseGeoCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
    
    [self.view addSubview:self.reverseGeoCoderView];
    [self.reverseGeoCoderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
    }];
}

#pragma mark - setNavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"反向地理编码";
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - buttonActon
- (void)buttonAction {
    [self.reverseGeoCoderView reverseGeoCoding];
    [self.reverseGeoCoderView endEditing:YES];
}

#pragma mark - lazy
- (MMTReverseGeoCodeView *)reverseGeoCoderView {
    if (!_reverseGeoCoderView) {
        _reverseGeoCoderView = [[MMTReverseGeoCodeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [_reverseGeoCoderView.reverseGeoCoder addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reverseGeoCoderView;
}

@end
