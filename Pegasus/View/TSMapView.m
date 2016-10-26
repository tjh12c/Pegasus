//
//  TSMapView.m
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/24/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import "TSMapView.h"

#define METERS_PER_MILE 1609.344

//Private Stuff
@interface TSMapView() {
    
}
@property (nonatomic, strong) IBOutlet UIPinchGestureRecognizer *pinchRecognizer;
@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizer;
@end


@implementation TSMapView
@synthesize delegate, currentLocation, view, mapView, isLocationSet, centerButton, panRecognizer, pinchRecognizer, mapTypeButton;

//***************************************************
// MARK: - Init and private methods
//***************************************************

- (id)init {
    self = [super init];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
}

-(void)initialize {
    //Set up map
    [panRecognizer setDelegate: self];
    [pinchRecognizer setDelegate: self];
    
    //Get what mode the map should be in
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool mapType = [defaults boolForKey:@"map_type"];
    [self changeMapToType: mapType];
    
    
    //Set up buttons
    self.isLocationSet = false;
    mapTypeButton.imageView.layer.cornerRadius = 7.0f;
    mapTypeButton.layer.cornerRadius = 5.0f;
    mapTypeButton.layer.shadowRadius = 3.0f;
    mapTypeButton.layer.shadowColor = [UIColor blackColor].CGColor;
    mapTypeButton.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    mapTypeButton.layer.shadowOpacity = 0.5f;
    mapTypeButton.layer.masksToBounds = NO;
    
    
    
    centerButton.imageView.layer.cornerRadius = 7.0f;
    centerButton.layer.cornerRadius = 5.0f;
    centerButton.layer.shadowRadius = 3.0f;
    centerButton.layer.shadowColor = [UIColor blackColor].CGColor;
    centerButton.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    centerButton.layer.shadowOpacity = 0.5f;
    centerButton.layer.masksToBounds = NO;
    
}

- (void)awakeFromNib {
    NSString* nibName = @"TSMapView";
    if ([[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil]) {
        [self.view setFrame:[self bounds]];
        [self addSubview:self.view];
    }
    [super awakeFromNib];
    [self initialize];
}

//***************************************************
// MARK: - Class Methods
//***************************************************
///Note: Array MUST be of type TruckStopData
-(void)addTruckStops:(NSArray*)truckStops {
    for(int index = 0; index < truckStops.count; index++) {
        TruckStopData *thisTruckStop = truckStops[index];
        double lat = [thisTruckStop.lat doubleValue];
        double lng = [thisTruckStop.lng doubleValue];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
        [self addTruckStop:thisTruckStop atCoordinate: &coord];
    }
}

-(void)addTruckStop:(TruckStopData *)data atCoordinate:(CLLocationCoordinate2D *)coord  {
    TSPointAnnotation* point = [[TSPointAnnotation alloc] init];
    point.coordinate = *(coord);
    point.data = data;
    
    point.title = @"Truck Stop";
    
    [self.mapView addAnnotation: point];
}

-(void)centerViewOnLocation:(CLLocationCoordinate2D)toCoord {
    NSLog(@"TSMapView: CenterViewOnLocation");
    self.currentLocation = toCoord;
    self.isLocationSet = true;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(toCoord, 100*METERS_PER_MILE, 100*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
}


- (IBAction)didPinchMap:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded){
        NSLog(@"didPinchMap");
        MKCoordinateRegion region = mapView.region;
        CLLocationCoordinate2D mapCoords = self.mapView.centerCoordinate; //Center
        CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:mapCoords.latitude+region.span.latitudeDelta longitude:mapCoords.longitude];
        CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude: mapCoords.latitude longitude: mapCoords.longitude];
        CLLocationDistance distance = [centerLocation distanceFromLocation:newLocation]; //Get radius in meterrs
        double radiusInMiles = distance / METERS_PER_MILE;
        [self.delegate didChangeMapRegionToCoord: &mapCoords newRadius:radiusInMiles];
    }
}

- (IBAction)didPanMap:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded){
        NSLog(@"didPanMap");
        MKCoordinateRegion region = mapView.region;
        CLLocationCoordinate2D mapCoords = self.mapView.centerCoordinate; //Center
        CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:mapCoords.latitude+region.span.latitudeDelta longitude:mapCoords.longitude];
        CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude: mapCoords.latitude longitude: mapCoords.longitude];
        CLLocationDistance distance = [centerLocation distanceFromLocation:newLocation]; //Get radius in meterrs
        double radiusInMiles = distance / METERS_PER_MILE;
        [self.delegate didChangeMapRegionToCoord: &mapCoords newRadius:radiusInMiles];
    }
}

- (id)delegate {
    return delegate;
}

- (void)setDelegate:(id<TSMapViewDelegate>)newDelegate {
    delegate = newDelegate;
}



//***************************************************
// MARK: - Delegate Methods
//***************************************************

//MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    if([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    
    TruckStopData *thisTSData = ((TSPointAnnotation*)annotation).data;
    TSAnnotationView* pin = [[TSAnnotationView alloc] initWithAnnotation:annotation];
    CGRect frame = CGRectMake(0,0,20,40);
    pin.frame = frame;
    
    return pin;
}


- (void)mapView:(MKMapView *)aMapView didSelectAnnotationView:(MKAnnotationView *)aView {
    UIImage *pinImage = [UIImage imageNamed: @"selected icon"];
    CGSize size = CGSizeMake(20, 40);
    UIGraphicsBeginImageContext(size);
    [pinImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    aView.image = newImage;
 
}
- (void)mapView:(MKMapView *)aMapView didDeselectAnnotationView:(MKAnnotationView *)aView {
    UIImage *pinImage = [UIImage imageNamed: @"truck icon"];
    CGSize size = CGSizeMake(20, 40);
    UIGraphicsBeginImageContext(size);
    [pinImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    aView.image = newImage;

}


//MARK: UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}



- (IBAction)didPressCenter:(id)sender {
    if (self.isLocationSet) {
        [self centerViewOnLocation: self.currentLocation];
    }
}


- (IBAction)didPressMapTypeButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool mapType = [defaults boolForKey:@"map_type"];
    if (mapType == 0) {
        [self changeMapToType: 1];
    }
    else {
        [self changeMapToType: 0];
    }
    
}

- (IBAction)didPressShowAllButton:(id)sender {
    [self.delegate didPressShowAll];
}

//0 = Normal mode, 1 = Satellite
-(void)changeMapToType:(bool)type {
    if (type == 0) {
        [self.mapView setMapType: MKMapTypeStandard];
        [self.mapTypeButton setImage:[UIImage imageNamed:@"satellite"] forState: UIControlStateNormal];
    }
    else {
        [self.mapView setMapType: MKMapTypeSatellite];
        [self.mapTypeButton setImage:[UIImage imageNamed:@"map"] forState: UIControlStateNormal];

        
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool: type forKey:@"map_type"];
    [defaults synchronize];
}

-(void)removePins {
    [self.mapView removeAnnotations: self.mapView.annotations];
}

@end
