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
@dynamic userId;
@dynamic userName;
@dynamic content;
@dynamic date;
@dynamic dateString;
@dynamic imageUrl;
@dynamic title;
@dynamic postLink;

+ (NSString *)parseClassName {
    return @"UserPost";
}

+ (void)registerSubclass {
    [super registerSubclass];
    
    //    [UserPost setupReplacedKeyFromPropertyName: ^NSDictionary *{
    //        return @{
    //                 @"content": @"message",
    //                 @"imageUrl" : @"picture",
    //                 @"facebookId": @"id",
    //                 @"dateString": @"created_time",
    //                 };
    //    }];
}

- (void)setDateString:(NSString *)dateString {
    [self setObject:dateString forKey:dateString];
    
    self.date = [UserPost dateForDateString:dateString];
}

+ (NSDate *)dateForDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    return [dateFormatter dateFromString:dateString];
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
            NSArray *array = [UserPost processPostsArray:result];
            [self saveToLDS:array];
            return array;
        }).catch ( ^id (NSError *error) {
            return [self loadFromLDS];
        }).catch ( ^id (NSError *error) {
            return @[[self generateMockData]];
        });
    }
    
    return currentTask;
}

+ (NSArray *)processPostsArray:(NSArray *)arr {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dict in arr) {
        NSString *facebookId = dict[@"id"];
        NSString *userId = dict[@"from"][@"id"];
        NSString *userName = dict[@"from"][@"name"];
        NSString *title = dict[@"story"] ? : dict[@"caption"];
        NSString *content = dict[@"message"] ? : dict[@"description"];
        NSString *dateString = dict[@"updated_time"];
        NSDate *date = [self dateForDateString:dateString];
        NSString *imageUrl = dict[@"picture"];
        
        UserPost *up = [UserPost createWithContent:content andDate:date andId:facebookId];
        up.imageUrl = imageUrl ? : [NSString stringWithFormat:@"graph.facebook.com/%@/picture?type=square", userId];
        up.title = title;
        up.userId = userId;
        up.userName = userName;
        up.postLink = dict[@"link"];
        
        [array addObject:up];
    }
    
    return array;
}

+ (BFTask *)loadFromLDS {
    PFQuery *query = [[UserPost query] fromLocalDatastore];
    return [query findObjectsInBackground];
}

+ (BFTask *)saveToLDS:(NSArray *)array {
    return [UserPost unpinAllObjectsInBackground].then ( ^id (id result) {
        return [UserPost pinAllInBackground:array];
    });
}

@end
