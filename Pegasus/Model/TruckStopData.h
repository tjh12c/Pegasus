//
//  TruckStopData.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/23/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface TruckStopData : NSObject


@property (nonatomic) NSString *name,
    *city,
    *state,
    *country,
    *zip,
    *rawLine1,
    *rawLine2,
    *rawLine3,
    *lat,
    *lng;


-(instancetype)initWithData:(NSDictionary*)dict;

@end
