//
//  User.m
//
//
//  Created by Felix Dumit on 5/16/15.
//
//

#import "User.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKGraphRequest.h>
#import <SDWebImageManager.h>

@interface User ()

@property (strong, nonatomic) NSString *profileImageUrl;


@end

@implementation User

@dynamic name;
@dynamic facebookID;
@dynamic birthday;
@dynamic profileImageUrl;


+ (BFTask *)loginWithFacebookInBackground {
    return [User logOutInBackground].thenOnMain ( ^id (id result) {
        return [PFFacebookUtils logInInBackgroundWithReadPermissions:@[@"public_profile", @"email", @"user_friends", @"user_birthday", @"user_events"]];
    }).thenOnMain ( ^id (User *user) {
        return [user loadFacebookInfo];
    }).thenOnMain ( ^id (id result) {
        return nil;
    });
}

- (BFTask *)loadFacebookInfo {
    BFTaskCompletionSource *taskCompletion = [BFTaskCompletionSource taskCompletionSource];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{ @"fields": @"name,email,gender,picture.width(500)" }]
     startWithCompletionHandler: ^(FBSDKGraphRequestConnection *connection, id result, NSError *fbError) {
         if (fbError) {
             [taskCompletion trySetError:fbError];
             return;
         }
         // Store the current user's Facebook ID on the user
         User *user = [User currentUser];
         
         user.facebookID = [result objectForKey:@"id"];
         
         user.name  = [result objectForKey:@"name"];
         
         user.email = [result objectForKey:@"email"];
         
         [user setObject:[result objectForKey:@"gender"] forKey:@"gender"];
         
         [taskCompletion trySetResult:@YES];
         
         NSLog(@"Logou com usuario: %@", user.name);
         
         NSString *imageUrl = [result objectForKey:@"picture"][@"data"][@"url"];
         
         self.profileImageUrl = imageUrl;
         
         NSURL *imageURL = [NSURL URLWithString:imageUrl];
         
         [[SDWebImageManager sharedManager] downloadImageWithURL:imageURL options:0 progress:nil completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
	            NSLog(@"finished!");
	            [[SDImageCache sharedImageCache] storeImage:image forKey:@"profileImage"];
         }];
         
         [user saveInBackground];
     }];
    return taskCompletion.task;
}

- (UIImage *)profileImage {
    return [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"profileImage"];
}

-(NSURL*)profileImageURL {
    return [NSURL URLWithString:self.profileImageUrl];
}
@end
