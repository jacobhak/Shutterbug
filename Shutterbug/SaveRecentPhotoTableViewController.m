//
//  PlaceTopPhotosTableViewController.m
//  Shutterbug
//
//  Created by Jacob Håkansson on 2012-12-11.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import "SaveRecentPhotoTableViewController.h"

@interface SaveRecentPhotoTableViewController ()

@end

@implementation SaveRecentPhotoTableViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    NSIndexPath *send = [self.tableView indexPathForSelectedRow];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recentPhotos = [[defaults objectForKey:RECENT_PHOTOS_KEY] mutableCopy];
    if (!recentPhotos) {
        recentPhotos = [NSMutableArray array];
    }
    [recentPhotos insertObject:[self.photos objectAtIndex:send.row] atIndex:0];
    [defaults setObject:recentPhotos forKey:RECENT_PHOTOS_KEY];
    [defaults synchronize];
}


@end
