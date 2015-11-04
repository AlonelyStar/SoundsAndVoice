//
//  XLPublishAlbum.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/30.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLPublishAlbum : NSObject

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *coverSmall;
@property (nonatomic,strong) NSString *coverMiddle;
@property (nonatomic,strong) NSString *coverLarge;

@property (nonatomic, assign) NSInteger updatedAt;

/**
 *  专辑数目
 */
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger shares;

/**
 *  看过人数
 */
@property (nonatomic, assign) NSInteger playTimes;



@end
