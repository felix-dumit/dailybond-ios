//
//  Event.m
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "Event.h"
#import <DateTools.h>

@interface Event ()

@property (strong, nonatomic) NSString *dateString;
@end

@implementation Event

@dynamic name;
@dynamic eventId;
@dynamic date;
@dynamic rsvpStatus;
@dynamic eventImageUrl;

+ (NSString *)parseClassName {
    return @"Event";
}

- (NSDate *)strToDate:(NSString *)dateStr {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}

+ (void)registerSubclass {
    [super registerSubclass];
    
    [Event setupReplacedKeyFromPropertyName: ^NSDictionary *{
        return @{
                 @"name": @"name",
                 @"eventId" : @"id",
                 @"rsvpStatus": @"rsvp_status",
                 @"dateString": @"start_time"
                 };
    }];
}

- (void)setDateString:(NSString *)dateString {
    [self setObject:dateString forKey:@"dateString"];
    self.date = [self strToDate: dateString];
}

+ (instancetype)createWithName:(NSString *)name andDate:(NSDate *)date andId:(NSString *)eventId andRsvp:(NSString *)rsvpStatus andEventImageUrl:(NSString*)eventImageUrl{
    Event *event = [Event object];
    event.name = name;
    event.date = date;
    event.eventId = eventId;
    event.rsvpStatus = rsvpStatus;
    event.eventImageUrl = eventImageUrl;
    return event;
}

+ (NSArray *)generateMockData {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        NSString *eventName = @"Bonde do Hackaton 2015";
        NSDate *date = [NSDate dateWithYear:2015 month:5 day:17];
        NSString *eventId = @"828648753872660";
        NSString *rsvpStatus = @"attending";
        NSString *eventImage = @"https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-xfa1/t31.0-8/175774_10150257616905988_1545266_o.jpg";
        [array addObject:[Event createWithName:eventName andDate:date andId:eventId andRsvp:rsvpStatus andEventImageUrl:eventImage]];
    }
    
    return array;
}

+ (BFTask *)allEvents {
    static BFTask *currentTask = nil;
    
    if (!currentTask) {
        currentTask = [[FBRequests sharedInstance] getEvents].then ( ^id (NSArray *result) {
            return [Event objectArrayWithKeyValuesArray:result];
        }).catch ( ^id (NSError *error) {
            return [self generateMockData];
        });
    }
    
    return currentTask;
}

- (NSArray *)createEventsArrayFromJSONArray:(NSArray *)array {
    NSArray *arr = [Event objectArrayWithKeyValuesArray:array];
    return arr;
}

@end
