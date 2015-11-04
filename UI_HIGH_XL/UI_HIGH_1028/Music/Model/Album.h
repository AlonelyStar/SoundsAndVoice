//
//  Album.h
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *albumCoverUrl290;

@property (nonatomic, assign) NSInteger lastUptrackAt;

@property (nonatomic, assign) NSInteger playsCounts;

@property (nonatomic, assign) NSInteger trackCounts;

@property (nonatomic, assign) NSInteger serialState;

@property (nonatomic, strong) NSString *coverMiddle;

@property (nonatomic, strong) NSString *tags;

@property (nonatomic, strong) NSString *intro;


@end
