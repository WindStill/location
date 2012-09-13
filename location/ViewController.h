//
//  ViewController.h
//  location
//
//  Created by mac on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
{
    MKMapView *map;
    CLLocationManager *locationManager;
}

@end
