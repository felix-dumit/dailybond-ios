//
//  CardKeepInTouchViewController.h
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewController.h"
@interface CardKeepInTouchViewController : CardViewController
@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet CardView *cardView;

@end
