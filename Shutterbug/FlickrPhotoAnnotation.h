//
//  FlickrPhotoAnnotation.h
//  Shutterbug
//
//  Created by Jacob Håkansson on 2012-12-18.
//  Copyright (c) 2012 Jacob Håkansson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FlickrPhotoAnnotation : NSObject <MKAnnotation>

+ (FlickrPhotoAnnotation *)annotationForPhoto:(NSDictionary *)photo;

@property (nonatomic, strong) NSDictionary *photo; 

@end
