//
//  AlbumDetail.h
//  Music
//
//  Created by zhupeng on 15/10/29.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumDetail : NSObject

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *coverOrigin;
@property (nonatomic, strong) NSString *coverSmall;
@property (nonatomic, strong) NSString *coverMiddle;
@property (nonatomic, strong) NSString *coverLarge;
@property (nonatomic, strong) NSString *coverWebLarge;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger updatedAt;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, strong) NSString *avatarPath;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *introRich;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) BOOL hasNew;
@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, assign) NSInteger playTimes;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger serializeStatus;
@property (nonatomic, assign) NSInteger serialState;

@end
