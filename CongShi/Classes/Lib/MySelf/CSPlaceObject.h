//
//  CSPlaceObject.h
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CSPlaceObjectDelegate <NSObject>

- (void)placeObjectDelegatePlaceLat:(NSString *)placeLat placeLng:(NSString *)placeLng;

@end

@interface CSPlaceObject : NSObject <CLLocationManagerDelegate>

/** 获取经纬度 */
@property (nonatomic, strong) CLLocationManager  *locationManager;
@property (nonatomic, copy)   NSString           *placeLat;
@property (nonatomic, copy)   NSString           *placeLng;
@property (nonatomic, strong) id <CSPlaceObjectDelegate> delegate;

+ (instancetype)sharePlace;
/** 获取经纬度 */
- (void)getPlace;
/** 开始定位 */
- (void)starPlace;
/** 停止定位 */
- (void)stopPlace;

@end
