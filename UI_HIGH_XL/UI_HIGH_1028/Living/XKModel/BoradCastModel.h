//
//  BoradCastModel.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/11/2.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AnnouncerModel;

@interface BoradCastModel : NSObject

@property (nonatomic,assign)NSInteger programId;
@property (nonatomic,assign)NSInteger programScheduleId;
@property (nonatomic,strong)NSString *programName;
@property (nonatomic,strong)NSString *startTime;
@property (nonatomic,strong)NSString *endTime;
@property (nonatomic,assign)NSInteger playType;
@property (nonatomic,assign)NSInteger fmuid;
@property (nonatomic,strong)NSMutableArray *announcerList;
@property (nonatomic,strong)NSString *playBackgroundPic;

@end
