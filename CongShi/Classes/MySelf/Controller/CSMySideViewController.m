//
//  CSMySideViewController.m
//  CongShi
//
//  Created by Archy on 16/2/17.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSMySideViewController.h"
#import "CSSettingViewController.h"

@interface CSMySideViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CSMySideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI
{
    self.contentView.userInteractionEnabled = YES;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.userInteractionEnabled = YES;
    [self.contentView addSubview:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"self";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray *array = @[@"个人主页",@"设置",@"邀请好友",@"帮助",@"通知"];
    cell.textLabel.font = CSPFSCRegularFont(14);
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 220.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showHideSidebar];
    CSSettingViewController *setting = [[CSSettingViewController alloc] init];
    [self presentViewController:setting animated:YES completion:nil];
}
@end
