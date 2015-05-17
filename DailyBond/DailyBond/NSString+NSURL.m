//
//  NSString+NSURL.m
//  DailyBond
//
//  Created by Felix Dumit on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "NSString+NSURL.h"

@implementation NSString (NSURL)

- (NSURL *)URL {
    return [NSURL URLWithString:self];
}

@end
