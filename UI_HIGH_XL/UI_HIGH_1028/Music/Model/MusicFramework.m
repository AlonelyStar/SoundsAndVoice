//
//  MusicFramework.m
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MusicFramework.h"
#import "MusicImageList.h"

@implementation MusicFramework

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"focusImages"]) {
        
        
    }else {
        [self setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
