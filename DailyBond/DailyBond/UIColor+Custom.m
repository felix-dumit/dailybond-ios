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

+ (UIColor*) birthdayColor
{
    return UIColorFromRGB(0xFFCC4C);
}

+ (UIColor*) birthdayDarkColor
{
    return UIColorFromRGB(0xDB8C10);
}

+ (UIColor*) eventColor
{
    return UIColorFromRGB(0xFBB17B);
}

+ (UIColor*) eventDarkColor
{
    return UIColorFromRGB(0xE14A17);
}

+ (UIColor*) topPostColor
{
    return UIColorFromRGB(0xB46CAE);
}

+ (UIColor*) topPostDarkColor
{
    return UIColorFromRGB(0x7C2B8D);
}

+ (UIColor*) chatColor
{
    return UIColorFromRGB(0x7AACD0);
}

+ (UIColor*) chatDarkColor
{
    return UIColorFromRGB(0x748EC4);
}

+ (UIColor*) writeColor
{
    return UIColorFromRGB(0x90CD98);
}

+ (UIColor*) writeDarkColor
{
    return UIColorFromRGB(0x358944);
}

@end
