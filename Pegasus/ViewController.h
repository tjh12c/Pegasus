//
//  ViewController.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/18/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"
#import "TSRequest.h"
#import "TSMapView.h"
#import "TSSearchView.h"
#import "TSLocationAlertView.h"
#import "TruckStopData.h"

@interface ViewController : UIViewController <TSRequestDelegate, CLLocationManagerDelegate, TSLocationAlertDelegate, TSMapViewDelegate, TSSearchViewDelegate>


//***************************************************
// MARK: - Variables
//***************************************************

//TSSearchView
@property (strong, nonatomic) IBOutlet TSSearchView *searchView;

//TSMapView
@property (strong, nonatomic) IBOutlet TSMapView *mapView;

//Footer (for when location services are not enabled)
@property (strong, nonatomic) IBOutlet TSLocationAlertView *footerView;

@property (nonatomic)  CLLocationCoordinate2D *currentLocation;
@property (nonatomic) NSArray *truckStops;

//***************************************************
// MARK: - Class Methods and Delegates
//***************************************************

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

//TSRequestDelegate
-(void)didFetchJSON:(NSDictionary *)asDictionary;
-(void)fetchJSONError:(NSError *)error;

//CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status;

@end

