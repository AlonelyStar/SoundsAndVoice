//
//  SmallIconView.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/11/2.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "SmallIconView.h"
#import "UIColor+AddColor.h"

@implementation SmallIconView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.iconButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
        [self addSubview:self.iconButton];
        
        self.iconLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.iconButton.frame.size.height + 5, frame.size.width, 12)];
        self.iconLabel.textAlignment = NSTextAlignmentCenter;
        self.iconLabel.textColor = [UIColor huiseColor];
        self.iconLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.iconLabel];
        
        
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
