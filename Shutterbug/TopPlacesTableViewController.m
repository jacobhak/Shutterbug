//
//  TopPlacesTableViewController.m
//  Shutterbug
//
//  Created by Jacob Håkansson on 2012-12-11.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "FlickrFetcher.h"
#import "SaveRecentPhotoTableViewController.h"

@interface TopPlacesTableViewController ()

@end

@implementation TopPlacesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setTopPlaces:(NSArray *)topPlaces {
    _topPlaces = topPlaces;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_queue_t downloadQueue = dispatch_queue_create("FlickrDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *array = [FlickrFetcher topPlaces];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.topPlaces = array;
        });
    });

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog([[FlickrFetcher topPlaces] description]);
    return [self.topPlaces count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Place Description";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *place = [self.topPlaces objectAtIndex:indexPath.row];
    cell.textLabel.text = [place valueForKey:@"woe_name"];
    cell.detailTextLabel.text = [place valueForKey:@"_content"];
    
    return cell;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushToTopPhotos"]
        && [segue.destinationViewController isKindOfClass:[SaveRecentPhotoTableViewController class]]) {
        SaveRecentPhotoTableViewController *ptptvc = segue.destinationViewController;
        NSIndexPath *send = [self.tableView indexPathForSelectedRow];
        dispatch_queue_t downloadQueue = dispatch_queue_create("FlickrDownloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSArray *array = [FlickrFetcher photosInPlace:[self.topPlaces objectAtIndex:send.row] maxResults:50];
            dispatch_async(dispatch_get_main_queue(), ^{
                ptptvc.photos = array;
            });
        });

        ptptvc.title = [self.tableView cellForRowAtIndexPath:send].textLabel.text;
    }
}

@end
