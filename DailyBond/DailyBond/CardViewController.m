//
//  SFCardViewController.m
//  SmartFeed
//
//  Created by André Terron on 4/2/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()

@property UIDynamicAnimator *animator;


@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)CCMPlayNDropViewWillStartDismissAnimationWithDynamics:(CCMPlayNDropView *)view {
    
}
-(void)CCMPlayNDropViewDidFinishDismissAnimationWithDynamics:(CCMPlayNDropView *)view {
    NSLog(@"Card dismissed 1");
    
    CGRect frame = self.view.frame;
    frame.origin.y = -1000;
    frame.origin.x = 0;
    self.view.frame = frame;
    //[view removeFromSuperview];
    
    
    [self dismissCurrentPopinControllerAnimated:NO completion:^{
        
        NSLog(@"Card dismissed 3");
        //[self showCard];
    }];
    [self dismiss];
}

-(CardView *)getCardView {
    return nil;
}

- (void)show {
    
    //[[self getCardView] show];
    
    if (!self.animator) {
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view.superview];
    }
    [self.animator removeAllBehaviors];
    
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    CGPoint startingPoint = keyWindow.center;
    startingPoint.y = - startingPoint.y;

    self.view.center = startingPoint;
    self.view.transform = CGAffineTransformMakeRotation((arc4random_uniform(20) - 10) * M_PI / 180.0);
    
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.view snapToPoint:keyWindow.center];
    snapBehaviour.damping = 1.2f;
    [self.animator addBehavior:snapBehaviour];
}

-(void)dismiss {
    [self.delegate cardDismissed];
}

-(void)dismissAnimated {
    NSLog(@"dismissing...");
    //[[self getCardView] dismiss];
    
    if (!self.animator) {
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view.superview];
    }
    [self.animator removeAllBehaviors];
    
    
    //IWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    //CGPoint startingPoint = keyWindow.center;
    //startingPoint.y = 0;//- startingPoint.y;
    
    //self.view.center = startingPoint;
    //self.view.transform = CGAffineTransformMakeRotation((arc4random_uniform(20) - 10) * M_PI / 180.0);
    
    //UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.view snapToPoint:keyWindow.center];
    //snapBehaviour.damping = 1.2f;
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.view]];
    [itemBehavior addAngularVelocity:arc4random_uniform(6) - 2.0f forItem:self.view];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.view]];
    gravityBehavior.magnitude = 5.0f;
    
    [self.animator addBehavior:itemBehavior];
    [self.animator addBehavior:gravityBehavior];
    
    [[self getCardView] beginDismissCheck];
    NSLog(@"card dismissed");
    NSLog(@"delegate called");
}

-(void)CCMPlayNDropViewCanceledDismissWithDynamics:(CCMPlayNDropView *)view {
    
}
-(void)CCMPlayNDropView:(CCMPlayNDropView *)view willStartDismissCancelAnimationWithDuration:(CGFloat)duration {
    
}
-(void)CCMPlayNDropViewDidFinishDismissCancelAnimation:(CCMPlayNDropView *)view {
    
}
-(void)CCMPlayNDropViewManualTraslationDidStart:(CCMPlayNDropView *)view {
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
