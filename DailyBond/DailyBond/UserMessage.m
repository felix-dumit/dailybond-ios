//
//  UserMessage.m
//  DailyBond
//
//  Created by Nick-Retina on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "UserMessage.h"
#import <Parse/Parse.h>

@implementation UserMessage
@dynamic friendId;
@dynamic friendName;
@dynamic receivedDate;
@dynamic message;
@dynamic read;
@dynamic profileImageUrl;

+ (NSString *)parseClassName {
    return @"UserMessage";
}
@end
