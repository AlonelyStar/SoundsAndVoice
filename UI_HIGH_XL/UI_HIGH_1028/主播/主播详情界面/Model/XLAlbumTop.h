//
//  XLAlbumTop.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLAlbumTop : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger downloadSize;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger playtimes;
@property (nonatomic, assign) NSInteger downloadAacSize;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger createdAt;

@property (nonatomic,strong) NSString *downloadUrl;
@property (nonatomic,strong) NSString *playUrl32;
@property (nonatomic,strong) NSString *coverSmall;
@property (nonatomic,strong) NSString *playUrl64;
@property (nonatomic,strong) NSString *refSmallLogo;
@property (nonatomic,strong) NSString *coverLarge;
@property (nonatomic,strong) NSString *albumImage;
@property (nonatomic,strong) NSString *coverMiddle;
@property (nonatomic,strong) NSString *downloadAacUrl;
@property (nonatomic,strong) NSString *playPathAacv164;
@property (nonatomic,strong) NSString *playPathAacv224;

@property (nonatomic,strong) NSString *albumTitle;
@property (nonatomic,strong) NSString *categoryName;
@property (nonatomic,strong) NSString *richIntro;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *tags;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *avatarPath;
@property (nonatomic,strong) NSString *nickname;

@property (nonatomic,strong) NSDictionary *userInfo;
@property (nonatomic,strong) NSArray *images;

@property (nonatomic,assign) NSInteger playTimes;

@end
