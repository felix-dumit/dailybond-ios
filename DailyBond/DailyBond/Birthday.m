//
//  Birthday.m
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "Birthday.h"
#import "NSDate+Random.h"
#import <MJExtension.h>
#import "DailyBond-Swift.h"
#import <BFTask-Extras/BFTask-Extras.h>


@implementation Birthday

@dynamic birthdayDate;
@dynamic friendId;
@dynamic friendName;
@dynamic pictureURL;
@dynamic coverURL;

+ (NSString *)parseClassName {
    return @"Birthday";
}

+ (void)registerSubclass {
    [super registerSubclass];
    
    [Birthday setupReplacedKeyFromPropertyName: ^NSDictionary *{
        return @{
                 @"friendName": @"name",
                 @"friendId" : @"id",
                 @"pictureURL": @"picture.data.url",
                 @"coverURL": @"cover.source"
                 };
    }];
}

+ (instancetype)createBirthdayWithDate:(NSDate *)date andUserId:(NSString *)userId {
    Birthday *bir = [Birthday object];
    bir.birthdayDate = date;
    bir.friendId = userId;
    return bir;
}

+ (NSMutableArray *)generateMockBirthDays {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        NSDate *date = [NSDate randomDate];
        NSString *userId = @"10155604989635451";
        
        Birthday *b = [Birthday createBirthdayWithDate:date andUserId:userId];
        
        b.pictureURL = @"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xta1/v/t1.0-1/c0.5.50.50/p50x50/1538662_741260675894079_3844504762950089589_n.jpg?oh=abb2152cda66e5200c25eafdaa6a5353&oe=55C56DD8&__gda__=1443659339_8bdf18c0c3a8dc1bccaa5d4b726a8f14";
        
        b.coverURL = @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xap1/v/t1.0-9/s720x720/10435932_765771200109693_3907789937804929980_n.jpg?oh=147ad86827eae3ffa72f3ed661f15e4b&oe=560594A5&__gda__=1438639099_733a3dc4040b4d78db7f31bf836bbb84";
        
        [array addObject:b];
    }
    
    return array;
}

+ (BFTask *)allBirthdays {
    return [[FBRequests sharedInstance] getFriends].then ( ^id (NSArray *result) {
        NSArray *array = [Birthday objectArrayWithKeyValuesArray:result];
        return array;
    }).catch ( ^id (NSError *error) {
        return [self generateMockBirthDays];
    });
}

- (NSArray *)createBirthDayArrayFromJSONArray:(NSArray *)array {
    NSArray *arr = [Birthday objectArrayWithKeyValuesArray:array];
    return arr;
}

@end
