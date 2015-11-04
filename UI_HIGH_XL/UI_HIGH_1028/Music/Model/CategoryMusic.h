//
//  CategoryMusic.h
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryMusic : NSObject

@property (nonatomic, assign) NSInteger moduleType;
@property (nonatomic, strong) NSString *calcDimension;
@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, strong) NSMutableArray *list;

@end
