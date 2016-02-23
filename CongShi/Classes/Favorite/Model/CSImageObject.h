//
//  CSImageObject.h
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSImageObject : NSObject
/**
 *  图片名字
 */
@property (nonatomic, strong) NSString *imageName;
/**
 *  取色后的背景色
 */
@property (nonatomic, strong, readonly) UIColor *backgroundColor;
/**
 *  取色后的主标题色
 */
@property (nonatomic, strong, readonly) UIColor *primaryColor;
/**
 *  取色后的副标题色
 */
@property (nonatomic, strong, readonly) UIColor *secondaryColor;
/**
 *  取色后的详情色
 */
@property (nonatomic, strong, readonly) UIColor *detailColor;

@end
