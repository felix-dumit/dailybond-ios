//
//  PagesViewController.m
//  DailyBond
//
//  Created by André Vitor Terron on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "PagesViewController.h"
#import "LoginViewController.h"

@implementation PagesViewController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueLogin"]) {
//        (LoginViewController)
        LoginViewController *controller = (LoginViewController *) [segue destinationViewController];
        controller.pagesController = self;
    }
}

@end
