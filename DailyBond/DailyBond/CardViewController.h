//
//  SFCardViewController.h
//  SmartFeed
//
//  Created by André Terron on 4/2/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "CCMPlayNDropView.h"
#import "UIViewController+MaryPopin.h"
#import <UIImageView+WebCache.h>

@protocol SFCardViewControllerDelegate <NSObject>

-(void)cardDismissed;

@end

@interface CardViewController : UIViewController <CCMPlayNDropViewDelegate>

@property (weak) IBOutlet id<SFCardViewControllerDelegate> delegate;

-(void)CCMPlayNDropViewWillStartDismissAnimationWithDynamics:(CCMPlayNDropView *)view;
-(void)CCMPlayNDropViewDidFinishDismissAnimationWithDynamics:(CCMPlayNDropView *)view;
-(void)CCMPlayNDropViewCanceledDismissWithDynamics:(CCMPlayNDropView *)view;
-(void)CCMPlayNDropView:(CCMPlayNDropView *)view willStartDismissCancelAnimationWithDuration:(CGFloat)duration;
-(void)CCMPlayNDropViewDidFinishDismissCancelAnimation:(CCMPlayNDropView *)view;
-(void)CCMPlayNDropViewManualTraslationDidStart:(CCMPlayNDropView *)view;


-(void)dismiss;
-(void)dismissAnimated;
-(void)show;

-(CardView *)getCardView;
@property (strong,nonatomic) id cardData;

@end
