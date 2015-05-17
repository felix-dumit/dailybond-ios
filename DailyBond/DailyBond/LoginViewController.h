//
//  LoginViewController.h
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDSideBarController.h"
#import "PagesViewController.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIView *groupStart;
@property (weak, nonatomic) IBOutlet UILabel *labelAppName;
@property (weak, nonatomic) IBOutlet UIView *groupUserInfo;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIView *groupMenu;
- (IBAction)openMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelIntro1;
@property (weak, nonatomic) IBOutlet UILabel *labelIntro2;

@property (strong, nonatomic) PagesViewController *pagesController;

@end
