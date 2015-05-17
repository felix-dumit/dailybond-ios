//
//  Event.h
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <Parse/Parse.h>

@interface Event : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *eventId;
@property (strong, nonatomic) NSString *rsvpStatus;

+ (instancetype)createWithName:(NSString *)name andDate:(NSDate *)date andId:(NSString *)eventId  andRsvp:(NSString *)rsvpStatus;
+ (NSArray *)generateMockData;
+ (BFTask *)allEvents;



@end
