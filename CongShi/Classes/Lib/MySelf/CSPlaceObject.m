//
//  CSPlaceObject.m
//  CongShi
//
//  Created by Archy on 16/1/12.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSPlaceObject.h"

static CSPlaceObject *instance = nil;
static dispatch_once_t onceToken;

@implementation CSPlaceObject
{
    int index;
}

+ (instancetype)sharePlace
{
    dispatch_once(&onceToken, ^{
        instance = [[CSPlaceObject alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        index = 1;
    }
    return self;
}

/** 获取经纬度 */
- (void)getPlace {
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 100;
    if (IS_IOS8) {
        [_locationManager requestAlwaysAuthorization];//添加这句
    }
    if (IS_IOS9) {
    }
    [_locationManager startUpdatingLocation];
}

- (void)starPlace {
    [_locationManager startUpdatingLocation];
}

- (void)stopPlace {
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currLocation = [locations lastObject];
    self.placeLat = STR_FLOAT(currLocation.coordinate.latitude);
    self.placeLng = STR_FLOAT(currLocation.coordinate.longitude);
    if (self.delegate) {
        [self.delegate placeObjectDelegatePlaceLat:self.placeLat placeLng:self.placeLng];
    }
    if (index == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refesh" object:nil userInfo:nil];
        index++;
    }
}
//获取定位失败回调方法
#pragma mark - location Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        if (index == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refesh" object:nil userInfo:nil];
            index++;
        }
    }
    if ([error code] == kCLErrorLocationUnknown) {
        _locationManager = nil;
    }
}



@end
