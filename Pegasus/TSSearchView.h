//
//  TSSearchView.h
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/24/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#ifndef TSSearchView_h
#define TSSearchView_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TSSearchViewDelegate <NSObject>
-(void)didPerformSearchWithQuery: (NSString *)str;

@end


@interface TSSearchView : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (nonatomic, weak) id<TSSearchViewDelegate> delegate;
- (id)delegate;
- (void)setDelegate:(id<TSSearchViewDelegate>)newDelegate;

- (IBAction)didPressSearchButton:(id)sender;
@end

#endif /* TSSearchView_h */
