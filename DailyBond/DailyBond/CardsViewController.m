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
    self.loading = @YES;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.loading.boolValue) {
        self.loading = @NO;
        
        
        // LOAD CARD RIGHT HERE
        [self showCardAnimated:animated];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Cards methods

- (void)showCard {
    [self showCardAnimated:YES];
}

- (void)showCardAnimated:(BOOL)animated {
    if (self.activeCard) {
        [self.activeCard dismissAnimated];
        return;
    }
    
    NSLog(@"Showing card...");
    
    // TODO : LOAD CONTROLLER HERE RIGHT NOWWW!!!
    CardViewController *popin;
    switch (3) {
        case 0:
            popin = [[CardBirthdayViewController alloc] init];
            popin.cardData = [Birthday generateMockBirthDays][0];
            break;
            
        case 1:
            popin = [[CardEventViewController alloc] init];
            popin.cardData = [Event generateMockData][0];
            break;
        case 2: {

            popin = [[CardNewPostViewController alloc] init];
            UserPost *post = [UserPost generateMockData];
            popin.cardData = post;
            break;
        }
            
        case 3:
            popin = [[CardKeepInTouchViewController alloc] init];
            UserMessage* message = [[UserMessage alloc] init];
            message.friendName = @"Andre Terron";
            message.friendId = @"828648753872660";
            message.receivedDate = [NSDate date];
            message.read = true;
            message.message = @"Loaded from mock: Hey are you going to Facebook Hackathon today? I'm thinking about driving early this morning, but I'm still not sure. What time are you thinking about arriving there? And what about going back??";
            message.profileImageUrl = [[User currentUser] profileImageUrl];
            popin.cardData = message;
            break;
    }
    
    //[[SFCardFlowManager sharedInstance] getNextCardController];
    
    //SFCardViewController *popin = [[SFCardManager sharedInstance] getNextCard]; //[[SFTutorialViewController alloc] initWithNibName:@"SFTutorialViewController" bundle:nil];
    //popin.view.frame = CGRectMake(0, 0, 320, 500);
    
    [popin setDelegate:self];
    
    //[popin setPopinOptions:BKTPopinBlurryDimmingView];
    //[popin setPopinTransitionStyle:BKTPopinTransitionStyleSnap];
    //[popin setPopinOptions:BKTPopinDisableAutoDismiss];
    //BKTBlurParameters *blurParameters = [[BKTBlurParameters alloc] init];
    //blurParameters.alpha = 0.5;
    //    blurParameters.tintColor = [UIColor colorWithWhite:0 alpha:0.5];
    //    blurParameters.radius = 0.3;
    //    [popin setBlurParameters:blurParameters];
    //[popin setPopinOptions:BKTPopinDimmingViewStyleNone | BKTPopinDisableAutoDismiss];
    //popin.presentingController = self;
    
    //Present popin on the desired controller
    //Note that if you are using a UINavigationController, the navigation bar will be active if you present
    // the popin on the visible controller instead of presenting it on the navigation controller
    
    self.activeCard = popin;
    [CardHelper displayCard:popin fromController:self animated:animated];
    
    //NSLog(@"ready to show!");
    //[self presentPopinController:popin animated:YES completion:^{
    //    NSLog(@"Popin presented !");
    //}];
}

- (void)cardDismissed {
    NSLog(@"Card dismissed 2");
    self.activeCard = nil;
    [self showCard];
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
