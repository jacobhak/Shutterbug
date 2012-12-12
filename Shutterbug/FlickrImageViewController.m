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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width , self.imageView.image.size.height);
    self.scrollView.contentSize = self.imageView.bounds.size;//CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
    //self.scrollView.clipsToBounds = YES;
    self.scrollView.scrollEnabled = YES;
    [self.scrollView zoomToRect:self.imageView.bounds animated:YES];
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
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];


    //self.scrollView.scrollEnabled = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
