//
//  TruckStopData.m
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/23/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import "TruckStopData.h"



@implementation TruckStopData
@synthesize name, city, state, country, zip, lat, lng, rawLine1, rawLine2, rawLine3;

-(instancetype)initWithData:(NSDictionary *)dict {
    self = [super init];
    
    self.name = [dict objectForKey:@"name"];
    self.city = [dict objectForKey:@"city"];
    self.state = [dict objectForKey:@"state"];
    self.country = [dict objectForKey:@"country"];
    self.zip = [dict objectForKey:@"zip"];
    self.lat = [dict objectForKey:@"lat"];
    self.lng = [dict objectForKey:@"lng"];
    self.rawLine1 = [dict objectForKey:@"rawLine1"];
    self.rawLine2 = [dict objectForKey:@"rawLine2"];
    self.rawLine3 = [dict objectForKey:@"rawLine3"];
    return self;
}



@end
