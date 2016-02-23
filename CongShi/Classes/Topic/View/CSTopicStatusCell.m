//
//  CSTopicStatusCell.m
//  CongShi
//
//  Created by Archy on 16/1/13.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSTopicStatusCell.h"
#import "CSTopicStatus.h"
#import "CSTopicFrame.h"
#import "CSImageObject.h"
@interface CSTopicStatusCell()

@property (nonatomic, weak) UIImageView *headView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *blogLabel;

@property (nonatomic, weak) UIImageView *blogImage;

@property (nonatomic, weak) UIButton *likeButton;

@property (nonatomic, weak) UIButton *commentButton;

@property (nonatomic, weak) UIButton *shareButton;

@end

@implementation CSTopicStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TopicStatus";
    CSTopicStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CSTopicStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CSBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    UIImageView *headView = [[UIImageView alloc] init];
    headView.layer.cornerRadius = 20;
    headView.layer.borderColor = [UIColor colorWithHexString:@"979797"].CGColor;
    headView.layer.borderWidth = 1;
    headView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:headView];
    self.headView = headView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = CSPFSCRegularFont(14);
    nameLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = CSPFSCRegularFont(10);
    timeLabel.textColor = CSLabelColor;
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *blogLabel = [[UILabel alloc] init];
    blogLabel.font = CSPFSCRegularFont(14);
    blogLabel.numberOfLines = 2;
    blogLabel.textColor = CSLabelColor;
    [self.contentView addSubview:blogLabel];
    self.blogLabel = blogLabel;
    
    UIImageView *blogImage = [[UIImageView alloc] init];
    blogImage.layer.cornerRadius = 5;
    blogImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:blogImage];
    self.blogImage = blogImage;
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    [self.contentView addSubview:likeButton];
    self.likeButton = likeButton;
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [self.contentView addSubview:commentButton];
    self.commentButton = commentButton;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.contentView addSubview:shareButton];
    self.shareButton = shareButton;
}

- (void)setTopicFrame:(CSTopicFrame *)topicFrame
{
    _topicFrame = topicFrame;
    
    CSTopicStatus *status = topicFrame.status;
    
    self.headView.frame = topicFrame.headF;
    self.headView.image = [UIImage imageNamed:@"8659ca48a0816c07338cd843c39beccc"];
    
    self.nameLabel.frame = topicFrame.nameF;
    self.nameLabel.text = status.nickName;
    
    self.timeLabel.frame = topicFrame.timeF;
    self.timeLabel.text = status.addTime;
    
    self.blogLabel.frame = topicFrame.blogF;
    self.blogLabel.text = status.content;
    
    self.blogImage.frame = topicFrame.imageF;
    self.blogImage.image = [UIImage imageNamed:@"3616383107_82c3357eae_o"];
    
    self.likeButton.frame = topicFrame.likeF;
    [self.likeButton setTitle:@" 123" forState:UIControlStateNormal];
    [self.likeButton setTitleColor:[UIColor colorWithHexString:@"9b9b9b"] forState:UIControlStateNormal];
    self.likeButton.titleLabel.font = CSPFSCRegularFont(12);
    
    self.commentButton.frame = topicFrame.commentF;
    [self.commentButton setTitle:@" 4567" forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[UIColor colorWithHexString:@"9b9b9b"] forState:UIControlStateNormal];
    self.commentButton.titleLabel.font = CSPFSCRegularFont(12);

    self.shareButton.frame = topicFrame.shareF;
    [self.shareButton setTitleColor:[UIColor colorWithHexString:@"9b9b9b"] forState:UIControlStateNormal];
    self.shareButton.titleLabel.font = CSPFSCRegularFont(12);

    self.likeButton.left = self.blogLabel.left;
    self.shareButton.right = self.blogLabel.right;
    self.commentButton.centerX = self.blogLabel.centerX;
}

- (void)setImageObejct:(CSImageObject *)imageObejct
{
    _imageObejct = imageObejct;
    self.backgroundColor = imageObejct.backgroundColor;
    self.nameLabel.textColor = imageObejct.secondaryColor;
    self.blogLabel.textColor = imageObejct.primaryColor;
    
}

@end
