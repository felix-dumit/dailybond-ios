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
@property (assign, nonatomic) BOOL *read;

-(NSURL*)profileImageURL;

@end
