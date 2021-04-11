//
//  ReverseGeoCodeViewController.m
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import "ReverseGeoCodeViewController.h"

@interface ReverseGeoCodeViewController ()

@end

@implementation ReverseGeoCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationController];
}

#pragma mark - setNavigationController
- (void)setNavigationController {
    self.navigationItem.title = @"反向地理编码";
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
