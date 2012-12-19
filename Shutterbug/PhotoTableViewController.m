//
//  PhotoTableViewController.m
//  Shutterbug
//
//  Created by Jacob Håkansson on 2012-12-12.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import "PhotoTableViewController.h"
#import "FlickrImageViewController.h"
#import "FlickrFetcher.h"
#import "FlickrPhotoAnnotation.h"
#import "MapViewController.h"

@interface PhotoTableViewController ()

@end

@implementation PhotoTableViewController

- (void) setPhotos:(NSArray *)photos {
    _photos = photos;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo description";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    NSString *description = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    NSString *title =[photo valueForKey:FLICKR_PHOTO_TITLE];
    if (!title && !description) {
        cell.textLabel.text = @"Unknown";
        cell.detailTextLabel.text = @"Unknown";
    } else if (!title||!description) {
        if (!title){
            cell.textLabel.text = description;
            cell.detailTextLabel.text = description;
        } else {
            cell.textLabel.text = title;
            cell.detailTextLabel.text = title;
        }
    } else {
        cell.textLabel.text = title;
        cell.detailTextLabel.text = description;
    }
    return cell;
}

- (NSArray *)mapAnnotations {
    NSMutableArray *annotations = [NSMutableArray array];
    for (NSDictionary *photo in self.photos) {
        [annotations addObject:[FlickrPhotoAnnotation annotationForPhoto:photo]];
    }
    return annotations;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Push to Flickr Image"]) {
        FlickrImageViewController *imageViewController = segue.destinationViewController;
        NSIndexPath *send = [self.tableView indexPathForSelectedRow];
        dispatch_queue_t downloadQueue = dispatch_queue_create("FlickrURLDownloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSURL *url =[FlickrFetcher urlForPhoto:[self.photos objectAtIndex:send.row] format:FlickrPhotoFormatLarge];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageViewController.imageURL = url;
            });
        });
        imageViewController.title = [self.tableView cellForRowAtIndexPath:send].textLabel.text;
    }
    else if ([segue.identifier isEqualToString:@"Push to map"]) {
        MapViewController *mapVC = segue.destinationViewController;
        mapVC.annotations = [self mapAnnotations];
    }
}

@end
