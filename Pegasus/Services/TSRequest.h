//
//  TSRequest.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/19/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol TSRequestDelegate <NSObject>
@required
-(void)didFetchJSON:(NSDictionary *)asDictionary;
-(void)fetchJSONError:(NSError *)error;

@end



@interface TSRequest : NSObject
//Singleton
+ (id)sharedInstance;

//Class Variables
@property (nonatomic, weak) id<TSRequestDelegate> delegate;

//Class Methods
- (void) performAPIRequestWithRadius:(int)radius latitude:(CLLocationDegrees *)lat longitude:(CLLocationDegrees *)lng;
- (id)delegate;
- (void)setDelegate:(id<TSRequestDelegate>)newDelegate; //Setter for delegate

@end
