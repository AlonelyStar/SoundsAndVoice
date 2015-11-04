//
//  CategoryMusic.m
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "CategoryMusic.h"
#import "ProgramSelection.h"

@implementation CategoryMusic

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"list"]) {
        self.list = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ProgramSelection *program = [[ProgramSelection alloc]init];
            [program setValuesForKeysWithDictionary:dic];
            [self.list addObject:program];
        }
    }else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
