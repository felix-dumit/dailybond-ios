//
//  CardBirthdayViewController.m
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "CardBirthdayViewController.h"
#import "Birthday.h"

@interface CardBirthdayViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation CardBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Birthday *birthday = (Birthday*) self.cardData;
    // Do any additional setup after loading the view from its nib.
    [self setDescriptionLabelWithName:birthday.friendName];
    [self.userImageView sd_setImageWithURL:birthday.pictureURL.URL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Helper Methods
- (void) setDescriptionLabelWithName:(NSString*)aName
{
    // TODO: Consider gender in message: Give %s congratulations for "his" birthday
    [self.descriptionLabel setText:[NSString stringWithFormat:@"Send %@ congratulations!", aName]];
    return;
}

#pragma mark - Buttons delegates
- (IBAction)onDismissPressed:(id)sender {
}

- (IBAction)onSendPressed:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(CardView *)getCardView;
{
    return self.cardView;
}

@end
