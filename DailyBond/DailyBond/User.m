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



@implementation User

@dynamic name;
@dynamic profileImage;
@dynamic facebookID;
@dynamic birthday;


- (BFTask *)loadFacebookInfo {
    BFTaskCompletionSource *taskCompletion = [BFTaskCompletionSource taskCompletionSource];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{ @"fields": @"name,email,gender,picture.width(961)" }]
     startWithCompletionHandler: ^(FBSDKGraphRequestConnection *connection, id result, NSError *fbError) {
         if (fbError) {
             [taskCompletion trySetError:fbError];
             return;
         }
         [taskCompletion trySetResult:@YES];
         
         // Store the current user's Facebook ID on the user
         User *user = [User currentUser];
         
         user.facebookID = [result objectForKey:@"id"];
         
         user.name  = [result objectForKey:@"name"];
         
         user.email = [result objectForKey:@"email"];
         
         
         [user setObject:[result objectForKey:@"gender"] forKey:@"gender"];
         
         
         //         NSURL *imageURL = [NSURL URLWithString:[[[result objectForKey:@"picture"]
         //                                                  objectForKey:@"data"]
         //                                                 objectForKey:@"url"]];
         //
         //         NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
     }];
    return taskCompletion.task;
}

@end
