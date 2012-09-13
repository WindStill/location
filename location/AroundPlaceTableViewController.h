//
//  AroundPlaceTableViewController.h
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
#import "UIImageView+WebCache.h"
#import "math.h"

@interface AroundPlaceTableViewController : UITableViewController
<MKMapViewDelegate, CLLocationManagerDelegate>
{
    MKMapView *map;
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) NSArray *places;
@property (strong, nonatomic) CLLocation *currentLocation;

- (void)sortPlaces;

@end
