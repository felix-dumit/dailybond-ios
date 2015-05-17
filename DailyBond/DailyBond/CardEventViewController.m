//
//  CardEventViewController.m
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "CardEventViewController.h"
#import "NSDate+Formatter.h"
#import "Event.h"

@interface CardEventViewController () {
    Event *event;
}
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation CardEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    event = self.cardData;
    [self.cardView.titleLabel setBackgroundColor:[UIColor eventColor]];
    
    self.eventNameLabel.text = event.name;
    [self setEventDate:event.date];
    // Do any additional setup after loading the view from its nib.
    
    [self.eventImageView sd_setImageWithURL:event.coverUrl.URL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI helper methods
-(void) setEventName:(NSString*)aName;
{
    [self.eventNameLabel setText:aName];
}

-(void) setEventDate:(NSDate*)aDate;
{
    // TODO: numbered
    self.dateLabel.text = [NSString stringWithFormat:@"Starting in %ld days",
                           (long)[NSDate daysBetweenDate:[NSDate date] andDate:event.date]];
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
