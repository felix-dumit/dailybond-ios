//
//  LastPostDate.m
//  DailyBond
//
//  Created by Fábio Perez on 17/05/2015.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LastPostDate.h"
#import "NSDate+Random.h"
#import <DateTools.h>


@interface LastPostDate ()
@property (strong, nonatomic) NSString *dateString;
@end

@implementation LastPostDate
@dynamic message;
@dynamic date;
@dynamic dateString;

+ (NSString *)parseClassName {
    return @"LastPostDate";
}

+ (void)registerSubclass {
    [super registerSubclass];
    
    [LastPostDate setupReplacedKeyFromPropertyName: ^NSDictionary *{
        return @{
                 @"message": @"message",
                 @"dateString" : @"created_time"
                 };
    }];
}

+ (instancetype)createLastPostDateWithDate:(NSDate *)date andMessage:(NSString *)message {
    LastPostDate *lpd = [LastPostDate object];
    lpd.message = message;
    lpd.date = date;
    return lpd;
}

+ (NSDate *)dateForDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    return [dateFormatter dateFromString:dateString];
}

- (void)setDateString:(NSString *)dateString {
    [self setObject:dateString forKey:@"dateString"];
    self.date = [LastPostDate dateForDateString:dateString];
}

+ (LastPostDate *)generateMockLastPostDate {
    NSDate *date = [NSDate dateWithYear:2015 month:5 day:17];
    NSString *message = @"Oi Facebook!";
    
    LastPostDate *lpd = [LastPostDate createLastPostDateWithDate:date andMessage:message];
    
    return lpd;
}

+ (BFTask *)lastPostDate {
    static BFTask *currentTask = nil;
    
    if (!currentTask) {
        currentTask = [[FBRequests sharedInstance] getLastPostDate].then ( ^id (NSArray *result) {
            NSArray *array = [LastPostDate objectArrayWithKeyValuesArray:result];
            [self saveToLDS:array];
            return array;
        }).catch ( ^id (NSError *error) {
            return [self generateMockLastPostDate];
        });
    }
    
    return currentTask;
}

+ (BFTask *)loadFromLDS {
    PFQuery *query = [[LastPostDate query] fromLocalDatastore];
    return [query findObjectsInBackground];
}

+ (BFTask *)saveToLDS:(NSArray *)array {
    return [LastPostDate unpinAllObjectsInBackground].then ( ^id (id result) {
        return [LastPostDate pinAllInBackground:array];
    });
}

- (NSArray *)createLastPostDateArrayFromJSONArray:(NSArray *)array {
    NSArray *arr = [LastPostDate objectArrayWithKeyValuesArray:array];
    return arr;
}

@end
