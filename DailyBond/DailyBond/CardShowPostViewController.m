//
//  CardShowPostViewController.m
//  DailyBond
//
//  Created by Nick-Retina on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "CardShowPostViewController.h"
#import "UserPost.h"
@interface CardShowPostViewController ()

@end

@implementation CardShowPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cardView.titleLabel setBackgroundColor:[UIColor topPostColor]];
    
    // Do any additional setup after loading the view from its nib.
    UserPost *post = self.cardData;
    
    [self.titleLabel setText:post.userName];
    [self.contentLabel setText:post.content];
    [self.postImageView sd_setImageWithURL:post.imageUrl.URL];
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
    // TODO: remind later
    [self dismissAnimated];
}
- (IBAction)onNextButtonPressed:(id)sender {
    [self dismissAnimated];
}

-(CardView *)getCardView;
{
    return self.cardView;
}


@end
