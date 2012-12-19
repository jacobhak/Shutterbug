//
//  FlickrPhotoAnnotation.m
//  Shutterbug
//
//  Created by Jacob Håkansson on 2012-12-18.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import "FlickrPhotoAnnotation.h"
#import "FlickrFetcher.h"

@implementation FlickrPhotoAnnotation

+ (FlickrPhotoAnnotation *)annotationForPhoto:(NSDictionary *)photo {
    FlickrPhotoAnnotation *annotation = [[FlickrPhotoAnnotation alloc] init];
    annotation.photo = photo;
    return annotation;
}

- (NSString *)title {
    return [self.photo objectForKey:FLICKR_PHOTO_TITLE];
}

- (NSString *)subtitle {
    return [self.photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
}

-(CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.photo objectForKey:FLICKR_LATITUDE] doubleValue];
    coordinate.longitude = [[self.photo objectForKey:FLICKR_LONGITUDE] doubleValue];
    return coordinate;
}

@end
