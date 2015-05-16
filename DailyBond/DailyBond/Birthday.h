//
//  Birthday.h
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <Parse/Parse.h>

@interface Birthday : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *friendId;
@property (strong, nonatomic) NSDate *birthdayDate;

+ (instancetype)createBirthdayWithDate:(NSDate *)date andUserId:(NSString *)userId;

+ (NSArray *)generateMockBirthDays;

@end
