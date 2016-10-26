//
//  TSLocationAlertView.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/24/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#ifndef TSLocationAlertView_h
#define TSLocationAlertView_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol TSLocationAlertDelegate <NSObject>
-(void)didTapTSLocationAlertView;
@end





@interface TSLocationAlertView : UIView

@property (nonatomic, weak) id<TSLocationAlertDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UILabel *topLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;



//Class Methods
- (id)delegate;
- (void)setDelegate:(id<TSLocationAlertDelegate>)newDelegate; //Setter for delegate


@end



#endif /* TSLocationAlertView_h */
