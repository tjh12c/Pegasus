//
//  TSCalloutView.m
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/26/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import "TSCalloutView.h"

@implementation TSCalloutView
@synthesize view, nameLabel, distanceLabel, addressLabel;

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

- (void)awakeFromNib {
    NSString* nibName = @"TSCalloutView";
    if ([[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil]) {
        [self.view setFrame:[self bounds]];
        [self addSubview:self.view];
    }
    [super awakeFromNib];
}

-(void)configureCalloutWithData:(TruckStopData*)data distance:(double)dist {
    self.nameLabel.text = data.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f miles away", dist];
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@, %@", data.city, data.state, data.zip];
    
    
}

@end
