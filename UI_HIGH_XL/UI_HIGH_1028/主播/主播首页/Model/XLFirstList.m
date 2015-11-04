//
//  XLFirstList.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLFirstList.h"

@implementation XLFirstList

//- (void)setValue:(id)value forKey:(NSString *)key {
//    NSMutableArray *arr = [NSMutableArray array];
//    if ([key isEqual:@"list"]) {
//        for (NSDictionary *dic in value) {
//            XLFirstListList *flistlist = [[XLFirstListList alloc] initWithDictionary:dic];
//            [arr addObject:flistlist];
//        }
//    }
//    self.list = arr;
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqual:@"id"]) {
        self.ID = (NSInteger)value;
    }
}

@end
