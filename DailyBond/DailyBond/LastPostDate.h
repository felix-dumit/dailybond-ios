//
//  LastPostDate.h
//  DailyBond
//
//  Created by Fábio Perez on 17/05/2015.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <Parse/Parse.h>

@interface LastPostDate : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDate *date;

+ (instancetype)createLastPostDateWithDate:(NSDate *)date andMessage:(NSString *)message;
+ (BFTask *)lastPostDate;

@end
