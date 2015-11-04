//
//  NSString+XL.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "NSString+XL.h"

@implementation NSString (XL)

+ (NSString *)getGreaterTenThousandWithNumber:(NSInteger)number {
    if (number > 10000) {
        return [NSString stringWithFormat:@"%.1f万",number / 10000.0];
    } else {
        return [NSString stringWithFormat:@"%ld",number];
    }
}

+ (NSString *)getDateWithTimeNumber:(NSInteger)number {
    NSInteger hours = number / 60;
    NSInteger min = number % 60;
    return [NSString stringWithFormat:@"%ld:%ld",hours,min];
}

@end
