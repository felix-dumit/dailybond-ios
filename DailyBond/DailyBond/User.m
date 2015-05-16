//
//  User.m
//  
//
//  Created by Felix Dumit on 5/16/15.
//
//

#import "User.h"

@implementation User


- (BFTask *)loadFacebookInfo {
    BFTaskCompletionSource *taskCompletion = [BFTaskCompletionSource taskCompletionSource];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{ @"fields": @"name,email,gender,picture.width(961)" }]
     startWithCompletionHandler: ^(FBSDKGraphRequestConnection *connection, id result, NSError *fbError) {
         DDLogInfo(@"Facebook Info: RESULT: %@ %@", result, fbError);
         if (fbError) {
             [taskCompletion trySetError:fbError];
             return;
         }
         [taskCompletion trySetResult:@YES];
         
         // Store the current user's Facebook ID on the user
         User *user = [User currentUser];
         
         user.fbId = [result objectForKey:@"id"];
         
         user.name  = [result objectForKey:@"name"];
         
         user.email = [result objectForKey:@"email"];
         
         
         [user setObject:[result objectForKey:@"gender"] forKey:@"gender"];
         
         
         NSURL *imageURL = [NSURL URLWithString:[[[result objectForKey:@"picture"]
                                                  objectForKey:@"data"]
                                                 objectForKey:@"url"]];
         
         NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
         
         [self setNewProfileImage:[UIImage imageWithData:imageData]];
     }];
    return taskCompletion.task;
}



@end
