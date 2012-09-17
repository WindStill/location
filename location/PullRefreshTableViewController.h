//
//  PullRefreshTableViewController.h
//  location
//
//  Created by mac on 12-9-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

#define REFRESH_HEADER_HEIGHT 52.0f

@interface PullRefreshTableViewController : UITableViewController{
    BOOL isDragging;
    BOOL isLoading;
}

@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
@property (strong, nonatomic) UIView *refreshHeaderView;
@property (strong, nonatomic) UILabel *refreshLabel;
@property (strong, nonatomic) UIImageView *refreshArrow;
@property (strong, nonatomic) UIActivityIndicatorView *refreshSpinner;

- (void)sortPlaces;

- (void)setupString;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;
- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)pullToRefreshTableData;

@end
