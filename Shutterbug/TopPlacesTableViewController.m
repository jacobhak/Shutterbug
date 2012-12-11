//
//  TopPlacesTableViewController.m
//  Shutterbug
//
//  Created by Jacob Håkansson on 2012-12-11.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "FlickrFetcher.h"
#import "PlaceTopPhotosTableViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.topPlaces = [FlickrFetcher topPlaces];
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

//    PlaceTopPhotosTableViewController *detailViewController = [[PlaceTopPhotosTableViewController alloc] initWithNibName:@"PlaceTopPhotos" bundle:nil];
   NSLog([[FlickrFetcher photosInPlace:[self.topPlaces objectAtIndex:indexPath.row] maxResults:50] description]);
//    detailViewController.photos = [FlickrFetcher photosInPlace:[self.topPlaces objectAtIndex:indexPath.row] maxResults:50];
//    // Pass the selected object to the new view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushToTopPhotos"]
        && [segue.destinationViewController isKindOfClass:[PlaceTopPhotosTableViewController class]]) {
        PlaceTopPhotosTableViewController *ptptvc = segue.destinationViewController;
        NSIndexPath *send = [self.tableView indexPathForSelectedRow];
        ptptvc.photos = [FlickrFetcher photosInPlace:[self.topPlaces objectAtIndex:send.row] maxResults:50];
    }
}

@end
