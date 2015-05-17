//
//  UserMessage.m
//  DailyBond
//
//  Created by Nick-Retina on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "UserMessage.h"
#import "User.h"
#import <Parse/Parse.h>

@interface Message : NSObject

@property NSString *userId;
@property NSString *userName;
@property NSString *message;

@end

@implementation Message

@end


@interface UserMessage ()

@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSArray *messages;
@end

@implementation UserMessage
@dynamic friendId;
@dynamic friendName;
@dynamic receivedDate;
@dynamic message;
@dynamic messages;
@dynamic unread;
@dynamic unseen;
@dynamic dateString;
@dynamic profileImageUrl;
@dynamic chatId;


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
                 @"receivedDate": @"updated_time",
                 @"messages": @"comments.data",
                 @"unread": @"unread",
                 @"unseen": @"unseen",
                 @"chatId": @"id"
                 };
    }];
    
    //    [UserMessage setupObjectClassInArray: ^NSDictionary *{
    //        return @{
    //                 @"comments.data" : @"Message",
    //                 };
    //    }];
    
    //    [Message setupReplacedKeyFromPropertyName: ^NSDictionary *{
    //        return @{
    //                 @"userId": @"from.id",
    //                 @"userName": @"from.name",
    //                 @"message": @"message"
    //                 };
    //    }];
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

+ (NSArray *)generateMockData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        UserMessage *m = [self createWithName:@"Jorge" andId:@"1" andDate:[NSDate dateWithTimeInterval:-100000000 sinceDate:[NSDate date]] andMessage:@"Hello!" andUnread:YES];
        m.unseen = YES;
        [array addObject:m];
    }
    
    return array;
}

+ (BFTask *)allMessages {
    static BFTask *currentTask = nil;
    
    if (!currentTask) {
        currentTask = [[FBRequests sharedInstance] getInbox].then ( ^id (NSArray *result) {
            return [self processConversationArray:result];
        }).catch ( ^id (NSError *error) {
            return [self generateMockData];
        });
    }
    
    return currentTask;
}

+ (NSArray *)processConversationArray:(NSArray *)arr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *conversation in arr) {
        NSDictionary *lastMessage = [conversation[@"comments"][@"data"] lastObject];
        NSString *userId = lastMessage[@"from"][@"id"];
        NSString *userName = lastMessage[@"from"][@"name"];
        NSString *message = lastMessage[@"message"];
        NSDate *date =  [dateFormatter dateFromString:conversation[@"updated_time"]];
        BOOL unread = [conversation[@"unread"] boolValue];
        BOOL unseen = [conversation[@"unseen"] boolValue];
        
        if (![userId isEqualToString:[User currentUser].facebookID]
            && message) {
            UserMessage *umsg = [UserMessage createWithName:userName andId:userId andDate:date andMessage:message andUnread:unread];
            umsg.unseen = unseen;
            
            [array addObject:umsg];
        }
    }
    
    return array;
}

- (NSURL *)profileImageURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"graph.facebook.com/%@/picture?type=square", self.friendId]];
}

@end
