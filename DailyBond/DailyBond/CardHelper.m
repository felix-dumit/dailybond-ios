//
//  SFCardHelper.m
//  SmartFeed
//
//  Created by André Terron on 4/2/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

#import "CardHelper.h"

@interface CardHelper ()

@end

@implementation CardHelper

+ (void) displayCard:(CardViewController *)cardController fromController:(UIViewController *) controller animated:(BOOL)animated {
    
    if (animated) {
        cardController.view.frame = CGRectMake(0, -1000, 320, 400);
        [cardController show];
    } else {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        cardController.view.bounds = CGRectMake(0,0,320,400);
        cardController.view.center = keyWindow.center;
    }
    
    [controller.view addSubview:cardController.view];
}

+ (void) displayCard:(CardViewController *)cardController fromController:(UIViewController *) controller {
    
    
    
//    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:cardController.view.superview];
//
//    [animator removeAllBehaviors];
//    
//    //self.hidden = NO;
//    
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    NSLog(@"%lf x %lf", cardController.view.bounds.size.width, cardController.view.bounds.size.height);
//    //cardController.view.frame = CGRectMake(100, 100, 300, 300);
//    
//    CGPoint startingPoint = keyWindow.center;
//    //startingPoint.y = - startingPoint.y;
//
//    cardController.view.center = startingPoint;
//    //cardController.view.transform = CGAffineTransformMakeRotation((arc4random_uniform(20) - 10) * M_PI / 180.0);
//    
//    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:cardController.view snapToPoint:keyWindow.center];
//    snapBehaviour.damping = 5.0f;
//    [animator addBehavior:snapBehaviour];
    cardController.view.frame = CGRectMake(0, -1000, 320, 400);
    [cardController show];
    
    [controller.view addSubview:cardController.view];
}

@end
