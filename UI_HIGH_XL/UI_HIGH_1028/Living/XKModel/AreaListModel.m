//
//  AreaListModel.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "AreaListModel.h"

@implementation AreaListModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}


@end
