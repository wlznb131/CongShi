//
//  CSCollectionSectionHeader.m
//  CongShi
//
//  Created by Archy on 16/1/28.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSCollectionSectionHeader.h"

@implementation CSCollectionSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *sectionLabel = [UILabel  newLabelWithFrame:CGRectMake(15, 16, 104, 13) alignment:0 textColor:CSLabelColor andFont:CSPFSCRegularFont(13)];
        [self addSubview:sectionLabel];
        self.sectionLabel = sectionLabel;

    }
    return self;
}

@end
