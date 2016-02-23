//
//  CSShiShuoFrame.h
//  CongShi
//
//  Created by Archy on 16/2/20.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSShiShuoObject;
@interface CSShiShuoFrame : NSObject

@property (nonatomic, assign, readonly) CGRect titleF;

@property (nonatomic, assign, readonly) CGRect subTitleF;

@property (nonatomic, assign, readonly) CGRect imageF;

@property (nonatomic, assign, readonly) CGRect webviewF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
