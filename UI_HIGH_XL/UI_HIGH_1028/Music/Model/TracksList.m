//
//  TracksList.m
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "TracksList.h"

@implementation TracksList

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"coverSmall"]) {
        self.coverLarge = value;
        self.coverSmall = value;
        self.coverMiddle = value;
    }else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"playPath64"]) {
        self.playUrl64 = value;
        self.playPathAacv164 = value;
    }
    if ([key isEqualToString:@"playsCounts"]) {
        self.playtimes = [value integerValue];
    }
}

@end
