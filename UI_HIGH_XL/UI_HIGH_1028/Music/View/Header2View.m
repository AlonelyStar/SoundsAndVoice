//
//  Header2View.m
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "Header2View.h"
#import "UIColor+AddColor.h"

@implementation Header2View

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor silverColor];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.bounds.size.width / 2, self.bounds.size.height)];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.titleLabel];
        
        self.sortButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.sortButton.frame = CGRectMake(self.bounds.size.width * 4 / 5, 0, self.bounds.size.width / 5, self.bounds.size.height);
        [self.sortButton setTitle:@"排序" forState:(UIControlStateNormal)];
        [self.sortButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.sortButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        self.sortButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.sortButton];
        
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
