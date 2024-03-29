//
//  PagesViewController.h
//  DailyBond
//
//  Created by André Vitor Terron on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PagesViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageBackground;
@property (weak, nonatomic) IBOutlet UIView *containerLogin;

- (void) startCards;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end
