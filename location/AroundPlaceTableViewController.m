//
//  AroundPlaceTableViewController.m
//  location
//
//  Created by mac on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AroundPlaceTableViewController.h"


@implementation AroundPlaceTableViewController
@synthesize places;
@synthesize currentLocation;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    NSDictionary *place = [self.places objectAtIndex:row];
    NSString *icon = [place objectForKey:@"icon"];
    NSString *reference = [place objectForKey:@"reference"];
    NSString *name = [place objectForKey:@"name"];
    NSString *vicinity = [place objectForKey:@"vicinity"];
    NSArray *types = [place objectForKey:@"types"];
    NSNumber *distance = [place objectForKey:@"distance"];
    NSString *strDistance = [NSString stringWithFormat:@"%0.2f km", [distance doubleValue]/1000];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    [imageView setImageWithURL:[NSURL URLWithString:icon]
              placeholderImage:[UIImage imageNamed:@"111-user.png"]]; 
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    nameLabel.text = name;
    
    UILabel *vicinityLabel = (UILabel *)[cell viewWithTag:3];
    vicinityLabel.text = strDistance;
    
    
    // test
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"====================");
    [locationManager stopUpdatingLocation];
    self.currentLocation = newLocation;
    NSString *strLat = [NSString stringWithFormat:@"%.6f", newLocation.coordinate.latitude];
    NSString *strLng = [NSString stringWithFormat:@"%.6f", newLocation.coordinate.longitude];
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?key=AIzaSyCSLW0U_ZUdVKHoQ0NdeTVWmXdq0enLuTY&location=%@,%@&radius=500&language=zh-CN&sensor=false", strLat, strLng];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.shouldAttemptPersistentConnection = NO;
    request.validatesSecureCertificate = NO;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSDictionary *result = [response objectFromJSONString];
        self.places = (NSArray *)[result objectForKey:@"results"];
        [self sortPlaces];
        [self.tableView reloadData];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"locError:%@", error);
}

- (void)sortPlaces{
    NSMutableArray *myMutableArray = [[NSMutableArray alloc] initWithCapacity:[self.places count]]; 
    for (int i=0; i<[self.places count]; i++) {
        NSDictionary *placeDic = [self.places objectAtIndex:i];
        NSMutableDictionary *place = [NSMutableDictionary dictionaryWithDictionary:placeDic];

        NSDictionary *latitude = [[place objectForKey:@"geometry"] objectForKey:@"location"];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[latitude objectForKey:@"lat"] floatValue] longitude:[[latitude objectForKey:@"lng"] floatValue]];
        CLLocationDistance distance = [location distanceFromLocation:currentLocation];
        [place setObject:[NSNumber numberWithDouble:fabs(distance)] forKey:@"distance"];
        [myMutableArray addObject:place];
    }
    NSSortDescriptor *sorter  = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
    self.places = [myMutableArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sorter, nil]];
}

@end
