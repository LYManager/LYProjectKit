// UIColor+Extention.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/18. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "UIColor+Extention.h"

@implementation UIColor (Extention)
+ (UIColor *)ly_colorWithHexString:(NSString *)hexString{
        NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        if ([cString length] < 6) {
            return [UIColor clearColor];
        }
        // 判断前缀并剪切掉
        if ([cString hasPrefix:@"0X"])
            cString = [cString substringFromIndex:2];
        if ([cString hasPrefix:@"#"])
            cString = [cString substringFromIndex:1];
        if ([cString length] != 6)
            return [UIColor clearColor];
        NSRange range;
        range.location = 0;
        range.length = 2;

        //R、G、B
        NSString *rString = [cString substringWithRange:range];

        range.location = 2;
        NSString *gString = [cString substringWithRange:range];

        range.location = 4;
        NSString *bString = [cString substringWithRange:range];

        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];

        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)ly_vc_bgColor{
    return [self ly_colorWithHexString:@"#0E1018"];
}

+ (UIColor *)ly_view_bgColor{
    return [self ly_colorWithHexString:@"#2F3571"];
}
@end
