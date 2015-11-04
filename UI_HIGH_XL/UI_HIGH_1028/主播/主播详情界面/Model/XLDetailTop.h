//
//  XLDetailTop.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLDetailTop : NSObject

@property (nonatomic,assign) NSInteger uid;
/**
 *  关注的人
 */
@property (nonatomic,assign) NSInteger followings;
/**
 *  粉丝
 */
@property (nonatomic, assign) NSInteger followers;
/**
 *  赞过的人
 */
@property (nonatomic, assign) NSInteger favorites;
/**
 *  足迹
 */
@property (nonatomic, assign) NSInteger tracks;
/**
 *  专辑
 */
@property (nonatomic,assign) NSInteger albums;

@property (nonatomic,strong) NSString *location;
@property (nonatomic,strong) NSString *nickname;

@property (nonatomic,strong) NSString *smallLogo;
@property (nonatomic,strong) NSString *backgroundLogo;
@property (nonatomic,strong) NSString *mobileSmallLogo;
@property (nonatomic,strong) NSString *mobileLargeLogo;
@property (nonatomic,strong) NSString *mobileMiddleLogo;

@property (nonatomic,strong) NSString *personalSignature;
@property (nonatomic,strong) NSString *personDescribe;
@property (nonatomic,strong) NSString *ptitle;

@property (nonatomic, assign) BOOL isVerified;

@end
