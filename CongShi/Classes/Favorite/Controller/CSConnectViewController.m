//
//  CSConnectViewController.m
//  CongShi
//
//  Created by Archy on 15/12/31.
//  Copyright © 2015年 Archy. All rights reserved.
//

#import "CSConnectViewController.h"
#import "CSTopicStatusCell.h"
#import "CSTopicStatus.h"
#import "CSTopicFrame.h"

@interface CSConnectViewController ()<CSSegmentControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CSTopicFrame *cellFrame;


@end

@implementation CSConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.imageObject.backgroundColor);
    [self configUI];
}


- (NSString *)segmentTitle
{
    return @"动态分享";
}

- (UIScrollView *)streachScrollView
{
    return  self.tableView;
}

- (void)configUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellFrame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSTopicStatusCell *cell = [CSTopicStatusCell cellWithTableView:tableView];
    CSTopicFrame *cellFrame = [[CSTopicFrame alloc] init];
    self.cellFrame = cellFrame;
    cell.topicFrame = cellFrame;
    cell.imageObejct = self.imageObject;
    return nil;
}



@end
