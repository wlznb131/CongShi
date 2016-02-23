//
//  UIView+CSCategory.h
//  CongShi
//
//  Created by Archy on 15/12/18.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CSCategory)

@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGSize  size;

@end

@interface UIView (ViewHiarachy)

@property (readonly, nonatomic) UIViewController *viewController;

- (void)removeAllSubviews;

@end

@interface UIView (Gesture)

- (void)addTapAction:(SEL)tapAction target:(id)target;

@end

@interface UIView (separatorLine)

+ (UIView *)seperatorLineWithRect:(CGRect)rect andColor:(UIColor *)color;

@end

@interface UISlider(QuickCreate)

+ (UISlider *)newSliderWithFrame:(CGRect)frame maximumValue:(float)maximumValue minimumValue:(float)minimumValue value:(float)value setValue:(float)setValue target:(id)target andAction:(SEL)sel;

+ (UISlider *)newSliderwithMaximumValue:(float)maximumValue minimumValue:(float)minimumValue value:(float)value setValue:(float)setValue target:(id)target andAction:(SEL)sel;

@end

@interface UILabel (QuickCreate)

+ (UILabel *)newLabelWithFrame:(CGRect)frame alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor andFont:(UIFont *)font;

+ (UILabel *)newlabelWithAlignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor
                           andFont:(UIFont *)font;

@end

@interface UIButton (QuickCreate)

+ (UIButton *)newButtonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title target:(id)target andAction:(SEL)sel;

+ (UIButton *)newButtonWithType:(UIButtonType)type target:(id)target andAction:(SEL)sel;

@end

@interface UITextField (QuickCreate)

+ (UITextField *)newTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder textAlignment:(NSTextAlignment)textAlignment secureTextEntry:(BOOL)secureTextEntry keyboardType:(UIKeyboardType)keyboardType;

+ (UITextField *)newTextFieldPlaceHolder:(NSString *)placeHolder textAlignment:(NSTextAlignment)textAlignment secureTextEntry:(BOOL)secureTextEntry keyboardType:(UIKeyboardType)keyboardType;

@end

@interface UIImageView (QuickCreate)

+ (UIImageView *)newImageViewWithFrame:(CGRect)frame withImageNamed:(NSString *)image;

+ (UIImageView *)newImageViewWithImageNamed:(NSString *)name;

@end

@interface UIBarButtonItem (QuickCreate)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target andAction:(SEL)action;

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedName target:(id)target action:(SEL)action;

@end