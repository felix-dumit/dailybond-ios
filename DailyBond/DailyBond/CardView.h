//
//  SFCardView.h
//  SmartFeed
//
//  Created by André Terron on 4/1/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMPlayNDropView.h"
#import <Bolts/Bolts.h>

@interface CardView : CCMPlayNDropView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBInspectable NSString *title;
//@property (weak, nonatomic) IBInspectable UIColor *titleColor;
//@property (weak, nonatomic) IBInspectable UIColor *titleBackgroundColor;

- (BFTask *) dismiss;

@end
