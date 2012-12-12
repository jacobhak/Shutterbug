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

@interface PhotoTableViewController ()

@end

@implementation PhotoTableViewController

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
    NSString *description = [photo valueForKey:@"description._content"];
    NSString *title =[photo valueForKey:@"title"];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Push to Flickr Image"]) {
        FlickrImageViewController *imageViewController = segue.destinationViewController;
        NSIndexPath *send = [self.tableView indexPathForSelectedRow];
        imageViewController.imageURL = [FlickrFetcher urlForPhoto:[self.photos objectAtIndex:send.row] format:FlickrPhotoFormatLarge];
        imageViewController.title = [self.tableView cellForRowAtIndexPath:send].textLabel.text;
    }
}

@end
