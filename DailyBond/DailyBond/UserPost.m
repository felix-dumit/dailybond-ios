//
//  UserPost.m
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "UserPost.h"

@implementation UserPost

@dynamic facebookId;
@dynamic content;
@dynamic date;
@dynamic imageUrl;

+ (NSString *)parseClassName {
    return @"UserPost";
}

+ (instancetype)createWithContent:(NSString *)content andDate:(NSDate *)date andId:(NSString *)facebookId {
    UserPost *post = [[UserPost alloc] init];
    post.content = content;
    post.date = date;
    post.facebookId = facebookId;
    return post;
}

+ (UserPost*) generateMockData
{
    return [self createWithContent:@"Facebook post in a long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long  time ago"
                    andDate:[NSDate dateWithTimeInterval:-100000000 sinceDate:[NSDate date]] andId: @"828648753872660"];
}
@end
