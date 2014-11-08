//
//  MyLocationPin.h
//  TsujiMap
//
//  Created by FUNAICT201311 on 2014/11/07.
//  Copyright (c) 2014年 FUNAICT201311. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocationPin : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end