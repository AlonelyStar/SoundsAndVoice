//
//  ProgramSelection.m
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "ProgramSelection.h"

@implementation ProgramSelection

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}

@end
