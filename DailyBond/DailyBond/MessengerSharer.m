//
//  MessengerSharer.m
//  DailyBond
//
//  Created by Felix Dumit on 5/16/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "MessengerSharer.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerSharer.h>

@implementation MessengerSharer

+ (void)testShare {
    if ([FBSDKMessengerSharer messengerPlatformCapabilities] & FBSDKMessengerPlatformCapabilityImage) {
        UIImage *image = [UIImage imageNamed:@"HappyBirthday-6"];
        [FBSDKMessengerSharer shareImage:image withOptions:nil];
    }
    
    //    if ([FBSDKMessengerSharer messengerPlatformCapabilities] & FBSDKMessengerPlatformCapabilityOpen) {
    //        [FBSDKMessengerSharer openMessenger];
    //    }
}

@end
