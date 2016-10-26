//
//  TSSearchView.m
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/24/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import "TSSearchView.h"


@interface TSSearchView() {
    
}
-(void)performSearch:(NSString *)query;
-(bool)checkFormatForZipWithString:(NSString *)str;
@end



@implementation TSSearchView
@synthesize delegate, searchField, searchButton, view;

//***************************************************
// MARK: - Init
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
    NSString* nibName = @"TSSearchView";
    if ([[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil]) {
        [self.view setFrame:[self bounds]];
        [self addSubview:self.view];
    }
    [super awakeFromNib];
}


//***************************************************
// MARK: - Class Methods
//***************************************************

//Public
- (IBAction)didPressSearchButton:(id)sender {
    NSString *searchString = self.searchField.text;
    if (searchString.length > 0) {
        [self.delegate didPerformSearchWithQuery:searchString];
    }
}
- (id)delegate {
    return delegate;
}

- (void)setDelegate:(id<TSSearchViewDelegate>)newDelegate {
    delegate = newDelegate;
}



@end
