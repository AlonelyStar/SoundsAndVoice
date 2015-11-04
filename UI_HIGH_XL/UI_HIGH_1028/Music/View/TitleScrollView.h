//
//  TitleScrollView.h
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleScrollView : UIScrollView


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSTimer *timer;

@end
