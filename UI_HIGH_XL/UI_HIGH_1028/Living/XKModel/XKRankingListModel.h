//
//  XKRankingListModel.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RadioPlayerURLModel;

@interface XKRankingListModel : NSObject

@property (nonatomic,assign)NSInteger recommendType;
@property (nonatomic,retain)NSString *picPath;
@property (nonatomic,assign)NSInteger radioId;
@property (nonatomic,retain)NSString *rname;
@property (nonatomic,retain)NSString *radioCoverSmall;
@property (nonatomic,retain)NSString *radioCoverLarge;
@property (nonatomic,assign)NSInteger programScheduleId;
@property (nonatomic,retain)NSString *programName;
@property (nonatomic,retain)NSString *startTime;
@property (nonatomic,retain)NSString *endTime;
@property (nonatomic,assign)NSInteger radioPlayCount;
@property (nonatomic,strong)RadioPlayerURLModel *RPURL;

@end
