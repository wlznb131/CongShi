//
//  CSTopicStatusCell.h
//  CongShi
//
//  Created by Archy on 16/1/13.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSTopicFrame,CSImageObject;
@interface CSTopicStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) CSTopicFrame *topicFrame;
@property (nonatomic, strong) CSImageObject *imageObejct;

@end
