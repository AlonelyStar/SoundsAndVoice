//
//  CateGoryView.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "CateGoryView.h"
#import "UIColor+AddColor.h"

@implementation CateGoryView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.imageButton.frame = CGRectMake(10, 10, frame.size.width - 20, frame.size.width - 20);
        
        self.imageButton.layer.cornerRadius = frame.size.width/2 - 10;
        self.imageButton.layer.masksToBounds = YES;
        self.imageButton.layer.borderWidth = 1;
        self.imageButton.layer.borderColor = [UIColor silverColor].CGColor;
        
        [self addSubview:self.imageButton];
            
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageButton.frame.origin.x, self.imageButton.frame.origin.y + self.imageButton.bounds.size.height + 10, self.imageButton.bounds.size.width, 15)];
        [self addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.alpha = 0.5;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
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
