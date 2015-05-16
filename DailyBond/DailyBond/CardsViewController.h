//
//  FeedViewController.h
//  SmartFeed
//
//  Created by Gustavo Serra on 26/03/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMPlayNDropView.h"
#import "CardViewController.h"
#import "UIViewController+MaryPopin.h"

@interface CardsViewController : UIViewController <SFCardViewControllerDelegate>

-(void)cardDismissed;

@end
