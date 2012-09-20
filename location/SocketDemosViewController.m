//
//  SocketDemosViewController.m
//  location
//
//  Created by mac on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SocketDemosViewController.h"

@implementation SocketDemosViewController
@synthesize socket;
@synthesize length;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    if (![socket connectToHost:@"192.168.2.113" onPort:8080 error:&error]) {
        NSLog(@"I goofed: %@", error);
        return;
    }
    [socket readDataToLength:4 withTimeout:3 tag:1];
//    [socket readDataWithTimeout:3 tag:3];
          
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"did connect to host");
    NSLog(@"%@: %i", host, port);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    if (tag == 1) {
        [data getBytes: &length length: sizeof(length)];
        length = ntohl(length);
        [socket readDataToLength:length withTimeout:3 tag:2];
    }else if (tag == 2) {
        NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"message is: \n%@",message);  
        [socket readDataToLength:4 withTimeout:3 tag:1];
    }
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    if (tag == 1)
        NSLog(@"Data header sent");
    else if (tag == 2)
        NSLog(@"Data body sent");
}

- (IBAction)sendMessage:(id)sender {
    NSString *str = @"Hello world";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger len = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    len = ntohl(len);
    NSData *headData = [NSData dataWithBytes:&len length:sizeof(len)];
    
    [socket writeData:headData withTimeout:-1 tag:1];
    [socket writeData:data withTimeout:-1 tag:1];
    
}
@end
