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
#import "KKProgressTimer.h"

@interface CardsViewController : UIViewController <SFCardViewControllerDelegate>
@property (weak, nonatomic) IBOutlet KKProgressTimer *progressBirthday;
@property (weak, nonatomic) IBOutlet KKProgressTimer *progressEvent;
@property (weak, nonatomic) IBOutlet KKProgressTimer *progressPosts;
@property (weak, nonatomic) IBOutlet KKProgressTimer *progressChat;
@property (weak, nonatomic) IBOutlet KKProgressTimer *progressWrite;
@property (weak, nonatomic) IBOutlet UIView *doneCheck;

@property (weak, nonatomic) IBOutlet UIView *groupFinished;


-(void)didStartCards;

-(void)cardDismissed;

@end
