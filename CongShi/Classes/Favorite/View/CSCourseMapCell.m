//
//  CSCourseMapCell.m
//  CongShi
//
//  Created by Archy on 16/1/28.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSCourseMapCell.h"

@implementation CSCourseMapCell

- (void)awakeFromNib {
    // Initialization code
    [self configUI];
}

- (void)configUI
{
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, CSAPP_WIDTH, 100)];
    [self.contentView addSubview:mapView];
    self.mapView = mapView;
    
    [mapView setMapType:MKMapTypeStandard];
    
    mapView.showsUserLocation=YES;
    
    
    CLLocationCoordinate2D theCoordinate;
    
    theCoordinate.latitude=21.238928;
    
    theCoordinate.longitude=113.313353;
    
    MKCoordinateSpan theSpan;
    
    theSpan.latitudeDelta=0.1;
    
    theSpan.longitudeDelta=0.1;
    
    MKCoordinateRegion theRegion;
    
    theRegion.center=theCoordinate;
    
    theRegion.span=theSpan;
    
    [mapView setRegion:theRegion];
    
}

@end
