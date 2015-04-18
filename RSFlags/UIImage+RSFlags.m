//
//  UIImage+Flags.m
//  Flags
//
//  Created by Suresh T on 17/04/15.
//  Copyright (c) 2015 Ramaraj. All rights reserved.
//

#import "UIImage+RSFlags.h"

const float flagHeight  = 11.0;
const float flagWeight   = 16.0;

@implementation UIImage (RSFlags)

static inline CGRect CGRectMultiply(CGRect rect, CGFloat factor)
{
    return CGRectMake(rect.origin.x*factor, rect.origin.y*factor, rect.size.width*factor, rect.size.height*factor);
}

+ (UIImage *)flagForCountryCode:(NSString *)countryCode {
    const char firstCharacter = *[[countryCode substringToIndex:1] UTF8String];
    int firstCharIndex = firstCharacter - 64;
    
    const char secondCharacter = *[[countryCode substringFromIndex:[countryCode length]-1] UTF8String];
    int secondCharIndex = secondCharacter - 64;

    
    UIImage *origImage = [UIImage imageWithCGImage:[UIImage imageNamed:@"WorldFlags"].CGImage
                                             scale:[UIScreen mainScreen].scale
                                       orientation:UIImageOrientationUp];
    
    CGRect fromRect = CGRectMake(firstCharIndex * flagWeight, secondCharIndex * flagHeight, flagWeight, flagHeight);
    fromRect = CGRectMultiply(fromRect, [UIScreen mainScreen].scale);
    CGImageRef drawImage = CGImageCreateWithImageInRect(origImage.CGImage, fromRect);
    UIImage *flagImage = [UIImage imageWithCGImage:drawImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(drawImage);
    return flagImage;
}

@end
