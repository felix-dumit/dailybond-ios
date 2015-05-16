//
//  Birthday.m
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "Birthday.h"
#import "NSDate+Random.h"

@implementation Birthday

@dynamic birthdayDate;
@dynamic friendId;

+ (NSString *)parseClassName {
    return @"Birthday";
}

+ (instancetype)createBirthdayWithDate:(NSDate *)date andUserId:(NSString *)userId {
    Birthday *bir = [Birthday object];
    bir.birthdayDate = date;
    bir.friendId = userId;
    return bir;
}

+ (NSArray *)generateMockBirthDays {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        NSDate *date = [NSDate randomDate];
        NSString *userId = @"10155604989635451";
        [array addObject:[Birthday createBirthdayWithDate:date andUserId:userId]];
    }
    
    return array;
}

@end
