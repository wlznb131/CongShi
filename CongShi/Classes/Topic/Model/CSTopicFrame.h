//
//  CSTopicFrame.h
//  CongShi
//
//  Created by Archy on 16/1/13.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSTopicStatus;

@interface CSTopicFrame : NSObject

@property (nonatomic, assign, readonly) CGRect headF;

@property (nonatomic, assign, readonly) CGRect nameF;

@property (nonatomic, assign, readonly) CGRect timeF;

@property (nonatomic, assign, readonly) CGRect blogF;

@property (nonatomic, assign, readonly) CGRect imageF;

@property (nonatomic, assign, readonly) CGRect likeF;

@property (nonatomic, assign, readonly) CGRect commentF;

@property (nonatomic, assign, readonly) CGRect shareF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) CSTopicStatus *status;


@end
