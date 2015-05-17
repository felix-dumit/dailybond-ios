//
//  Event.m
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "Event.h"
#import <DateTools.h>

@implementation Event

@dynamic name;
@dynamic eventId;
@dynamic date;

+ (NSString *)parseClassName {
    return @"Event";
}

+ (instancetype)createWithName:(NSString *)name andDate:(NSDate *)date andId:(NSString *)eventId {
    Event *event = [Event object];
    event.name = name;
    event.date = date;
    event.eventId = eventId;
    return event;
}

+ (NSArray *)generateMockData {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        NSString *eventName = @"Bonde do Hackaton 2015";
        NSDate *date = [NSDate dateWithYear:2015 month:5 day:17];
        NSString *eventId = @"828648753872660";
        
        [array addObject:[Event createWithName:eventName andDate:date andId:eventId]];
    }
    
    return array;
}

@end
