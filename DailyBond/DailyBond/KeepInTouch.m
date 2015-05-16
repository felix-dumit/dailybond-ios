//
//  KeepInTouch.m
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "KeepInTouch.h"
#import <DateTools.h>

@implementation KeepInTouch

@dynamic friendId;
@dynamic friendName;
@dynamic lastInteractionDate;

+ (NSString *)parseClassName {
    return @"KeepInTouch";
}

+ (instancetype)createWithFriendId:(NSString *)fId friendName:(NSString *)name andLastInteractionDate:(NSDate *)date {
    KeepInTouch *kit = [KeepInTouch object];
    kit.friendName = name;
    kit.friendId = fId;
    kit.lastInteractionDate = date;
    return kit;
}

- (NSString *)formattedLastInteractionDate {
    return self.lastInteractionDate.timeAgoSinceNow;
}

+ (NSArray *)generateMockData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        NSString *friendName = @"John Doe";
        NSString *friendId = @"10155604989635451";
        NSDate *date = [NSDate dateWithYear:2015 month:5 day:1];
        
        [array addObject:[KeepInTouch createWithFriendId:friendId friendName:friendName andLastInteractionDate:date]];
    }
    
    return array;
}

@end
