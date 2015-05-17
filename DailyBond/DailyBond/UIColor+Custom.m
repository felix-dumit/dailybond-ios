//
//  UIColor+Custom.m
//  DailyBond
//
//  Created by Nick-Retina on 5/17/15.
//  Copyright (c) 2015 DailyBond. All rights reserved.
//

#import "UIColor+Custom.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation UIColor (Custom)

+ (UIColor*) semitransparentColor
{
    return [UIColor colorWithWhite:1.0 alpha:0.4];
}

+ (UIColor*) birthdayColor
{
    return UIColorFromRGB(0x7AACD0);
}

+ (UIColor*) eventColor
{
    return UIColorFromRGB(0x7662AE);
}

+ (UIColor*) topPostColor
{
    return UIColorFromRGB(0xB46CAE);
}

+ (UIColor*) chatColor
{
    return UIColorFromRGB(0xF57C87);
}

+ (UIColor*) writeColor
{
    return UIColorFromRGB(0xFBB17B);
}

@end
