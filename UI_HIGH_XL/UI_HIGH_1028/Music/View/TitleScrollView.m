//
//  TitleScrollView.m
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "TitleScrollView.h"

@implementation TitleScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1000, 20)];
        [self addSubview:self.titleLabel];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(autoPlay:) userInfo:@"给Timer传递信息" repeats:YES];
        
        
    }
    return self;
}

- (void)autoPlay:(NSTimer *)timer {
    CGFloat width = self.frame.size.width;
    CGPoint offSet = self.contentOffset;
    if (offSet.x + width >= self.titleLabel.bounds.size.width) {
        [UIView animateWithDuration:3 animations:^{
            [self setContentOffset:CGPointMake(0, offSet.y)];
        }];
    }else {
        [UIView animateWithDuration:3 animations:^{
            [self setContentOffset:CGPointMake(self.titleLabel.bounds.size.width - width, offSet.y)];
        }];
    }
    
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 1;
    [self.titleLabel sizeToFit];
    if (self.titleLabel.bounds.size.width < self.bounds.size.width) {
        self.titleLabel.frame = CGRectMake(self.bounds.size.width / 2 - self.titleLabel.bounds.size.width / 2, 0, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
