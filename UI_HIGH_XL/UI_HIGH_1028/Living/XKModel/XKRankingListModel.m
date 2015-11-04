//
//  XKRankingListModel.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKRankingListModel.h"
#import "RadioPlayerURLModel.h"

@implementation XKRankingListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"radioPlayUrl"]) {
        self.RPURL = [[RadioPlayerURLModel alloc]init];
        [self.RPURL setValuesForKeysWithDictionary:value];
    }
}

@end
