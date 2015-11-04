//
//  TracksList.h
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TracksList : NSObject

@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *playUrl64;
@property (nonatomic, strong) NSString *playUrl32;
@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, strong) NSString *playPathAacv164;
@property (nonatomic, strong) NSString *playPathAacv224;
@property (nonatomic, strong) NSString *downloadAacUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger processState;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, strong) NSString *coverSmall;
@property (nonatomic, strong) NSString *coverMiddle;
@property (nonatomic, strong) NSString *coverLarge;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *smallLogo;
@property (nonatomic, assign) NSInteger userSource;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *albumImage;
@property (nonatomic, assign) NSInteger orderNum;
@property (nonatomic, assign) NSInteger opType;
@property (nonatomic, assign) NSInteger refUid;
@property (nonatomic, strong) NSString *refNickname;
@property (nonatomic, strong) NSString *refSmallLogo;
@property (nonatomic, assign) BOOL isPublic;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger playtimes;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger downloadSize;
@property (nonatomic, assign) NSInteger downloadAacSize;

@end
