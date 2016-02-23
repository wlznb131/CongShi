//
//  CSSegmentPageViewController.h
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSegmentPageControllerHeaderProtocol.h"
#import "CSSegmentPageHeader.h"
#import "CSSegmentControllerDelegate.h"
#import "CSSegmentView.h"

@interface CSSegmentPageViewController : UIViewController

@property (nonatomic, strong) CSSegmentView *segmentView;
@property (nonatomic, assign) CGFloat segmentHeight;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat segmentMiniTopInset;
@property (nonatomic, assign, readonly) CGFloat segmentToInset;

@property (nonatomic, weak, readonly) UIViewController<CSSegmentControllerDelegate> *currentDisplayController;

@property (nonatomic, strong, readonly) UIView<CSSegmentPageControllerHeaderProtocol> *headerView;

@property (nonatomic, assign) BOOL freezenHeaderWhenReachMaxHeaderHeight;

-(instancetype)initWithControllers:(UIViewController<CSSegmentControllerDelegate> *)controller,... NS_REQUIRES_NIL_TERMINATION;

-(void)setViewControllers:(NSArray *)viewControllers;

//override this method to custom your own header view
-(UIView <CSSegmentPageControllerHeaderProtocol> *)customHeaderView;

@end
