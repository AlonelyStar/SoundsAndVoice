//
//  XLMoreAnchorViewController.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class XLFirstList;
@interface XLMoreAnchorViewController : BaseViewController
/**
 *  全部总类
 */
@property (nonatomic,strong) NSArray *typeArr;

/**
 *  具体传递过来的类别
 */
@property (nonatomic,strong) XLFirstList *specificList;

@end
