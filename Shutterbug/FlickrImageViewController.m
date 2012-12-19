//
//  FlickrImageViewController.m
//  Shutterbug
//
//  Created by Jacob Håkansson on 2012-12-12.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import "FlickrImageViewController.h"

@interface FlickrImageViewController () <UIScrollViewDelegate>
@property (nonatomic,weak)IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation FlickrImageViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];


}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

//-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
//    view.frame = CGRectMake(0, 0, view.frame.size.width*scale, view.frame.size.height *scale);// view.frame.size.height*scale;
//    
//    scrollView.contentSize = view.frame.size;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    dispatch_queue_t downloadQueue = dispatch_queue_create("FlickrDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        while (!self.imageURL) {
            //wait
        }
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width , self.imageView.image.size.height);
            self.scrollView.contentSize = self.imageView.bounds.size;//CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
            //self.scrollView.clipsToBounds = YES;
            
            [self.scrollView zoomToRect:self.imageView.bounds animated:YES];
            self.scrollView.scrollEnabled = YES;
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
