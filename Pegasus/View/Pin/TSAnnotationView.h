//
//  TSAnnotationView.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/25/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "TSPointAnnotation.h"
#import "TSCalloutView.h"

@interface TSAnnotationView : MKAnnotationView
@property TruckStopData *data;

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation;
@end
