//
//  CSFavoriteDetailViewController.m
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSConnectViewController.h"
#import "CSCourseViewController.h"
#import "CSCustomBackButton.h"
#import "CSFavoriteBlurView.h"
#import "CSFavoriteDetailViewController.h"
#import "CSHeaderView.h"
#import "CSImageObject.h"
void* CustomHeaderInsetObserver = &CustomHeaderInsetObserver;

@interface CSFavoriteDetailViewController ()

@property (nonatomic, strong) NSMutableArray* blurImages;
@property (nonatomic, strong) CSCourseViewController* course;
@property (nonatomic, strong) CSConnectViewController* connect;
@property (nonatomic, strong) CSHeaderView* myHeader;

@end

@implementation CSFavoriteDetailViewController

- (instancetype)init
{
    CSCourseViewController* course = [[CSCourseViewController alloc] init];
    CSConnectViewController* connect = [[CSConnectViewController alloc] init];
    self.course = course;
    self.connect = connect;
    self = [super initWithControllers:course, connect, nil];
    if (self) {
        self.segmentMiniTopInset = 44;
    }
    return self;
}

- (UIView<CSSegmentPageControllerHeaderProtocol>*)customHeaderView
{
    CSHeaderView* headerView = [[[NSBundle mainBundle] loadNibNamed:@"CSHeaderView" owner:nil options:nil] lastObject];
    headerView.headImage.image = [UIImage imageNamed:self.imageObject.imageName];
    headerView.headName.textColor = self.imageObject.primaryColor;
    headerView.headDescription.textColor = self.imageObject.secondaryColor;
    headerView.headAttention.layer.borderColor = self.imageObject.primaryColor.CGColor;
    [headerView.headAttention setTitleColor:self.imageObject.primaryColor forState:UIControlStateNormal];
    headerView.blurView.customColor = self.imageObject.backgroundColor;
    headerView.headName.font = CSPFSCRegularFont(15);
    headerView.headDescription.font = CSPFSCRegularFont(12);
    headerView.headAttention.titleLabel.font = CSPFSCRegularFont(13);
    NSLog(@"%p", headerView);
    self.myHeader = headerView;
    NSLog(@"%p", self.myHeader);
    return (UIView<CSSegmentPageControllerHeaderProtocol>*)headerView;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.segmentView.backgroundColor = self.imageObject.backgroundColor;
    self.segmentView.segmentControl.tintColor = self.imageObject.primaryColor;
    [self addObserver:self forKeyPath:@"segmentToInset" options:NSKeyValueObservingOptionNew context:CustomHeaderInsetObserver];
    self.course.imageObject = self.imageObject;
    self.connect.imageObject = self.imageObject;
    [self prepareForBlurImages];

    CSCustomBackButton* backButton = [[CSCustomBackButton alloc] initWithFrame:CGRectMake(15, 15, 25, 25)];
    backButton.customColor = self.imageObject.primaryColor;
    [backButton addTarget:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)backToRoot
{
    CSCustomTabBarViewController* tabBarController = (CSCustomTabBarViewController*)self.tabBarController;
    [tabBarController showtabBarView];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary<NSString*, id>*)change context:(void*)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if (context == CustomHeaderInsetObserver) {
        /**
         *  滚动偏移量
         */
        CGFloat inset = [change[NSKeyValueChangeNewKey] floatValue];
        NSLog(@"NavigationBar滚动偏移量%f",inset);
    }
}

- (void)prepareForBlurImages
{
    CGFloat factor = 0.1;
    self.blurImages = [NSMutableArray array];
    CSHeaderView* headerView = (CSHeaderView*)[self customHeaderView];
    [self.blurImages addObject:headerView.headImage.image];
    for (NSUInteger i = 0; i < headerView.frame.size.height / 10; i++) {
        [self.blurImages addObject:[headerView.headImage.image boxblurImageWithBlur:factor]];
        factor += 0.04;
    }
}

- (void)blurWithOffset:(float)offset
{
    NSInteger index = offset / 10;
    if (index < 0) {
        index = 0;
    }
    else if (index >= self.blurImages.count) {
        index = self.blurImages.count - 1;
    }
    NSLog(@"%ld", index);
    UIImage* image = self.blurImages[index];
    CSHeaderView* headerView = (CSHeaderView*)[self customHeaderView];
    if (headerView.headImage.image != image) {
        [headerView.headImage setImage:image];
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"segmentToInset"];
}
@end
