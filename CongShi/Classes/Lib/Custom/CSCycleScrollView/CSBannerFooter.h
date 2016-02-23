//
//  CSBannerFooter.h
//  CongShi
//
//  Created by Archy on 16/1/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CSBannerFooterState) {
    CSBannerFooterStateIdle = 0,    // 正常状态下的footer提示
    CSBannerFooterStateTrigger,     // 被拖至触发点的footer提示
};


@interface CSBannerFooter : UICollectionReusableView

@property (nonatomic, assign) CSBannerFooterState state;

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, copy) NSString *idleTitle;
@property (nonatomic, copy) NSString *triggerTitle;


@end
