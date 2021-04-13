//
//  MMTGeoCodeView.h
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMTGeoCodeView : UIView

@property (nonatomic, strong) UIButton *geoCodeButton;

- (void)adverseGeoCoding;

@end

NS_ASSUME_NONNULL_END
