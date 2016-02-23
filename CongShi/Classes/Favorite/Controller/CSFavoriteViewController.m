//
//  CSFavoriteViewController.m
//  CongShi
//
//  Created by Archy on 16/1/8.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSBannerView.h"
#import "CSFavoriteCollectionViewCell.h"
#import "CSFavoriteDetailViewController.h"
#import "CSFavoriteViewController.h"
#import "CSImageObject.h"
#import "CSLoginViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface CSFavoriteViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, CSBannerViewDelegate, CSBannerViewDataSource, AMapSearchDelegate>
/**
 *  favorite collectionView
 */
@property (nonatomic, strong) UICollectionView* CSFavoriteCollectionView;
/**
 *  favorite dataSource
 */
@property (nonatomic, strong) NSMutableArray* dataSource;

@property (nonatomic, strong) UILabel* cityLabel;

@property (nonatomic, strong) AMapSearchAPI* search;

@end

@implementation CSFavoriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self configUI];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest*)request response:(AMapReGeocodeSearchResponse*)response
{
    if (response.regeocode != nil) {
        self.cityLabel.text = response.regeocode.addressComponent.city;
    }
}

- (void)configUI
{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(CSAPP_WIDTH, 320);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    UICollectionView* favoriteCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    favoriteCollectionView.dataSource = self;
    favoriteCollectionView.delegate = self;
    favoriteCollectionView.backgroundColor = CSBackgroundColor;
    [favoriteCollectionView registerClass:[CSFavoriteCollectionViewCell class] forCellWithReuseIdentifier:@"favoriteCell"];
    [favoriteCollectionView registerClass:[CSBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"favoriteBanner"];
    [self.view addSubview:favoriteCollectionView];
    self.CSFavoriteCollectionView = favoriteCollectionView;

    NSMutableArray* dataSource = [NSMutableArray array];
    NSUInteger index;
    for (index = 0; index < 14; ++index) {
        NSString* name = [NSString stringWithFormat:@"image%03ld", (unsigned long)index];
        CSImageObject* object = [[CSImageObject alloc] init];
        object.imageName = name;
        [dataSource addObject:object];
    }
    self.dataSource = dataSource;
}
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    [super scrollViewDidScroll:scrollView];

    for (CSFavoriteCollectionViewCell* cell in self.CSFavoriteCollectionView.visibleCells) {
        CGFloat yOffset = ((self.CSFavoriteCollectionView.contentOffset.y - cell.frame.origin.y) / ImageHeight) * ImageOffsetSpeed;
        cell.imageOffset = CGPointMake(0.0f, yOffset);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [super scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset
{
    [super scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

#pragma mark UICollectionViewDelegate

- (UICollectionReusableView*)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath
{
    CSBannerView* header = nil;

    if (kind == UICollectionElementKindSectionHeader) {

        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"favoriteBanner" forIndexPath:indexPath];
        header.frame = CGRectMake(0, 0, CSAPP_WIDTH, 100);
        header.delegate = self;
        header.dataSource = self;
        header.autoScroll = YES;
        header.shouldLoop = YES;

        [AMapSearchServices sharedServices].apiKey = @"c11ecf3a58b6d193dac2eee26919316f";
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;

        CSPlaceObject* placeObject = [CSPlaceObject sharePlace];
        [placeObject getPlace];

        AMapReGeocodeSearchRequest* regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:[placeObject.placeLat floatValue] longitude:[placeObject.placeLng floatValue]];
        regeo.requireExtension = YES;
        //发起逆地理编码
        [self.search AMapReGoecodeSearch:regeo];

        UILabel* label = [UILabel newLabelWithFrame:CGRectMake(5, 5, 22, 16) alignment:0 textColor:CSLabelColor andFont:CSPFSCLightFont(11)];
        label.text = @"上海";
        self.cityLabel = label;
        [header addSubview:label];
    }
    return header;
}

- (NSInteger)numberOfItemsInBanner:(CSBannerView*)banner
{
    return 3;
}

- (UIView*)banner:(CSBannerView*)banner viewForItemAtIndex:(NSInteger)index
{
    UIImageView* imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [[UIImage imageNamed:[NSString stringWithFormat:@"image%03ld", (unsigned long)index + 3]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIView* blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CSAPP_WIDTH, 100)];
    blurView.backgroundColor = [UIColor blackColor];
    blurView.alpha = 0.5;
    [imageView addSubview:blurView];
    return imageView;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CSAPP_WIDTH, 145);
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    CSFavoriteCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favoriteCell" forIndexPath:indexPath];

    CSImageObject* object = self.dataSource[indexPath.item];
    cell.favoriteImage = [UIImage imageNamed:object.imageName];
    cell.favoriteName.textColor = object.primaryColor;
    cell.favoriteDescription.textColor = object.secondaryColor;
    CGFloat yOffset = ((self.CSFavoriteCollectionView.contentOffset.y - cell.frame.origin.y) / ImageHeight) * ImageOffsetSpeed;
    cell.imageOffset = CGPointMake(0.0f, yOffset);
    return cell;
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    CSCustomTabBarViewController* tabBarController = (CSCustomTabBarViewController*)self.tabBarController;
    CSFavoriteDetailViewController* detail = [[CSFavoriteDetailViewController alloc] init];
    detail.imageObject = self.dataSource[indexPath.item];
    [tabBarController closeTabBarView];
    [self.navigationController pushViewController:detail animated:YES];
    
//    BOOL isLogin = [CSCommonDefault GetUserDefaultBool:@"isLogin"];
//    if (isLogin) {
//        CSCustomTabBarViewController* tabBarController = (CSCustomTabBarViewController*)self.tabBarController;
//        CSFavoriteDetailViewController* detail = [[CSFavoriteDetailViewController alloc] init];
//        detail.imageObject = self.dataSource[indexPath.item];
//        [tabBarController closeTabBarView];
//        [self.navigationController pushViewController:detail animated:YES];
//    }
//    else {
//        CSLoginViewController* login = [[CSLoginViewController alloc] init];
//        [self presentViewController:login animated:YES completion:nil];
//    }
    
}

@end
