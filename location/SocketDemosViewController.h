//
//  SocketDemosViewController.h
//  location
//
//  Created by mac on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"
#import "WDUtil.h"

@interface SocketDemosViewController : UIViewController<GCDAsyncSocketDelegate>

@property (strong, nonatomic) GCDAsyncSocket *socket;
@property (nonatomic) NSUInteger length;
- (IBAction)sendMessage:(id)sender;

@end
