//
//  BroadCastBottomView.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/11/2.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "BroadCastBottomView.h"
#import "SmallIconView.h"
#import "UIColor+AddColor.h"

@implementation BroadCastBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.collectIconView = [[SmallIconView alloc]initWithFrame:CGRectMake(50, 0, 30, 50)];
        [self addSubview:self.collectIconView];
        [self.collectIconView.iconButton setImage:[UIImage imageNamed:@"iconfont-shoucang"] forState:(UIControlStateNormal)];
        self.collectIconView.iconLabel.text = @"收藏";
        
        self.timeIconView = [[SmallIconView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 15, 0, 30, 50)];
        [self addSubview:self.timeIconView];
        [self.timeIconView.iconButton setImage:[UIImage imageNamed:@"iconfont-dingshiguanbi (1)"] forState:(UIControlStateNormal)];
        self.timeIconView.iconLabel.text = @"定时";
        
        self.shareIconView = [[SmallIconView alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 0, 30, 50)];
        [self addSubview:self.shareIconView];
        [self.shareIconView.iconButton setImage:[UIImage imageNamed:@"iconfont-32pxxinlang"] forState:(UIControlStateNormal)];
        self.shareIconView.iconLabel.text = @"分享";
        
        self.slider = [[UISlider alloc]initWithFrame:CGRectMake(10, self.collectIconView.frame.size.height + 10, kScreenWidth - 20, 15)];
        [self addSubview:self.slider];
        
        
        self.startTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.slider.frame.origin.y + self.slider.frame.size.height + 5, 70, 12)];
        self.startTimeLabel.textColor = [UIColor silverColor];
        self.startTimeLabel.textAlignment = NSTextAlignmentLeft;
        self.startTimeLabel.font = [UIFont systemFontOfSize:12];
        self.startTimeLabel.alpha = 0.5;
        [self addSubview:self.startTimeLabel];
        
        self.endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 80, self.slider.frame.origin.y + self.slider.frame.size.height + 5, 70, 12)];
        self.endTimeLabel.textColor = [UIColor silverColor];
        self.endTimeLabel.textAlignment = NSTextAlignmentRight;
        self.endTimeLabel.font = [UIFont systemFontOfSize:12];
        self.endTimeLabel.alpha = 0.5;
        [self addSubview:self.endTimeLabel];
        
        self.backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.backButton.frame = CGRectMake(kScreenWidth/4, self.endTimeLabel.frame.size.height + self.endTimeLabel.frame.origin.y + 15, 30, 30);
        [self.backButton setImage:[UIImage imageNamed:@"iconfont-shangyishou-2"] forState:(UIControlStateNormal)];
        [self.backButton setImage:[UIImage imageNamed:@"iconfont-shangyishou-2"] forState:(UIControlStateHighlighted)];
        [self addSubview:self.backButton];
        
        
        self.startButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.startButton.frame = CGRectMake(kScreenWidth/2 - 20, self.backButton.frame.origin.y-5, 40, 40);
        [self.startButton setImage:[UIImage imageNamed:@"playbar_playbtn_nomal2"] forState:(UIControlStateNormal)];
        [self addSubview:self.startButton];
        
        self.pauseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.pauseButton.frame = CGRectMake(kScreenWidth/2 - 20, self.backButton.frame.origin.y-5, 40, 40);
        [self.pauseButton setImage:[UIImage imageNamed:@"playbar_pausebtn_nomal2"] forState:(UIControlStateNormal)];
        [self addSubview:self.pauseButton];
        
        self.frontButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.frontButton.frame = CGRectMake(kScreenWidth/4 * 3 - 30, self.endTimeLabel.frame.size.height + self.endTimeLabel.frame.origin.y + 15, 30, 30);
        [self.frontButton setImage:[UIImage imageNamed:@"iconfont-xiayishou"] forState:(UIControlStateNormal)];
        [self.frontButton setImage:[UIImage imageNamed:@"iconfont-xiayishou"] forState:(UIControlStateHighlighted)];
        [self addSubview:self.frontButton];
        
        
        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.startButton.frame.origin.y + self.startButton.frame.size.height + 20, kScreenWidth, frame.size.height - self.startButton.frame.size.height - self.startButton.frame.origin.y - 20)];
        [self addSubview:self.bottomView];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, self.bottomView.bounds.size.height/2 - 6, 100, 12)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor huiseColor];
        label.alpha = 0.5;
        label.text = @"进入电台关注页面";
        [self.bottomView addSubview:label];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 30, self.bottomView.bounds.size.height/2 - 7.5, 15, 15)];
        label2.text = @"〉";
        label2.alpha = 0.5;
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = [UIColor huiseColor];
        [self.bottomView addSubview:label2];
        
        [self.slider setThumbImage:[UIImage imageNamed:@"iconfont-yuandian"] forState:(UIControlStateNormal)];
        [self.slider setThumbImage:[UIImage imageNamed:@"iconfont-yuandian"] forState:(UIControlStateHighlighted)];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
