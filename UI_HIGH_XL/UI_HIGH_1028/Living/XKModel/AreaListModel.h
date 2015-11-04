//
//  AreaListModel.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaListModel : NSObject

@property (nonatomic,assign)NSInteger ID;

@property (nonatomic,assign)NSInteger provinceCode;

@property (nonatomic,strong)NSString *provinceName;

@property (nonatomic,assign)NSInteger *provinceType;

@property (nonatomic,strong)NSString *createAt;

@end
