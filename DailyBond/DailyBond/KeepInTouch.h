//
//  KeepInTouch.h
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <Parse/Parse.h>

@interface KeepInTouch : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *friendName;
@property (strong, nonatomic) NSString *friendId;
@property (strong, nonatomic) NSDate *lastInteractionDate;

- (NSString *)formattedLastInteractionDate;
+ (instancetype)createWithFriendId:(NSString *)fId friendName:(NSString *)name andLastInteractionDate:(NSDate *)date;

+ (NSArray *)generateMockData;

@end
