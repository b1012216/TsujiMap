//
//  ViewController.m
//  TsujiMap
//
//  Created by FUNAICT201311 on 2014/11/07.
//  Copyright (c) 2014年 FUNAICT201311. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSMutableArray *tsujiArray;

@end

@implementation ViewController

@synthesize tsujiMapView, tsujiPin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    tsujiMapView.delegate = self;
    
    tsujiMapView.userInteractionEnabled = YES;
   
    
    self.tsujiArray = [NSMutableArray array];

    
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
    //annotationView.animatesDrop = YES;
    //annotationView.bounds = CGRectMake(0, 0, 0, -1);
    return annotationView;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    MKPolylineView *lineView = [[MKPolylineView alloc] initWithOverlay:overlay];
    lineView.strokeColor = [UIColor redColor];
    lineView.lineWidth = 5.0;
    
    return lineView;
}


// タップイベントを検出
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        // タップした位置を緯度経度に変換してピンを打つ
        CGPoint tapPoint = [sender locationInView:tsujiMapView];
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
    [self.tsujiArray addObject:tsujiPin];
    
}

- (IBAction)tsujiButton:(id)sender {

    CLLocationCoordinate2D route_points[[self.tsujiArray count]];
    for(int i = 0; i < [self.tsujiArray count]; i++){
        route_points[i] = CLLocationCoordinate2DMake(((MyLocationPin *)[self.tsujiArray objectAtIndex:i]).coordinate.latitude
                                                     ,((MyLocationPin *)[self.tsujiArray objectAtIndex:i]).coordinate.longitude);
        
    }
    NSLog(@"%f",((MyLocationPin *)[self.tsujiArray objectAtIndex:2]).coordinate.latitude);
    NSLog(@"%f", route_points[2].latitude);
    NSLog(@"%d", [self.tsujiArray count]);
    
    MKPolyline *tsujiLine;
    tsujiLine = [[MKPolyline alloc] init];
    tsujiLine = [MKPolyline polylineWithCoordinates:route_points count:[self.tsujiArray count]];

    [tsujiMapView addOverlay:tsujiLine];
    
}

@end
