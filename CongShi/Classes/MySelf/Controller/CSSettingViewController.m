//
//  CSSettingViewController.m
//  CongShi
//
//  Created by Archy on 16/2/18.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSSettingViewController.h"

@interface CSSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.backgroundColor = CSBackgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else if (section == 1){
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *array = @[@[@"资料编辑",@"更改密码",@"兴趣标签",@"我的收藏"],@[@"清理缓存",@"服务条款"],@[@"退出"]];
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.textColor = CSLabelColor;
    cell.textLabel.text = array[indexPath.section][indexPath.row];
    cell.textLabel.font = CSPFSCLightFont(14);
    if (indexPath.section == 2) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"282828"];
    return cell;
}


@end
