//
//  MMTGeoCodeView.h
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMTGeoCodeView : UIView

@property (nonatomic, strong) UITextField *adressTextFild;
@property (nonatomic, strong) UILabel *latValue;
@property (nonatomic, strong) UIButton *geoCodeButton;
@property (nonatomic, strong) UILabel *detailAdressValue;
@property (nonatomic, strong) UILabel *logValue;

- (void)adverseGeoCodeWithLat:(CGFloat)lat andLog:(CGFloat)log andAdressName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
