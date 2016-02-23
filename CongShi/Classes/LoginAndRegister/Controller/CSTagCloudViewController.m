//
//  CSTagCloudViewController.m
//  CongShi
//
//  Created by Archy on 16/2/4.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSTagCloudViewController.h"
#import "CSTabBarViewController.h"
#import "CSCustomBackButton.h"
#import "CSTagsObject.h"
#import "DBSphereView.h"

@interface CSTagCloudViewController ()

@property (nonatomic, strong) UIVisualEffectView *visualeffectview;

@property (nonatomic, strong) DBSphereView *sphereView;

@end

@implementation CSTagCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self requestData];
    
}

- (void)configUI
{
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundView.image = [[UIImage imageNamed:@"深黄色详情页面-tabBar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backgroundView];
    
    [self createVisualEffectView];
    
    CSCustomBackButton *backButton = [[CSCustomBackButton alloc] initWithFrame:CGRectMake(15, 15, 25, 25)];
    backButton.customColor = [UIColor whiteColor];
    [self.view addSubview:backButton];
    
    UILabel *tagLabel = [UILabel newLabelWithFrame:CGRectMake(0, 110, 180, 28) alignment:NSTextAlignmentCenter textColor:CSLabelColor andFont:CSPFSCLightFont(20)];
    tagLabel.text = @"选择你感兴趣的标签";
    tagLabel.centerX = self.view.centerX;
    [self.view addSubview:tagLabel];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    finishBtn.titleLabel.textColor = CSLabelColor;
    finishBtn.titleLabel.font = CSPFSCRegularFont(14);
    [finishBtn sizeToFit];
    finishBtn.top = 15;
    finishBtn.right = CSAPP_WIDTH - 15;
    [self.view addSubview:finishBtn];
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)finish {
  CSTabBarViewController *tab = [[CSTabBarViewController alloc] init];
  [self presentViewController:tab animated:YES completion:nil];
}

- (void)configSphereViewWithArray:(NSArray *)tags;
{
    DBSphereView *sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, 240, 300, 300)];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 30; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CSTagsObject *object = tags[arc4random_uniform(4)];
        
        [btn setTitle:[NSString stringWithFormat:@"%@", object.tagName] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:24.];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"FF0076"] forState:UIControlStateSelected];
        btn.frame = CGRectMake(0, 0, 60, 20);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [sphereView addSubview:btn];
    }
    [sphereView setCloudTags:array];
    sphereView.centerX = self.view.centerX;
    sphereView.backgroundColor = [UIColor clearColor];
    self.sphereView = sphereView;
    [self.view addSubview:sphereView];
    
}

- (void)requestData {

    [CSHttpTool post:GETTAGS params:nil success:^(id responseObj) {
        NSArray *tagArray = [CSTagsObject
                             mj_objectArrayWithKeyValuesArray:responseObj];
        [self configSphereViewWithArray:tagArray];
       
    } failure:^(id error) {
        
    }];
    
}

- (void)buttonPressed:(UIButton *)btn
{
    [self.sphereView timerStop];
    
    btn.selected = !btn.isSelected;
    //    [UIView animateWithDuration:0.3 animations:^{
    //        btn.transform = CGAffineTransformMakeScale(2., 2.);
    //    } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:0.3 animations:^{
    //            btn.transform = CGAffineTransformMakeScale(1., 1.);
    //        } completion:^(BOOL finished) {
    //            CSTabBarViewController *tab = [[CSTabBarViewController alloc] init];
    //            [self presentViewController:tab animated:YES completion:nil];
    //        }];
    //    }];
    [self.sphereView timerStart];
}


- (void)createVisualEffectView{
    UIVisualEffect *lightBlurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
    _visualeffectview = [[UIVisualEffectView alloc] initWithEffect:lightBlurEffect];
    _visualeffectview.frame = CGRectMake(0, 0, CSAPP_WIDTH , CSAPP_HEIGHT);
    
    [self.view addSubview:_visualeffectview];
}

@end
