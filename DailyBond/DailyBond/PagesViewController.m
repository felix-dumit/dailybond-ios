//
//  PagesViewController.m
//  DailyBond
//
//  Created by André Vitor Terron on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "PagesViewController.h"
#import "LoginViewController.h"
#import "CardsViewController.h"

@interface PagesViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) CardsViewController *cardController;

@end

@implementation PagesViewController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CardsManager sharedInstance] loadCards];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueLogin"]) {
//        (LoginViewController)
        LoginViewController *controller = (LoginViewController *) [segue destinationViewController];
        controller.pagesController = self;
    } else if ([segue.identifier isEqualToString:@"segueCards"]) {
        self.cardController = (CardsViewController *) [segue destinationViewController];
    }
}

- (void)startCards {
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0.0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewStopped:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewStopped:scrollView];
}

-(void)scrollViewStopped:(UIScrollView *)scrollView {
    if (round(self.scrollView.contentOffset.x / (float) self.view.bounds.size.width) >= 1) {
        [self.cardController didStartCards];
    }
}

@end
