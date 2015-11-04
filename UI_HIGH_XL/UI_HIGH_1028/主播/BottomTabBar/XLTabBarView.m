//
//  XLTabBarView.m
//  PicsLikeControl
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 Tu You. All rights reserved.
//

#import "XLTabBarView.h"
#import "PicsLikeControl.h"
#import "UIButton+CZ.h"
@interface XLTabBarView() <PicsLikeControlDelegate>

@end

@implementation XLTabBarView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *image0 = [UIImage imageNamed:@"music88"];
        UIImage *image1 = [UIImage imageNamed:@"main-library-button"];
        NSArray *images = @[image0, image1];
        
        CGFloat picCWidth = 44;
        CGFloat picCX = frame.size.width / 2 - picCWidth / 2;
        PicsLikeControl *picControl = [[PicsLikeControl alloc] initWithFrame:CGRectMake(picCX, 0, picCWidth, picCWidth) multiImages:images];
        
        picControl.delegate = self;
        
        [self addSubview:picControl];
        self.backgroundColor = [UIColor greenColor];
        
        CGFloat width = (picCX - 2 * 20) / 2;
        CGFloat height = picCWidth;
        self.recommendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.recommendBtn.frame = CGRectMake(0, 0, width, height);
        [self.recommendBtn setNBg:@"recommendN" hBg:@"recommendH"];
        [self addSubview:self.recommendBtn];
        

        self.musicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.musicBtn.frame = CGRectMake(width, 0, width, height);
        [self.musicBtn setNBg:@"musicN" hBg:@"musicH"];
        [self addSubview:self.musicBtn];
        
        self.radioFMBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.radioFMBtn.frame = CGRectMake(width * 2 + picCWidth, 0, width, height);
        [self.radioFMBtn setNBg:@"radioN" hBg:@"radioH"];
        [self addSubview:self.radioFMBtn];
        
        self.myBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.myBtn.frame = CGRectMake(self.radioFMBtn.frame.origin.x + width, 0, width, height);
        [self.myBtn setNBg:@"myB" hBg:@"myH"];
        [self addSubview:self.myBtn];
        
    }
    return self;
}

- (void)controlTappedAtIndex:(int)index
{
    NSLog(@"index at %d tapped", index);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
