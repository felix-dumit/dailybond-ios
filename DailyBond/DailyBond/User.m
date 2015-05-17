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



@end

@implementation User

@dynamic name;
@dynamic facebookID;
@dynamic birthday;
@dynamic profileImageUrl;


+ (BFTask *)loginWithFacebookInBackground {
    return [User logOutInBackground].thenOnMain ( ^id (id result) {
        return [PFFacebookUtils logInInBackgroundWithReadPermissions:@[@"public_profile", @"email", @"user_friends", @"user_birthday", @"user_events", @"read_stream", @"read_mailbox"]];
    }).thenOnMain ( ^id (User *user) {
        return [user loadFacebookInfo];
    }).thenOnMain ( ^id (id result) {
        return nil;
    });
}

+ (BFTask *)publishMessage:(NSString *)message {
    //    ParseFacebookUtils.getSession().requestNewPublishPermissions().
    
    BFTask *authTask = [BFTask taskWithResult:nil];
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
        authTask = [PFFacebookUtils logInInBackgroundWithPublishPermissions:@[@"publish_actions"]];
    }
    
    return authTask.then ( ^id (id result) {
        return [[FBRequests sharedInstance] postToTimeline:message];
    }).then ( ^id (id result) {
        NSLog(@"publicou: %@", result);
        return nil;
    }).catch ( ^id (NSError *error) {
        NSLog(@"public error: %@", error);
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
         
         
         NSLog(@"Logou com usuario: %@", user.name);
         
         NSString *imageUrl = [result objectForKey:@"picture"][@"data"][@"url"];
         
         self.profileImageUrl = imageUrl;
         
         NSURL *imageURL = [NSURL URLWithString:imageUrl];
         
         [[SDWebImageManager sharedManager] downloadImageWithURL:imageURL options:0 progress:nil completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
	            NSLog(@"finished!");
	            [[SDImageCache sharedImageCache] storeImage:image forKey:@"profileImage"];
         }];
         
         [taskCompletion trySetResult:@YES];
         
         [user saveInBackground];
     }];
    return taskCompletion.task;
}

- (UIImage *)profileImage {
    return [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"profileImage"];
}

@end
