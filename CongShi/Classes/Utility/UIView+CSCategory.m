//
//  UIView+CSCategory.m
//  CongShi
//
//  Created by Archy on 15/12/18.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "UIView+CSCategory.h"

@implementation UIView (CSCategory)

- (void)setTop:(CGFloat)top
{
    self.frame = CGRectMake(self.left, top, self.width, self.height);
}
- (CGFloat)top
{
    return self.y;
}
- (void)setBottom:(CGFloat)bottom
{
    self.frame = CGRectMake(self.left, bottom - self.height, self.width, self.height);
}
- (CGFloat)bottom
{
    return self.y + self.height;
}
- (void)setLeft:(CGFloat)left
{
    self.frame = CGRectMake(left, self.top, self.width, self.height);
}
- (CGFloat)left
{
    return self.x;
}
- (void)setRight:(CGFloat)right
{
    self.frame = CGRectMake(right - self.width, self.top, self.width, self.height);
}
- (CGFloat)right
{
    return self.x + self.width;
}
- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.left, self.top, width, self.height);
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.left, self.top, self.width, height);
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setCenterX:(CGFloat)centerX
{
    self.frame = CGRectMake(centerX - self.width/2, self.top, self.width, self.height);
}
- (CGFloat)centerX
{
    return self.left + self.width /2;
}
- (void)setCenterY:(CGFloat)centerY
{
    self.frame = CGRectMake(self.left, centerY - self.height / 2, self.width, self.height);
}
- (CGFloat)centerY
{
    return self.top + self.height / 2;
}
- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}
- (CGSize)size
{
    return self.frame.size;
}

@end

@implementation UIView (ViewHiarachy)

- (UIViewController *)viewController
{
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)removeAllSubviews
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

@end


@implementation UIView (Gesture)

- (void)addTapAction:(SEL)tapAction target:(id)target
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:tapAction];
    
    [self addGestureRecognizer:gesture];
}

@end

@implementation UIView (separatorLine)

+ (UIView *)seperatorLineWithRect:(CGRect)rect andColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    return view;
}

@end

@implementation UISlider(QuickCreate)

+ (UISlider *)newSliderWithFrame:(CGRect)frame maximumValue:(float)maximumValue minimumValue:(float)minimumValue value:(float)value setValue:(float)setValue target:(id)target andAction:(SEL)sel
{
    UISlider *slider = [[UISlider alloc]initWithFrame:frame];
    slider.maximumValue = maximumValue;
    slider.minimumValue = minimumValue;
    slider.value = value;
    [slider setValue:setValue];
    [slider addTarget:target action:sel forControlEvents:UIControlEventValueChanged];
    return slider;
}

+ (UISlider *)newSliderwithMaximumValue:(float)maximumValue minimumValue:(float)minimumValue value:(float)value setValue:(float)setValue target:(id)target andAction:(SEL)sel
{
    UISlider *slider = [[UISlider alloc] init];
    slider.maximumValue = maximumValue;
    slider.minimumValue = minimumValue;
    slider.value = value;
    [slider setValue:setValue];
    [slider addTarget:target action:sel forControlEvents:UIControlEventValueChanged];
    return slider;
}

@end

@implementation UILabel(QuickCreate)

+ (UILabel *)newLabelWithFrame:(CGRect)frame alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor andFont:(UIFont *)font
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textAlignment = alignment;
    label.textColor = textColor;
    label.font = font;
    return label;
}

+ (UILabel *)newlabelWithAlignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor
                           andFont:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = alignment;
    label.textColor = textColor;
    label.font = font;
    return label;
}

@end


@implementation UIButton(QuickCreate)

+ (UIButton *)newButtonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title target:(id)target andAction:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)newButtonWithType:(UIButtonType)type target:(id)target andAction:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:type];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end

@implementation UITextField(QuickCreate)

+(UITextField *)newTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder textAlignment:(NSTextAlignment)textAlignment secureTextEntry:(BOOL)secureTextEntry keyboardType:(UIKeyboardType)keyboardType
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeHolder;
    textField.textAlignment = textAlignment;
    textField.secureTextEntry = secureTextEntry;
    textField.keyboardType = keyboardType;
    return textField;
}

+(UITextField *)newTextFieldPlaceHolder:(NSString *)placeHolder textAlignment:(NSTextAlignment)textAlignment secureTextEntry:(BOOL)secureTextEntry keyboardType:(UIKeyboardType)keyboardType
{
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = placeHolder;
    textField.textAlignment = textAlignment;
    textField.secureTextEntry = secureTextEntry;
    textField.keyboardType = keyboardType;
    return textField;
}

@end

@implementation UIImageView (QuickCreate)

+(UIImageView *)newImageViewWithFrame:(CGRect)frame withImageNamed:(NSString *)name
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return imageView;
}

+(UIImageView *)newImageViewWithImageNamed:(NSString *)name
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return imageView;
}

@end

@implementation UIBarButtonItem (QuickCreate)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target andAction:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
    
    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
