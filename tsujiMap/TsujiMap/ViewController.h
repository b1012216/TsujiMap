//
//  ViewController.h
//  TsujiMap
//
//  Created by FUNAICT201311 on 2014/11/07.
//  Copyright (c) 2014年 FUNAICT201311. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#include "MyLocationPin.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *tsujiMapView;
@property MyLocationPin *tsujiPin;

@end

