//
//  CSStickySectionHeadersLayout.h
//  CongShi
//
//  Created by Archy on 16/1/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSStickySectionHeadersLayout;
@protocol CSStickySectionHeadersLayoutDelegate <UICollectionViewDelegateFlowLayout>

@optional
- (BOOL)stickySectionHeadesLayout:(CSStickySectionHeadersLayout *)layout shouldStickHeaderToTopInSection:(NSUInteger)section;

@end

@interface CSStickySectionHeadersLayout : UICollectionViewFlowLayout

@end
