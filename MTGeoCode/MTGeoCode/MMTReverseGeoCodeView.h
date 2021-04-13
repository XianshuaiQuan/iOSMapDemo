//
//  MMTReverseGeoCodeView.h
//  MTGeoCode
//
//  Created by 全先帅 on 2021/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMTReverseGeoCodeView : UIView

@property (nonatomic, strong) UIButton *reverseGeoCoder;

- (void)reverseGeoCoding;

@end

NS_ASSUME_NONNULL_END
