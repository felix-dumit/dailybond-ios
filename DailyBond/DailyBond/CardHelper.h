//
//  SFCardHelper.h
//  SmartFeed
//
//  Created by André Terron on 4/2/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardViewController.h"
#import <UIKit/UIKit.h>
@interface CardHelper : NSObject

+ (void) displayCard:(CardViewController *)cardController fromController:(UIViewController *) controller animated:(BOOL)animated;
+ (void) displayCard:(CardViewController *)cardController fromController:(UIViewController *) controller;

@end
