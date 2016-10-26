//
//  TSPointAnnotation.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/25/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "TruckStopData.h"

@interface TSPointAnnotation : MKPointAnnotation

@property TruckStopData* data;

@end
