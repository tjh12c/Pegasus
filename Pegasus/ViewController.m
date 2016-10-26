//
//  ViewController.m
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/18/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {
    CLLocationManager *locationManager;
}
@end


@implementation ViewController
@synthesize currentLocation, truckStops;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footerView.delegate = self;
    self.mapView.delegate = self;
    self.searchView.delegate = self;
    
    self.truckStops = [[NSMutableArray alloc] init];
    
    //Set up locationManager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startMonitoringSignificantLocationChanges];
    
    
    
    [TSRequest.sharedInstance setDelegate:self];
    //CORRECT URL STYLE
    //http://webapp.transflodev.com/svc1.transflomobile.com/api/v3/stations/100/?lat=29.262002&lng=-81.13250900000003
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSURL *)createURLForQuery:(int)radius latitude:(CLLocationDegrees *)lat longitude:(CLLocationDegrees *)lng {
    NSString *radiusString = [NSString stringWithFormat:@"%d", radius];
    NSString *urlAsString = [NSString stringWithFormat:@"%@%@/?lat=%lf&lng=%lf", REST_ENDPOINT, radiusString, *lat, *lng];
    NSLog(@"ViewController: createURLForQuery url is %@", urlAsString);
    NSURL *url = [NSURL URLWithString: urlAsString];
    return url;
}


-(NSArray *)fetchModelDataFromQuery:(NSDictionary *)dict {
    NSMutableArray *returnData = [[NSMutableArray alloc] init];
    
    NSArray *truckStopArray = [dict objectForKey:@"truckStops"];
    for (int index = 0; index < truckStopArray.count; index++) {
        NSDictionary *thisTSDict = truckStopArray[index];
        TruckStopData *tempData = [[TruckStopData alloc] initWithData: thisTSDict];
        [returnData addObject: tempData];
    }
    return returnData;
}


//***************************************************
// MARK: - Delegate Methods
//***************************************************

//MARK: - TSRequestDelegate
-(void)didFetchJSON:(NSDictionary *)asDictionary {
    NSLog(@"ViewController: didFetchJSON");
    NSArray *truckStopArray = [self fetchModelDataFromQuery:asDictionary];
    self.truckStops = truckStopArray;
    [self.mapView addTruckStops: truckStopArray];
}

-(void)fetchJSONError:(NSError *)error {
    NSLog(@"ViewController: fetchJSONError");
}

//MARK: CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        self.footerView.hidden = true;
        [locationManager startMonitoringSignificantLocationChanges];
    }
    else {
        self.footerView.hidden = false;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"didUpdateLocations");
    CLLocationDegrees lat = locationManager.location.coordinate.latitude;
    CLLocationDegrees lng = locationManager.location.coordinate.longitude;
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
    self.currentLocation = &coord;  //Create place in memory and assign that location to self.currentLocation
    [self.mapView centerViewOnLocation: *(self.currentLocation)];
    [TSRequest.sharedInstance performAPIRequestWithRadius: 100 latitude: &coord.latitude longitude: &coord.longitude];
}

- (void)locationManager:(CLLocationManager *) manager didFailWithErrorNSError:(NSError *)error{
    NSLog(@"ViewController: locationManager didFailWithNSError!");
}

//MARK: TSLocationAlertDelegate
-(void)didTapTSLocationAlertView {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

//MARK: TSMapViewDelegate
-(void)didChangeMapRegionToCoord: (CLLocationCoordinate2D *)coords newRadius:(double)radius {
    [TSRequest.sharedInstance performAPIRequestWithRadius:radius latitude: &coords->latitude longitude: &coords->longitude];
}

-(void)didPressShowAll {
    [self.mapView removePins];
    [self.mapView addTruckStops: truckStops];
    self.mapView.showAllButton.hidden = true;

}

//MARK: TSSearchViewDelegate
-(void)didPerformSearchWithQuery:(NSString *)str {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if ([self checkFormatForZipWithString: str]) {
        for (int i = 0; i < self.truckStops.count; i++) {
            TruckStopData *thisTruckStop = [truckStops objectAtIndex:i];
            if([thisTruckStop.zip isEqualToString:str]) {
                [tempArray addObject: thisTruckStop];
            }
        }
    }
    else {
        for (int i = 0; i < self.truckStops.count; i++) {
            TruckStopData *thisTruckStop = [truckStops objectAtIndex:i];
            if([thisTruckStop.city isEqualToString:str]) {
                [tempArray addObject: thisTruckStop];
            }
            else if([thisTruckStop.state isEqualToString:str]) {
                [tempArray addObject: thisTruckStop];
            }
            else if([thisTruckStop.name isEqualToString:str]) {
                [tempArray addObject: thisTruckStop];
            }
        }
    }
    [self.mapView removePins];
    self.mapView.showAllButton.hidden = false;
    [self.mapView addTruckStops: tempArray];
}



-(bool)checkFormatForZipWithString:(NSString *)str {
    NSString *postcodeRegex = @"(^[0-9]{5}(-[0-9]{4})?$)";
    NSPredicate *postcodeValidate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", postcodeRegex];
    if ([postcodeValidate evaluateWithObject: str] == YES) {
        return true;
    } else {
        return true;
    }
}

@end
