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


-(NSURL*)profileImageURL;

+ (BFTask *)loginWithFacebookInBackground;

- (UIImage *)profileImage;

@end
