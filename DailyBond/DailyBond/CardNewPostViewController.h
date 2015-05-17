//
//  CardNewPostViewController.h
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewController.h"
@interface CardNewPostViewController : CardViewController
@property (weak, nonatomic) IBOutlet CardView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end
