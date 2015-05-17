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
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString* postLink;

+ (instancetype)createWithContent:(NSString *)content andDate:(NSDate *)date andId:(NSString *)facebookId;
+ (UserPost *)generateMockData;
+ (BFTask *)allPosts;
@end
