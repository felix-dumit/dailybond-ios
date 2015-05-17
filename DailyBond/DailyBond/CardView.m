//
//  SFCardView.m
//  SmartFeed
//
//  Created by André Terron on 4/1/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@implementation CardView

- (void)updateConstraints{
    [super updateConstraints];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // 1 - load interface from xib
        [[NSBundle mainBundle] loadNibNamed:@"CardView" owner:self options:nil];
        
        // 2 - add subview
        [self insertSubview:self.view atIndex:0];
    }
    return self;
}

- (void)updateShadow {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 2.5f);
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self setGravity:4.0f];
    [self setNonDismissingRadius:@120];
    [self updateShadow];
}

- (BFTask *)dismiss {
    return [BFTask taskWithResult:nil];
}

@end
