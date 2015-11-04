//
//  XLMoreList.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLMoreList : NSObject

@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,assign) NSInteger uid;
@property (nonatomic,strong) NSString *personDescribe;
@property (nonatomic,assign) NSInteger tracksCounts;
@property (nonatomic,assign) NSInteger followersCounts;

@property (nonatomic,strong) NSString *middleLogo;
@property (nonatomic,strong) NSString *largeLogo;

@end
