//
//  FeedViewController.m
//  SmartFeed
//
//  Created by Gustavo Serra on 26/03/15.
//  Copyright (c) 2015 André Vitor Terron. All rights reserved.
//

#import "CardsViewController.h"
#import "CCMPlayNDropView.h"
#import "CardHelper.h"
#import "DailyBond-Swift.h"
#import "CardBirthdayViewController.h"
#import "CardEventViewController.h"
#import "CardNewPostViewController.h"
#import "CardKeepInTouchViewController.h"
#import "Birthday.h"
#import "Event.h"
#import "UserPost.h"
#import "UserMessage.h"
#import "User.h"
#import <POP.h>
#import <UINavigationController+M13ProgressViewBar.h>
#import "UIColor+Custom.h"

@interface CardsViewController ()

@property (strong, nonatomic) CardViewController *activeCard;

@property (strong, nonatomic) NSNumber *loading;

@end

@implementation CardsViewController

#pragma mark - ViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[[SFTaskManager sharedInstance] requestGroupTasks:[[SFUser currentUser] root]];
    [self initProgressIndicators];
    self.loading = @YES;
    [self.progressBirthday setHidden:true];
    [self.progressEvent setHidden:true];
    [self.progressPosts setHidden:true];
    [self.progressChat setHidden:true];
    [self.progressWrite setHidden:true];
}

- (void)initProgressIndicators {
    [self.navigationController showProgress];
    [self.navigationController setIndeterminate:YES];

    self.progressBirthday.progressBackgroundColor = [UIColor semitransparentColor];
    self.progressBirthday.progressColor = [UIColor birthdayColor];

    self.progressEvent.progressBackgroundColor = [UIColor semitransparentColor];
    self.progressEvent.progressColor = [UIColor eventColor];
    
    self.progressPosts.progressBackgroundColor = [UIColor semitransparentColor];
    self.progressPosts.progressColor = [UIColor topPostColor];
    
    self.progressChat.progressBackgroundColor = [UIColor semitransparentColor];
    self.progressChat.progressColor = [UIColor chatColor];

    self.progressWrite.progressBackgroundColor = [UIColor semitransparentColor];
    self.progressWrite.progressColor = [UIColor writeColor];
    
    [self.progressBirthday startWithBlock: ^CGFloat {
        return [[CardsManager sharedInstance] progress:CardsManager.BIRTHDAY];
    }];
    [self.progressEvent startWithBlock: ^CGFloat {
        return [[CardsManager sharedInstance] progress:CardsManager.EVENTS];
    }];
    [self.progressPosts startWithBlock: ^CGFloat {
        return [[CardsManager sharedInstance] progress:CardsManager.POSTS];
    }];
    [self.progressChat startWithBlock: ^CGFloat {
        return [[CardsManager sharedInstance] progress:CardsManager.CHATS];
    }];
    [self.progressWrite startWithBlock: ^CGFloat {
        return [[CardsManager sharedInstance] progress:CardsManager.WRITE];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.loading.boolValue) {
        self.loading = @NO;
        
        float delayInSeconds = 0.1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            sprintAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
            sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
            sprintAnimation.springBounciness = 20.f;
            [self.progressBirthday setHidden:false];
            [self.progressBirthday pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * delayInSeconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            sprintAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
            sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
            sprintAnimation.springBounciness = 20.f;
            [self.progressEvent setHidden:false];
            [self.progressEvent pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * delayInSeconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            sprintAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
            sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
            sprintAnimation.springBounciness = 20.f;
            [self.progressPosts setHidden:false];
            [self.progressPosts pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * delayInSeconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            sprintAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
            sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
            sprintAnimation.springBounciness = 20.f;
            [self.progressChat setHidden:false];
            [self.progressChat pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * delayInSeconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            sprintAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
            sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
            sprintAnimation.springBounciness = 20.f;
            [self.progressWrite setHidden:false];
            [self.progressWrite pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
        });
        
        
        // LOAD CARD RIGHT HERE
        [[CardsManager sharedInstance] loadCurrentCard].then ( ^id (id result) {
            NSLog(@"Finished loading");
            [self.navigationController finishProgress];
            [self showCard:(CardViewController *)result animated:YES];
            return nil;
        });
    }
    else {
        [self.navigationController finishProgress];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Cards methods


- (void)updateProgress {
    [self.progressBirthday updateProgress];
    [self.progressEvent updateProgress];
    [self.progressPosts updateProgress];
    [self.progressChat updateProgress];
    [self.progressWrite updateProgress];
}

- (void)showCard:(CardViewController *)popin animated:(BOOL)animated {
    [self updateProgress];
    if (popin != nil) {
        NSLog(@"Showing card animated...");
        [popin setDelegate:self];
        self.activeCard = popin;
        [CardHelper displayCard:popin fromController:self animated:animated];
        
        
        //        UserMessage* message = [[UserMessage alloc] init];
        //        message.friendName = @"Andre Terron";
        //        message.friendId = @"828648753872660";
        //        message.receivedDate = [NSDate date];
        //        message.read = true;
        //        message.message = @"Loaded from mock: Hey are you going to Facebook Hackathon today? I'm thinking about driving early this morning, but I'm still not sure. What time are you thinking about arriving there? And what about going back??";
        //        message.profileImageUrl = [[User currentUser] profileImageUrl];
    }
}

- (void)cardDismissed {
    NSLog(@"Card dismissed 2");
    self.activeCard = nil;
    [[CardsManager sharedInstance] loadNextCard].then ( ^id (id result) {
        NSLog(@"Finished loading");
        [self showCard:(CardViewController *)result animated:YES];
        return nil;
    });
    //[self showCard];
    //[self dismissCurrentPopinControllerAnimated:NO completion:^{
    
    //    NSLog(@"Card dismissed 4");
    //[self showCard];
    //}];
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
