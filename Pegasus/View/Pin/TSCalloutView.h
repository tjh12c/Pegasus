//
//  TSCalloutView.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/26/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TruckStopData.h"

@interface TSCalloutView : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

-(void)configureCalloutWithData:(TruckStopData*)data distance:(double)dist;
@end
