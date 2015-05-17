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
@property (strong, nonatomic) NSString *friendName;
@property (strong, nonatomic) NSString *pictureURL;
@property (strong, nonatomic) NSString *coverURL;

+ (instancetype)createBirthdayWithDate:(NSDate *)date andUserId:(NSString *)userId;

+ (BFTask *)allBirthdays;
+ (NSMutableArray *)generateMockBirthDays;

@end
