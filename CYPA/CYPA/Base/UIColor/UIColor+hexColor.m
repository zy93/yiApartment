//
//  UIColor+hexColor.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "UIColor+hexColor.h"
@implementation UIColor (hexColor)

 +(UIColor *)colorWithHexString:(NSString *)hexColor {
    
//     float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
//     float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
//     float blue = ((float)(hexColor & 0xFF))/255.0;
//     return [UIColor colorWithRed:red green:green blue:blue alpha:1];
     
     
     unsigned int red,green,blue;
     NSRange range;
     range.length = 2;
     
     range.location = 0;
     [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
     
     range.location = 2;
     [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
     
     range.location = 4;
     [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
     
     return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
     
     
}

@end
