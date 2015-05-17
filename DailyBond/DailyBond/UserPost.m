//
//  UserPost.m
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "UserPost.h"
#import <MJExtension.h>
#import "DailyBond-Swift.h"

@interface UserPost ()

@property (strong, nonatomic) NSString *dateString;

@end


@implementation UserPost

@dynamic facebookId;
@dynamic content;
@dynamic date;
@dynamic dateString;
@dynamic imageUrl;
@dynamic title;

+ (NSString *)parseClassName {
    return @"UserPost";
}

+ (void)registerSubclass {
    [super registerSubclass];
    
    [UserPost setupReplacedKeyFromPropertyName: ^NSDictionary *{
        return @{
                 @"content": @"caption",
                 @"title" : @"",
                 @"imageUrl" : @"picture",
                 @"facebookId": @"id",
                 @"dateString": @"created_time"
                 };
    }];
}

- (void)setDateString:(NSString *)dateString {
    [self setObject:dateString forKey:dateString];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    self.date = date;
}

+ (instancetype)createWithContent:(NSString *)content andDate:(NSDate *)date andId:(NSString *)facebookId {
    UserPost *post = [[UserPost alloc] init];
    post.content = content;
    post.date = date;
    post.facebookId = facebookId;
    return post;
}

+ (UserPost *)generateMockData {
    return [self createWithContent:@"Facebook post in a long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long  time ago"
                           andDate:[NSDate dateWithTimeInterval:-1000000 sinceDate:[NSDate date]] andId:@"828648753872660"];
}

+ (BFTask *)allPosts {
    static BFTask *currentTask = nil;
    
    if (!currentTask) {
        currentTask = [[FBRequests sharedInstance] getNewsFeed].then ( ^id (NSArray *result) {
            NSArray *array = [UserPost objectArrayWithKeyValuesArray:result];
            return array;
        }).catch ( ^id (NSError *error) {
            return [self generateMockData];
        });
    }
    
    return currentTask;
}

@end
