//
//  LoginViewController.m
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "User.h"
#import "LoginViewController.h"
#import "FXBlurView.h"
#import <UIImageView+WebCache.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //UIImage *image = [UIImage imageNamed:@"mockCover"];
    //[self.imageBackground setImage:[image blurredImageWithRadius:8.0 iterations:20 tintColor:nil]];
    //self.imageBackground.hidden = NO;
    //self.imageProfile.hidden = NO;
    
    if ([User currentUser] != nil) {
        [self showUserInfoAnimated:NO];
    }
}


- (IBAction)openMenu:(id)sender {
    NSLog(@"Open Menu");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginWithFacebook:(id)sender {
    [User loginWithFacebookInBackground].then ( ^id (id result) {
        [self showUserInfoAnimated:YES];
        return nil;
    });
    //    [self showUserInfoAnimated:YES];
}

- (void)showUserInfoAnimated:(BOOL)animated {
    // PREPARE
    if (animated) {
        self.imageProfile.alpha = 0.0;
        self.imageProfile.hidden = NO;
        self.imageBackground.alpha = 0.0;
        self.imageBackground.hidden = NO;
        //self.groupStart.alpha = 0.0;
        self.groupStart.alpha = 1.0;
        self.groupStart.hidden = NO;
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        self.groupStart.transform = CGAffineTransformMakeTranslation(-keyWindow.bounds.size.width, 0.0);
        self.groupUserInfo.alpha = 0.0;
        self.groupUserInfo.hidden = NO;
    }
    
    // SET IMAGES
    
    
    User *user = [User currentUser];
    UIImage *image = [UIImage imageNamed:@"mockCover"];
    [self.imageBackground setImage:[image blurredImageWithRadius:8.0 iterations:20 tintColor:nil]];
//    self.imageBackground.
    //UIImage *picture = [UIImage imageNamed:@"mockProfile"];
    //[self.imageProfile setImage:picture];
    [self.imageProfile sd_setImageWithURL:user.profileImageUrl.URL];
    self.labelName.text = user.name;
    
    // ANIMATE
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations: ^{
            self.imageProfile.alpha = 1.0;
            self.imageBackground.alpha = 1.0;
            self.buttonLogin.alpha = 0.0;
            self.groupStart.transform = CGAffineTransformIdentity;
            self.labelAppName.alpha = 0.0;
            self.groupUserInfo.alpha = 1.0;
        } completion: ^(BOOL finished) {
        }];
    }
    else {
        self.imageProfile.alpha = 1.0;
        self.imageBackground.alpha = 1.0;
        self.groupStart.alpha = 1.0;
        self.groupStart.transform = CGAffineTransformIdentity;
        self.buttonLogin.alpha = 0.0;
        self.labelAppName.hidden = YES;
        self.groupUserInfo.alpha = 1.0;
        self.groupUserInfo.hidden = NO;
        self.imageProfile.hidden = NO;
        self.imageBackground.hidden = NO;
        self.groupStart.hidden = NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:@"segueStart"]) {
    }
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
