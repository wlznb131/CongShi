//
//  CSSegmentPageHeader.h
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSegmentPageControllerHeaderProtocol.h"

@interface CSSegmentPageHeader : UIView<CSSegmentPageControllerHeaderProtocol>

@property (nonatomic, strong) UIImageView *imageView;

@end
