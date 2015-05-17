//
//  UserMessage.m
//  DailyBond
//
//  Created by Nick-Retina on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "UserMessage.h"
#import <Parse/Parse.h>

@interface UserMessage ()

@property (strong, nonatomic) NSString *dateString;
@end

@implementation UserMessage
@dynamic friendId;
@dynamic friendName;
@dynamic receivedDate;
@dynamic message;
@dynamic unread;
@dynamic dateString;
@dynamic profileImageUrl;


+ (NSString *)parseClassName {
    return @"UserMessage";
}

- (void)setDateString:(NSString *)dateString {
    [self setObject:dateString forKey:dateString];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    self.receivedDate = date;
}

+ (void)registerSubclass {
    [super registerSubclass];
    
    [UserMessage setupReplacedKeyFromPropertyName: ^NSDictionary *{
        return @{
                 @"friendId": @"id.to.data.id",
                 @"friendName" : @"id.to.data.name",
                 @"receivedDate": @"updated_time",
                 @"message": @"comments.data.message",
                 @"read": @"unread"
                 };
    }];
}

+ (instancetype)createWithName:(NSString *)friendName andId:(NSString *)friendId andDate:(NSDate *)receivedDate andMessage:(NSString *)message andUnread:(BOOL)unread {
    UserMessage *user_msg = [UserMessage object];
    user_msg.friendId = friendId;
    user_msg.friendName = friendName;
    user_msg.receivedDate = receivedDate;
    user_msg.message = message;
    user_msg.unread = unread;
    return user_msg;
}

+ (UserMessage *)generateMockData {
    return [self createWithName:@"Jorge" andId:@"1" andDate:[NSDate dateWithTimeInterval:-100000000 sinceDate:[NSDate date]] andMessage:@"Hello!" andUnread:YES];
}

+ (BFTask *)allMessages {
    static BFTask *currentTask = nil;
    
    if (!currentTask) {
        currentTask = [[FBRequests sharedInstance] getInbox].then ( ^id (NSArray *result) {
            return [UserMessage objectArrayWithKeyValuesArray:result];
        }).catch ( ^id (NSError *error) {
            return [self generateMockData];
        });
    }
    
    return currentTask;
}

- (NSArray *)createEventsArrayFromJSONArray:(NSArray *)array {
    NSArray *arr = [UserMessage objectArrayWithKeyValuesArray:array];
    return arr;
}

- (NSURL *)profileImageURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"graph.facebook.com/%@/picture?type=square", self.friendId]];
}

@end
