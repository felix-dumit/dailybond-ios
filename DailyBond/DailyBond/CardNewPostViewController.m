//
//  CardNewPostViewController.m
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "CardNewPostViewController.h"
#import "NSDate+Formatter.h"
#import "User.h"
#import <SVProgressHUD.h>

@interface CardNewPostViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation CardNewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cardView.titleLabel setBackgroundColor:[UIColor writeColor]];
    
    // Do any additional setup after loading the view from its nib.
    NSNumber *days = self.cardData;
    [self.descriptionLabel setText:[NSString stringWithFormat:@"It's been %@ days since you don't post in your timeline! What about posting something to your friends?", days]];
    [self.profileImageView sd_setImageWithURL:[User currentUser].profileImageUrl.URL];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendPostToFacebook:(id)sender {
    [SVProgressHUD show];
    [User publishMessage:self.textField.text].finally ( ^id (BFTask *task) {
        [SVProgressHUD dismiss];
        [self dismissAnimated];
        return nil;
    });
}

- (void)dismissKeyboard {
    [self.textField resignFirstResponder];
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
