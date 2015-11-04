//
//  Album.m
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "Album.h"

@implementation Album

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"lastUptrackAt"]) {
        if (value != nil) {
            self.lastUptrackAt = [value integerValue];
        }
    }else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}


@end
