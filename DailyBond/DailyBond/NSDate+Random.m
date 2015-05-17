//
//  NSDate+Random.m
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "NSDate+Random.h"

@implementation NSDate (Random)

+ (NSDate *)randomDate {
    NSDateComponents *dataComponent = [[NSDateComponents alloc] init];
    dataComponent.month = 5;
    dataComponent.day = 17;
    dataComponent.year = 1990;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *date = [calendar dateFromComponents:dataComponent];
    
    return date;
}

@end
