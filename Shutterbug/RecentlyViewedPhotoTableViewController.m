//
//  RecentlyViewedTableViewController.m
//  Shutterbug
//
//  Created by Jacob Håkansson on 2012-12-11.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import "RecentlyViewedPhotoTableViewController.h"
#import "SaveRecentPhotoTableViewController.h"

@interface RecentlyViewedPhotoTableViewController ()

@end

@implementation RecentlyViewedPhotoTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS_KEY];
}
- (IBAction)refresh:(id)sender {
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS_KEY];
}

@end
