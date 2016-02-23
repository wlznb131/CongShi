//
//  CSFindCollectionViewManager.m
//  CongShi
//
//  Created by Archy on 16/1/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSFindCollectionViewManager.h"
#import "CSBannerCollectionViewCell.h"
#import "CSHotCollectionViewCell.h"
#import "CSTopicCollectionViewCell.h"
#import "CSFavoriteCollectionViewCell.h"
#import "CSBannerView.h"
#import "CSFindObject.h"
#import "CSTagObject.h"
#import "CSTopicObject.h"
#import "CSCourseObject.h"
#import "CSCollectionSectionHeader.h"

#define kTabBarY [UIScreen mainScreen].bounds.size.height - 49.0


@interface CSFindCollectionViewManager ()<CSBannerViewDataSource,CSBannerViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) CSFindObject *findObject;
@property (nonatomic, assign) BOOL isScrollToDown;

@end

@implementation CSFindCollectionViewManager

- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    if (_collectionView) {
        [self configCollectionView:collectionView];
    }
}

- (void)configCollectionView:(UICollectionView *)collectionView;
{
    collectionView.delegate = self;
    collectionView.dataSource = self;
 
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView registerClass:[CSBannerCollectionViewCell class] forCellWithReuseIdentifier:@"banner"];
    [collectionView registerClass:[CSHotCollectionViewCell class] forCellWithReuseIdentifier:@"hot"];
    [collectionView registerClass:[CSTopicCollectionViewCell class] forCellWithReuseIdentifier:@"topic"];
    [collectionView registerClass:[CSFavoriteCollectionViewCell class] forCellWithReuseIdentifier:@"course"];
    [collectionView registerClass:[CSCollectionSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    {
    NSDictionary *dict = @{
                           @"banner":@[
                                   @{
                                       @"description":@"",
                                       @"name":@"first",
                                       @"picture":@""
                                       },
                                   @{
                                       @"description":@"",
                                       @"name":@"second",
                                       @"picture":@""
                                       },
                                   @{
                                       @"description":@"",
                                       @"name":@"third",
                                       @"picture":@""
                                       }
                                   ],
                           @"hot":@[
                                   @{
                                       @"name":@"手工",
                                       @"image":@"屏幕快照 2015-12-15 下午1.14.44"
                                       },
                                   @{
                                       @"name":@"音乐",
                                       @"image":@"a37e7d7d54c67fa0f4af925ba550d8b1"
                                       },
                                   @{
                                       @"name":@"厨艺",
                                       @"image":@"3616383107_82c3357eae_o-1"
                                       }
                                   ],
                           @"topic":@[
                                   @{
                                       @"description":@"",
                                       @"name":@"first",
                                       @"picture":@"db6d48ad4ca4947f1d5eac73e536d815",
                                       },
                                   @{
                                       @"description":@"",
                                       @"name":@"second",
                                       @"picture":@"98f18b14f676eed62f4a90dad8b9d003",
                                       },
                                   @{
                                       @"description":@"",
                                       @"name":@"third",
                                       @"picture":@"158863731bdf960341bb75fd7312834d",
                                       }
                                   ],
                           @"course":@[
                                   @{
                                       @"description":@"",
                                       @"name":@"first",
                                       @"picture":@"",
                                       @"attention":@123
                                       },
                                   @{
                                       @"description":@"",
                                       @"name":@"second",
                                       @"picture":@"",
                                       @"attention":@123
                                       },
                                   @{
                                       @"description":@"",
                                       @"name":@"third",
                                       @"picture":@"",
                                       @"attention":@123
                                       }
                                   ]
                           };
    CSFindObject *findObject = [CSFindObject mj_objectWithKeyValues:dict];
    
    self.findObject = findObject;
}
    [collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
            case 0:
            return 1;
            break;
        case 1:
            return self.findObject.hot.count;
            break;
        case 2:
            return self.findObject.topic.count;
            break;
        case 3:
            return self.findObject.course.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CSBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"banner" forIndexPath:indexPath];
        cell.bannerView.delegate = self;
        cell.bannerView.dataSource = self;
        return cell;
    } else if (indexPath.section == 1){
        CSHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hot" forIndexPath:indexPath];
        CSTagObject *object = self.findObject.hot[indexPath.item];
        UIImage *image = [[UIImage imageNamed:object.image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *newImage = [image boxblurImageWithBlur:0.1];
        cell.hotImage.image = newImage;
        cell.hotLabel.text = object.name;
        return cell;
    } else if (indexPath.section == 2) {
        CSTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topic" forIndexPath:indexPath];
        CSTopicObject *object = self.findObject.topic[indexPath.item];
        UIImage *image = [[UIImage imageNamed:object.picture] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *newImage = [image boxblurImageWithBlur:0.1];
        cell.topicImage.image = newImage;
        return cell;
    } else if (indexPath.section == 3) {
        CSFavoriteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"course" forIndexPath:indexPath];
        cell.favoriteImage = [UIImage imageNamed:[NSString stringWithFormat:@"image%03ld", (unsigned long)indexPath.item]];
        CGFloat yOffset = ((self.collectionView.contentOffset.y - cell.frame.origin.y) / ImageHeight) * ImageOffsetSpeed;
        cell.imageOffset = CGPointMake(0.0f, yOffset);
        return cell;
    } else {
        return nil;
    }
}

- (NSInteger)numberOfItemsInBanner:(CSBannerView *)banner
{
    return 3;
}

- (UIView *)banner:(CSBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CSAPP_WIDTH, CSLayoutHeight(312))];
    view.contentMode = UIViewContentModeScaleAspectFill;
    view.image = [[UIImage imageNamed:[NSString stringWithFormat:@"image%03ld", (unsigned long)index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return view;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CSCollectionSectionHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            view.sectionLabel.text = @"";
            break;
            case 1:
            view.sectionLabel.text = @"热门标签 >";
            break;
            case 2:
            view.sectionLabel.text = @"从师专题 >";
            break;
            case 3:
            view.sectionLabel.text = @"从师授课 >";
            break;
        default:
            break;
    }
    view.backgroundColor = CSBackgroundColor;
    return view;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            case 0:
            return CGSizeMake(CSAPP_WIDTH, CSLayoutHeight(312));
            break;
        case 1:
            return CGSizeMake((CSAPP_WIDTH - 2)/3.0, (CSAPP_WIDTH - 2)/3.0);
            break;
        case 2:
            return CGSizeMake(CSAPP_WIDTH, CSLayoutHeight(90));
        case 3:
            return CGSizeMake(CSAPP_WIDTH, 320);
        default:
            return CGSizeZero;
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CSAPP_WIDTH, CSLayoutHeight(45));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

#pragma mark - CSStickySectionHeadersLayoutDelegate
/**
 *  组头是否悬停
 */
- (BOOL)stickySectionHeadesLayout:(CSStickySectionHeadersLayout *)layout shouldStickHeaderToTopInSection:(NSUInteger)section
{
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        if ([cell isKindOfClass:[CSFavoriteCollectionViewCell class]]) {
            CSFavoriteCollectionViewCell *newCell = (CSFavoriteCollectionViewCell *)cell;
            CGFloat yOffset = ((self.collectionView.contentOffset.y - cell.frame.origin.y) / ImageHeight) * ImageOffsetSpeed;
            newCell.imageOffset = CGPointMake(0.0f, yOffset);
        }
    }
    
}


@end
