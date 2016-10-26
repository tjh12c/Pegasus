//
//  TSLocationAlertView.m
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/24/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//


#import "TSLocationAlertView.h" 




@interface TSLocationAlertView () {

}


- (void)initialize; //hidden
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end





@implementation TSLocationAlertView
@synthesize delegate, topLabel, bottomLabel, view;


//***************************************************
// MARK: - Init and private methods
//***************************************************


- (id)init {
    self = [super init];
    [self initialize];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initialize];
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
    //All actions that need to be taken on init
}

- (void)awakeFromNib {
    NSString* nibName = @"TSLocationAlertView";
    if ([[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil]) {
        [self.view setFrame:[self bounds]];
        [self addSubview:self.view];
    }
    [super awakeFromNib];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegate didTapTSLocationAlertView];
}


- (id)delegate {
    return delegate;
}

- (void)setDelegate:(id<TSLocationAlertDelegate>)newDelegate {
    delegate = newDelegate;
}

//***************************************************
// MARK: - Public Methods
//***************************************************



@end
