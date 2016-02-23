//
//  CSTopicViewController.m
//  CongShi
//
//  Created by Archy on 16/1/8.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSReleaseViewController.h"
#import "CSTopicFrame.h"
#import "CSTopicStatus.h"
#import "CSTopicStatusCell.h"
#import "CSTopicViewController.h"

@interface CSTopicViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* topicTableView;

@property (nonatomic, strong) NSMutableArray* dataSource;

@property (nonatomic, strong) CSTopicFrame* cellFrame;

@end

@implementation CSTopicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"1e1e1e"];
    [self configUI];
}

- (void)configUI
{
    self.navigationItem.title = @"从师广场";
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithHexString:@"d8d8d8"] }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Group"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItem)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Fill 103"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItem)];

    UITableView* topicTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    topicTableView.dataSource = self;
    topicTableView.delegate = self;
    topicTableView.backgroundColor = [UIColor colorWithHexString:@"1e1e1e"];
    topicTableView.separatorColor = [UIColor colorWithHexString:@"979797"];
    [self.view addSubview:topicTableView];
    self.topicTableView = topicTableView;
}

- (void)rightBarButtonItem
{
    CSReleaseViewController* releaseController = [[CSReleaseViewController alloc] init];
    [self.navigationController pushViewController:releaseController animated:YES];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return self.cellFrame.cellHeight;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    CSTopicStatusCell* cell = [CSTopicStatusCell cellWithTableView:tableView];
    CSTopicStatus* model = [[CSTopicStatus alloc] init];
    model.userFace = @"8659ca48a0816c07338cd843c39beccc";
    model.nickName = @"Jack";
    model.addTime = @"3分钟前";
    model.content = @"西餐中的肉类如何处理，一直是我身边的朋友问我的问题，特别整理做了一堂课程，9月10号，喜欢的朋友可以一起交流";
    if (indexPath.row % 2 == 0) {
        model.photolist = @[ @"3616383107_82c3357eae_o" ];
    }
    else {
        model.photolist = nil;
    }
    CSTopicFrame* cellFrame = [[CSTopicFrame alloc] init];
    cellFrame.status = model;
    self.cellFrame = cellFrame;
    cell.topicFrame = cellFrame;
    return cell;
}

@end
