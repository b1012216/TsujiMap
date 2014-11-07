//
//  ViewController.m
//  TsujiMap
//
//  Created by FUNAICT201311 on 2014/11/07.
//  Copyright (c) 2014年 FUNAICT201311. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tsujiMapView, tsujiPin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tapGesture:)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [tsujiMapView addGestureRecognizer:tapGestureRecognizer];
    
    
    CLLocationCoordinate2D center;
    center.latitude = 41.776304;// 経度
    center.longitude = 140.736637;// 緯度
    [tsujiMapView setCenterCoordinate:center animated:NO];
    
    // 縮尺を指定
    MKCoordinateRegion region = tsujiMapView.region;
    region.center = center;
    region.span.latitudeDelta = 0.08;
    region.span.longitudeDelta = 0.08;
    [tsujiMapView setRegion:region animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MKMapViewDelegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // 現在地が追加された場合は終了する
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    // ピンのアノテーションビューを作成する
    static NSString *identifier = @"TsujiAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[tsujiMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    
    // ピンの設定
    annotationView.pinColor = MKPinAnnotationColorRed;
    annotationView.draggable = YES;
    annotationView.animatesDrop = YES;
    return annotationView;
}

// タップイベントを検出
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        // タップした位置を緯度経度に変換してピンを打つ
        CGPoint tapPoint = [sender locationInView:self.view];
        [self addPin:[tsujiMapView convertPoint:tapPoint toCoordinateFromView:tsujiMapView]];
        
    }
}

// ピンを打つ
-(void)addPin:(CLLocationCoordinate2D) coordinate
{
        tsujiPin = [MyLocationPin new];
   
    tsujiPin.coordinate = coordinate;
    NSLog(@"%f", tsujiPin.coordinate.latitude);
    NSLog(@"%f", tsujiPin.coordinate.longitude);
    
    [tsujiMapView addAnnotation:tsujiPin];
}

@end
