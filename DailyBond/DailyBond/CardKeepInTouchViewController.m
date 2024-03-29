//
//  CardKeepInTouchViewController.m
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "CardKeepInTouchViewController.h"
#import "UserMessage.h"
#import "User.h"

@interface CardKeepInTouchViewController ()

@end

@implementation CardKeepInTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.cardView.titleLabel setBackgroundColor:[UIColor chatColor]];
    
    UserMessage *message = self.cardData;
    
    [self.profileImageView sd_setImageWithURL:message.profileImageUrl.URL];
    [self.messageTitleLabel setText:message.friendName];
    [self.messageContentLabel setText:message.message];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onDismissButtonPressed:(id)sender {
    [self dismissAnimated];
}

- (IBAction)onReplyButtonPressed:(id)sender {
    UserMessage *message = self.cardData;
    NSString *url = [NSString stringWithFormat:@"https://www.facebook.com/%@", message.friendId];
    [BFAppLinkNavigation navigateToURLInBackground:url.URL].then ( ^id (id result) {
        return nil;
    }).catch ( ^id (NSError *error) {
        NSLog(@"Error: %@", error);
        return nil;
    });
}

-(CardView *)getCardView;
{
    return self.cardView;
}


@end
