//
//  CSFindCollectionViewManager.h
//  CongShi
//
//  Created by Archy on 16/1/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSStickySectionHeadersLayout.h"
@interface CSFindCollectionViewManager : NSObject<UICollectionViewDelegate,UICollectionViewDataSource,CSStickySectionHeadersLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableDictionary *attributes;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end
