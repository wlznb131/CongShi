//
//  CSCourseViewController.m
//  CongShi
//
//  Created by Archy on 15/12/31.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSCollectionSectionHeader.h"
#import "CSCourseApprenticeCell.h"
#import "CSCourseDescriptionCell.h"
#import "CSCourseEnrollCell.h"
#import "CSCourseGuideCell.h"
#import "CSCourseMapCell.h"
#import "CSCourseMessageCell.h"
#import "CSCourseRecommendCell.h"
#import "CSCourseRecordCell.h"
#import "CSCourseViewController.h"
#import "CSStickySectionHeadersLayout.h"

@interface CSCourseViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CSSegmentControllerDelegate, CSStickySectionHeadersLayoutDelegate>

@property (nonatomic, strong) UICollectionView* courseCollectionView;

@end

@implementation CSCourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (NSString*)segmentTitle
{
    return @"课程说明";
}

- (UIScrollView*)streachScrollView
{
    return self.courseCollectionView;
}

- (void)configUI
{

    CSStickySectionHeadersLayout* layout = [[CSStickySectionHeadersLayout alloc] init];
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;

    [collectionView registerClass:[CSCollectionSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [collectionView registerNib:[UINib nibWithNibName:@"CSCourseRecordCell" bundle:nil] forCellWithReuseIdentifier:@"Record"];
    [collectionView registerNib:[UINib nibWithNibName:@"CSCourseDescriptionCell" bundle:nil] forCellWithReuseIdentifier:@"Description"];
    [collectionView registerNib:[UINib nibWithNibName:@"CSCourseApprenticeCell" bundle:nil] forCellWithReuseIdentifier:@"Apprentice"];
    [collectionView registerNib:[UINib nibWithNibName:@"CSCourseEnrollCell" bundle:nil] forCellWithReuseIdentifier:@"Enroll"];
    [collectionView registerNib:[UINib nibWithNibName:@"CSCourseMessageCell" bundle:nil] forCellWithReuseIdentifier:@"Message"];
    [collectionView registerNib:[UINib nibWithNibName:@"CSCourseMapCell" bundle:nil] forCellWithReuseIdentifier:@"Map"];
    [collectionView registerNib:[UINib nibWithNibName:@"CSCourseGuideCell" bundle:nil] forCellWithReuseIdentifier:@"Guide"];
    [collectionView registerNib:[UINib nibWithNibName:@"CSCourseRecommendCell" bundle:nil] forCellWithReuseIdentifier:@"Recommend"];

    [self.view addSubview:collectionView];
    self.courseCollectionView = collectionView;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionReusableView*)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath
{
    CSCollectionSectionHeader* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    switch (indexPath.section) {
    case 0:
        view.sectionLabel.text = @"课程记录";
        break;
    case 1:
        view.sectionLabel.text = @"大师资料";
        break;
    case 2:
        view.sectionLabel.text = @"从师名徒";
        break;
    case 3:
        view.sectionLabel.text = @"报名者";
        break;
    case 4:
        view.sectionLabel.text = @"留言";
        break;
    case 5:
        view.sectionLabel.text = @"课程地点";
        break;
    case 6:
        view.sectionLabel.text = @"课程说明";
        break;
    case 7:
        view.sectionLabel.text = @"相关推荐";
        break;
    default:
        break;
    }
    view.sectionLabel.textColor = self.imageObject.secondaryColor;
    view.backgroundColor = self.imageObject.backgroundColor;
    return view;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 2 || section == 7) {
        return 3;
    }
    else if (section == 6) {
        return 5;
    }
    else
        return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 8;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        CSCourseRecordCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Record" forIndexPath:indexPath];
        cell.backgroundColor = self.imageObject.backgroundColor;
        return cell;
    }
    else if (indexPath.section == 1) {
        CSCourseDescriptionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Description" forIndexPath:indexPath];
        cell.backgroundColor = self.imageObject.backgroundColor;

        return cell;
    }
    else if (indexPath.section == 2) {
        CSCourseApprenticeCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Apprentice" forIndexPath:indexPath];
        cell.backgroundColor = self.imageObject.backgroundColor;

        return cell;
    }
    else if (indexPath.section == 3) {
        CSCourseEnrollCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Enroll" forIndexPath:indexPath];
        cell.backgroundColor = self.imageObject.backgroundColor;

        return cell;
    }
    else if (indexPath.section == 4) {
        CSCourseMessageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Message" forIndexPath:indexPath];
        cell.backgroundColor = self.imageObject.backgroundColor;

        return cell;
    }
    else if (indexPath.section == 5) {
        CSCourseMapCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Map" forIndexPath:indexPath];
        cell.backgroundColor = self.imageObject.backgroundColor;

        return cell;
    }
    else if (indexPath.section == 6) {
        CSCourseGuideCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Guide" forIndexPath:indexPath];
        cell.backgroundColor = self.imageObject.backgroundColor;

        return cell;
    }
    else if (indexPath.section == 7) {
        CSCourseRecommendCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Recommend" forIndexPath:indexPath];
        cell.backgroundColor = self.imageObject.backgroundColor;

        return cell;
    }
    else
        return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.section) {
    case 0:
        return CGSizeMake(CSAPP_WIDTH, 589 - 373);
        break;
    case 1:
        return CGSizeMake(CSAPP_WIDTH, 784 - 648);
        break;
    case 2:
        return CGSizeMake((CSAPP_WIDTH - 2) / 3.0, CSLayoutHeight(1016 - 850));
        break;
    case 3:
        return CGSizeMake(CSAPP_WIDTH, 1107 - 1048);
        break;
    case 4:
        return CGSizeMake(CSAPP_WIDTH, 1255 - 1152);
        break;
    case 5:
        return CGSizeMake(CSAPP_WIDTH, 100);
        break;
    case 6:
        return CGSizeMake(CSAPP_WIDTH, 40);
        break;
    case 7:
        return CGSizeMake(CSAPP_WIDTH, 100);
        break;
    default:
        return CGSizeZero;
        break;
    }
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CSAPP_WIDTH, CSLayoutHeight(45));
}

- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

#pragma mark - CSStickySectionHeadersLayoutDelegate
/**
 *  组头是否悬停
 */
- (BOOL)stickySectionHeadesLayout:(CSStickySectionHeadersLayout*)layout shouldStickHeaderToTopInSection:(NSUInteger)section
{
    return NO;
}

@end
