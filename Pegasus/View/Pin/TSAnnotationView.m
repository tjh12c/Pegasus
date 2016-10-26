//
//  TSAnnotationView.m
//  Pegasus
//
//  Created by Tyler Hunnefeld on 10/25/16.
//  Copyright © 2016 TylerHunnefeld. All rights reserved.
//

#import "TSAnnotationView.h"

@implementation TSAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation {
    self = [super initWithAnnotation:annotation
                     reuseIdentifier:nil];
    
    TSPointAnnotation *point = (TSPointAnnotation*) annotation;

    self.data = point.data;
    self.image = [UIImage imageNamed:@"truck icon"];
    // Callout settings - if you want a callout bubble
    self.canShowCallout = NO;
    
    return self;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView != nil)
    {
        [self.superview bringSubviewToFront:self];
    }
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect rect = self.bounds;
    BOOL isInside = CGRectContainsPoint(rect, point);
    if(!isInside)
    {
        for (UIView *view in self.subviews)
        {
            isInside = CGRectContainsPoint(view.frame, point);
            if(isInside)
                break;
        }
    }
    return isInside;
}


@end
