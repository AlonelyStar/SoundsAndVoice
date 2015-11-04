//
//  AnnouncerModel.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/11/2.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnouncerModel : NSObject

@property (nonatomic,assign)NSInteger announcerId;
@property (nonatomic,strong)NSString *announcerName;
@property (nonatomic,strong)NSString *announcerCover;
@property (nonatomic,assign)NSInteger createdAt;
@property (nonatomic,assign)NSInteger updatedAt;

@end
