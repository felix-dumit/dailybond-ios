//
//  UserPost.h
//  DailyBond
//
//  Created by Nick-Retina on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse.h>

@interface UserPost : PFObject <PFSubclassing>
@property (strong, nonatomic) NSString *facebookId;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *imageUrl;

+ (instancetype)createWithContent:(NSString *)content andDate:(NSDate *)date andId:(NSString *)facebookId;
+ (UserPost*) generateMockData;
@end