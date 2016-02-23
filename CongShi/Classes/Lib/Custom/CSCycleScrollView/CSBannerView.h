//
//  CSBannerView.h
//  CongShi
//
//  Created by Archy on 16/1/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBannerFooter.h"
@protocol CSBannerViewDataSource, CSBannerViewDelegate;

@interface CSBannerView : UICollectionReusableView

/** 是否需要循环滚动, 默认为 NO */
@property (nonatomic, assign) IBInspectable BOOL shouldLoop;

/** 是否显示footer, 默认为 NO (此属性为YES时, shouldLoop会被置为NO) */
@property (nonatomic, assign) IBInspectable BOOL showFooter;

/** 是否自动滑动, 默认为 NO */
@property (nonatomic, assign) IBInspectable BOOL autoScroll;

/** 自动滑动间隔时间(s), 默认为 3.0 */
@property (nonatomic, assign) IBInspectable NSTimeInterval scrollInterval;

/** pageControl, 可自由配置其属性 */
@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, weak) IBOutlet id<CSBannerViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<CSBannerViewDelegate> delegate;

- (void)reloadData;
- (void)startTimer;
- (void)stopTimer;

@end

@protocol CSBannerViewDataSource <NSObject>

@required

- (NSInteger)numberOfItemsInBanner:(CSBannerView *)banner;
- (UIView *)banner:(CSBannerView *)banner viewForItemAtIndex:(NSInteger)index;

@optional

- (NSString *)banner:(CSBannerView *)banner titleForFooterWithState:(CSBannerFooterState)footerState;

@end

@protocol CSBannerViewDelegate <NSObject>
@optional

- (void)banner:(CSBannerView *)banner didSelectItemAtIndex:(NSInteger)index;
- (void)bannerFooterDidTrigger:(CSBannerView *)banner;

@end

