//
//  CSFindViewController.m
//  CongShi
//
//  Created by Archy on 16/1/8.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSFindViewController.h"
#import "CSStickySectionHeadersLayout.h"
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
#import "CSLoginViewController.h"

@interface CSFindViewController ()<UIScrollViewDelegate,CSBannerViewDataSource,CSBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CSStickySectionHeadersLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CSFindCollectionViewManager *manager;
@property (nonatomic, strong) CSFindObject *findObject;


@end

@implementation CSFindViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configUI];
}

- (void)configUI
{
    CSStickySectionHeadersLayout *layout = [[CSStickySectionHeadersLayout alloc] init];
    UICollectionView *findCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    findCollectionView.delegate = self;
    findCollectionView.dataSource = self;
    findCollectionView.backgroundColor = CSBackgroundColor;
    [self.view addSubview:findCollectionView];
    self.collectionView = findCollectionView;
    [self configCollectionView:findCollectionView];
}


- (void)configCollectionView:(UICollectionView *)collectionView;
{
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
                                           @"image":@"image000"
                                           },
                                       @{
                                           @"name":@"音乐",
                                           @"image":@"image001"
                                           },
                                       @{
                                           @"name":@"厨艺",
                                           @"image":@"image002"
                                           }
                                       ],
                               @"topic":@[
                                       @{
                                           @"description":@"",
                                           @"descriptionLabel":@"为您推荐那些即将消失的手做艺人",
                                           @"name":@"消失的技艺",
                                           @"picture":@"image003",
                                           },
                                       @{
                                           @"description":@"",
                                           @"descriptionLabel":@"来自全世界炫酷牛人",
                                           @"name":@"炫酷技能",
                                           @"picture":@"image004",
                                           },
                                       @{
                                           @"description":@"",
                                           @"descriptionLabel":@"有多少人还记得那些迷人的戏曲",
                                           @"name":@"南腔北调",
                                           @"picture":@"image005",
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
        UIImage *newImage = [image boxblurImageWithBlur:0.5];
        cell.hotImage.image = newImage;
        cell.hotLabel.text = object.name;
        return cell;
    } else if (indexPath.section == 2) {
        CSTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topic" forIndexPath:indexPath];
        CSTopicObject *object = self.findObject.topic[indexPath.item];
        UIImage *image = [[UIImage imageNamed:object.picture] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *newImage = [image boxblurImageWithBlur:0.5];
        cell.titleLabel.text = object.name;
        cell.describeLabel.text = object.descriptionLabel;
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
    return 4;
}

- (UIView *)banner:(CSBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CSAPP_WIDTH, CSLayoutHeight(360))];
    view.contentMode = UIViewContentModeScaleAspectFill;
    view.image = [[UIImage imageNamed:[NSString stringWithFormat:@"image%03ld", (unsigned long)index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return view;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CSCollectionSectionHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            view.sectionLabel.text = @"| 搜索";
            break;
        case 1:
            view.sectionLabel.text = @"热门标签";
            break;
        case 2:
            view.sectionLabel.text = @"从师专题";
            break;
        case 3:
            view.sectionLabel.text = @"从师授课";
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
    BOOL isLogin = [CSCommonDefault GetUserDefaultBool:@"isLogin"];
    if (isLogin) {
        NSLog(@"islogin");
    } else {
        CSLoginViewController *login = [[CSLoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];

    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(CSAPP_WIDTH, CSLayoutHeight(360));
            break;
        case 1:
            return CGSizeMake((CSAPP_WIDTH - 3)/3.0, (CSAPP_WIDTH - 3)/3.0);
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
    [super scrollViewDidScroll:scrollView];
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        if ([cell isKindOfClass:[CSFavoriteCollectionViewCell class]]) {
            CSFavoriteCollectionViewCell *newCell = (CSFavoriteCollectionViewCell *)cell;
            CGFloat yOffset = ((self.collectionView.contentOffset.y - cell.frame.origin.y) / ImageHeight) * ImageOffsetSpeed;
            newCell.imageOffset = CGPointMake(0.0f, yOffset);
        }
    }
}




@end
