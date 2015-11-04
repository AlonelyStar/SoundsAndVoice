//
//  BaseViewController.h
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PicsLikeControl;
@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong)  PicsLikeControl *picControl;

@property (nonatomic,strong) UIImage *image0;
@property (nonatomic,strong) UIImage *image1;

@end
