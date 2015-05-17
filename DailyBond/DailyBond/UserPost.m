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


@implementation UserPost

@dynamic facebookId;
@dynamic content;
@dynamic date;
@dynamic imageUrl;

+ (NSString *)parseClassName {
    return @"UserPost";
}

+ (void)registerSubclass {
    [super registerSubclass];
    
    [UserPost setupReplacedKeyFromPropertyName: ^NSDictionary *{
        return @{
                 @"friendName": @"name",
                 @"friendId" : @"id",
                 @"pictureURL": @"picture.data.url",
                 @"coverURL": @"cover.source"
                 };
    }];
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
                           andDate:[NSDate dateWithTimeInterval:-100000000 sinceDate:[NSDate date]] andId:@"828648753872660"];
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
