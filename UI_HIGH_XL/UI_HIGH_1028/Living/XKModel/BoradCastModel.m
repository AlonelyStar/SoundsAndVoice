//
//  BoradCastModel.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/11/2.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "BoradCastModel.h"
#import "AnnouncerModel.h"

@implementation BoradCastModel


-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"announcerList"]) {
        NSArray *array = value;
        self.announcerList = [NSMutableArray array];
        if (array.count != 0) {
            for (NSDictionary *dic in array) {
                AnnouncerModel *model = [[AnnouncerModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.announcerList addObject:model];
            }
        }
    }else{
        [super setValue:value forKey:key];
    }
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
}


@end
