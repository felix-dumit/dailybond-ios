//
//  UserMessage.h
//  DailyBond
//
//  Created by Nick-Retina on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <Parse/Parse.h>

@interface UserMessage : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *friendId;
@property (strong, nonatomic) NSString *friendName;
@property (strong, nonatomic) NSDate *receivedDate;
@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) BOOL unread;
@property (assign, nonatomic) BOOL unseen;
@property (strong, nonatomic) NSString *chatId;
@property (strong, nonatomic) NSString *profileImageUrl;

- (NSURL *)profileImageURL;
+ (BFTask *)allMessages;

@end
