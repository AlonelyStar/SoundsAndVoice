//
//  MusicDetailViewController.h
//  Music
//
//  Created by zhupeng on 15/10/29.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^UpDateBlock)(id object);

@interface MusicDetailViewController : BaseViewController

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) UpDateBlock upDateBlock;

@end
