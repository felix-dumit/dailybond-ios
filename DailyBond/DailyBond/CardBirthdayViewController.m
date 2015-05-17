//
//  CardBirthdayViewController.m
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "CardBirthdayViewController.h"
#import "Birthday.h"
#import "MessengerSharer.h"

@interface CardBirthdayViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation CardBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cardView.titleLabel setBackgroundColor:[UIColor birthdayColor]];
    
    Birthday *birthday = (Birthday *)self.cardData;
    // Do any additional setup after loading the view from its nib.
    [self setDescriptionLabelWithName:birthday.friendName];
    [self.userImageView sd_setImageWithURL:birthday.pictureURL.URL];
    [self.userImageView sd_setImageWithURL:birthday.pictureURL.URL placeholderImage:[UIImage imageNamed:@"DailyBondCard"] options:0 completed:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Helper Methods
- (void)setDescriptionLabelWithName:(NSString *)aName {
    // TODO: Consider gender in message: Give %s congratulations for "his" birthday
    [self.descriptionLabel setText:[NSString stringWithFormat:@"Send %@ congratulations!", aName]];
    return;
}

#pragma mark - Buttons delegates
- (IBAction)onDismissPressed:(id)sender {
    [MessengerSharer testShare];
    [self dismissAnimated];
}

- (IBAction)onSendPressed:(id)sender {
    Birthday *birthday = (Birthday *)self.cardData;
    
    NSString *url = [NSString stringWithFormat:@"https://www.facebook.com/%@", birthday.friendId];
    [BFAppLinkNavigation navigateToURLInBackground:url.URL].then ( ^id (id result) {
        return nil;
    }).catch ( ^id (NSError *error) {
        NSLog(@"Error: %@", error);
        return nil;
    });
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (CardView *)getCardView;
{
    return self.cardView;
}

@end
