//
//  CSBaseViewController.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSBaseViewController : UIViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
