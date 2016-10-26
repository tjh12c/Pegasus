//
//  TSMapView.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/24/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#ifndef TSMapView_h
#define TSMapView_h

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TruckStopData.h"
#import "TSPointAnnotation.h"
#import "TSAnnotationView.h"
#import "TSCalloutView.h"

@protocol TSMapViewDelegate <NSObject>
-(void)didChangeMapRegionToCoord: (CLLocationCoordinate2D *)coords newRadius:(double)radius;
-(void)didPressShowAll;
@end



@interface TSMapView : UIView <MKMapViewDelegate, UIGestureRecognizerDelegate>

//Variable Declarations
@property (strong, nonatomic) IBOutlet UIView *view; //backing view
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *centerButton;
@property (strong, nonatomic) IBOutlet UIButton *mapTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *showAllButton;

@property (nonatomic) CLLocationCoordinate2D currentLocation;
@property (nonatomic) bool isLocationSet;

//TSMapViewDelegate
@property (nonatomic, weak) id<TSMapViewDelegate> delegate;
- (id)delegate;
- (void)setDelegate:(id<TSMapViewDelegate>)newDelegate; //Setter for delegate

- (IBAction)didPressCenter:(id)sender;
- (IBAction)didPressMapTypeButton:(id)sender;
- (IBAction)didPressShowAllButton:(id)sender;

//Method Declarations
-(void)addTruckStops:(NSArray*)truckStops;
-(void)addTruckStop:(TruckStopData*)data atCoordinate:(CLLocationCoordinate2D *)coord;
-(void)centerViewOnLocation:(CLLocationCoordinate2D)toCoord;
-(void)changeMapToType:(bool)type;
-(void)removePins;

@end


#endif /* TSMapView_h */
