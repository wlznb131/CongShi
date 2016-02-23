//
//  CSAppDefs.h
//  CongShi
//
//  Created by Archy on 15/12/22.
//  Copyright © 2015年 Archy. All rights reserved.
//

#ifndef CSAppDefs_h
#define CSAppDefs_h

#define CSAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#ifdef DEBUG
#define CSLog(...) NSLog(__VA_ARGS__)
#else
#define CSLog(...)
#endif

#define CLOSE_TABVIEW @"closeTabView"
#define SHOW_TABVIEW @"showTabView"


#define CSBackgroundColor [UIColor colorWithHexString:@"1e1e1e"]
#define CSLabelColor [UIColor colorWithHexString:@"E6E6E6"]

#define CSLayoutWidth(W) (CSAPP_WIDTH / 375) * (W)
#define CSLayoutHeight(H) (CSAPP_WIDTH / 375) * (H)
#define CSPFSCRegularFont(F) [UIFont fontWithName:@"PingFangSC-Regular" size:(F)]
#define CSPFSCThinFont(F) [UIFont fontWithName:@"PingFangSC-Thin" size:(F)]
#define CSPFSCLightFont(F) [UIFont fontWithName:@"PingFangSC-Light" size:(F)]
#define CSPFSCMediumFont(F) [UIFont fontWithName:@"PingFangSC-Medium" size:(F)]

#define CSAPP_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define CSAPP_WIDTH [UIScreen mainScreen].bounds.size.width

#define GetMaxX(V)   CGRectGetMaxX(V)
#define GetMaxY(V)   CGRectGetMaxY(V)

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)

#define INT(a)      [NSNumber numberWithInteger:(a)]
#define FLOAT(a)    [NSNumber numberWithFloat:(a)]
#define NUM_BOOL(a) [NSNumber numberWithBool:(a)]

#define STR(a)  [NSString stringWithFormat:@"%@", (a)]
#define STR_INT(a)  [NSString stringWithFormat:@"%d", (a)]
#define STR_LONG(a)  [NSString stringWithFormat:@"%ld", (a)]
#define STR_NUM2(a)  [NSString stringWithFormat:@"%.2f", (a)]
#define STR_NUM0(a)  [NSString stringWithFormat:@"%.0f", (a)]
#define STR_FLOAT(a) [NSString stringWithFormat:@"%f", (a)]



NS_INLINE BOOL OSVersionIsAtLeastiOS7() {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}

NS_INLINE BOOL OSVersionIsOnlyiOS7() {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1  && floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1);
}

NS_INLINE BOOL OSVersionIsAtLeastiOS8() {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1);
}

NS_INLINE BOOL StringHasValue(id str) {
    return (str != nil) && (str != [NSNull null]) && (![str isEqualToString:@""]);
}

NS_INLINE BOOL NumberHasRealValue(id str) {
    return (str != nil) && (str != [NSNull null]) && (![str isEqualToNumber:[NSNumber numberWithInt:0]]);
}

NS_INLINE BOOL NumberHasValue(id str) {
    return (str != nil) && (str != [NSNull null]);
}

NS_INLINE BOOL BoolHasValue(id str) {
    return (str != nil) && (str != [NSNull null]);
}


NS_INLINE BOOL DictionaryHasValue(id dict)
{
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        NSArray * array = [dict allKeys];
        if ([array count]>0) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

NS_INLINE BOOL ArrayHasValue(id array)
{
    if ([array isKindOfClass:[NSArray class]]) {
        if ([array count]>0) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
    
}


#endif /* CSAppDefs_h */
