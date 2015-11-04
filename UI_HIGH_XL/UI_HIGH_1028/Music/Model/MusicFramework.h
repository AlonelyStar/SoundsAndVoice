//
//  MusicFramework.h
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicFramework : NSObject

@property (nonatomic, strong) NSDictionary *tags;
@property (nonatomic, assign) NSInteger ret;
@property (nonatomic, strong) NSDictionary *categoryContents;
@property (nonatomic, assign) BOOL hasRecommendedZones;
@property (nonatomic, strong) NSDictionary *focusImages;
@property (nonatomic, strong) NSString *msg;

@end
