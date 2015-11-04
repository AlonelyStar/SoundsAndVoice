//
//  XKRecommedModel.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RadioPlayerURLModel;

@interface XKRecommedModel : NSObject

@property (nonatomic,assign)NSInteger recommendType;
@property (nonatomic,retain)NSString *radioId;
@property (nonatomic,retain)NSString *picPath;
@property (nonatomic,retain)NSString *rname;
@property (nonatomic,retain)NSString *radioPlayCount;
@property (nonatomic,strong)RadioPlayerURLModel *RPURL;
@property (nonatomic,assign)NSInteger programScheduleId;
@property (nonatomic,retain)NSString *programName;
@property (nonatomic,retain)NSString *startTime;
@property (nonatomic,retain)NSString *endTime;



@end
