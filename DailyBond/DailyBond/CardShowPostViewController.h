//
//  CardShowPostViewController.h
//  DailyBond
//
//  Created by Nick-Retina on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewController.h"

@interface CardShowPostViewController : CardViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) IBOutlet CardView *cardView;

@end
