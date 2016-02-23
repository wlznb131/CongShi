//
//  CSFavoriteObject.h
//  CongShi
//
//  Created by Archy on 16/2/11.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSFavoriteObject : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *currentImg;

@property (nonatomic, strong) NSString *tags;

@property (nonatomic, assign) BOOL *isrecommended;

@property (nonatomic, strong) NSString *origin_color;

@property (nonatomic, strong) NSString *background_color;

@property (nonatomic, strong) NSString *secondary_color;

@property (nonatomic, strong) NSString *default_color;

@property (nonatomic, strong) NSString *nickName;

@end
