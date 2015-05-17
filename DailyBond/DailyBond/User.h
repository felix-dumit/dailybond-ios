//
//  User.h
//
//
//  Created by Felix Dumit on 5/16/15.
//
//

#import <UIKit/UIKit.h>
#import <Parse.h>
#import <Bolts.h>
#import <BFTask-Extras.h>



@interface User : PFUser

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *facebookID;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) NSString *profileImageUrl;


+ (BFTask *)loginWithFacebookInBackground;

- (UIImage *)profileImage;
+ (BFTask *)publishMessage:(NSString *)message;

@end
