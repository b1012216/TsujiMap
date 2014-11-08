//
//  ViewController.h
//  TsujiMap
//
//  Created by FUNAICT201311 on 2014/11/07.
//  Copyright (c) 2014年 FUNAICT201311. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#include "MyLocationPin.h"

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> 


@property (weak, nonatomic) IBOutlet MKMapView *tsujiMapView;
@property MyLocationPin *tsujiPin;
- (IBAction)tsujiButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *tsujitext;

- (IBAction)tsujiReset:(id)sender;

@end

