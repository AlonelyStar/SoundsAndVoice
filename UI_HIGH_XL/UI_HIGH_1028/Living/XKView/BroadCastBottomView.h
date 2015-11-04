//
//  BroadCastBottomView.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/11/2.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SmallIconView;

@interface BroadCastBottomView : UIView

@property (nonatomic,strong)SmallIconView *collectIconView;
@property (nonatomic,strong)SmallIconView *timeIconView;
@property (nonatomic,strong)SmallIconView *shareIconView;

@property (nonatomic,strong)UISlider *slider;

@property (nonatomic,strong)UILabel *startTimeLabel;
@property (nonatomic,strong)UILabel *endTimeLabel;

@property (nonatomic,strong)UIButton *backButton;
@property (nonatomic,strong)UIButton *startButton;
@property (nonatomic,strong)UIButton *pauseButton;
@property (nonatomic,strong)UIButton *frontButton;

@property (nonatomic,strong)UIView *bottomView;

@end
