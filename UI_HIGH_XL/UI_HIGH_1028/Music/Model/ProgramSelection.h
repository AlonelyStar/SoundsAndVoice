//
//  ProgramSelection.h
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgramSelection : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *albumCoverUrl290;
@property (nonatomic, strong) NSString *coverMiddle;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger tracksCounts;
@property (nonatomic, assign) NSInteger playsCounts;
@property (nonatomic, assign) NSInteger lastUptrackId;
@property (nonatomic, strong) NSString *lastUptrackTitle;
@property (nonatomic, assign) NSInteger lastUptrackAt;
@property (nonatomic, assign) BOOL isFinished;
@property (nonatomic, assign) NSInteger serialState;

@end








