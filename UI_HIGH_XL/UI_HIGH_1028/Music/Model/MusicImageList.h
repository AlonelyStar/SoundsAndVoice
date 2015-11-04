//
//  MusicImageList.h
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicImageList : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *shortTitle;
@property (nonatomic, strong) NSString *longTitle;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) BOOL isShare;
@property (nonatomic, assign) BOOL is_External_url;

@end
