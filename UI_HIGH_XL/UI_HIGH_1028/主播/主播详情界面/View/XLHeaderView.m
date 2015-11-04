//
//  XLHeaderView.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLHeaderView.h"
#import "UIColor+AddColor.h"
@implementation XLHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(10, 5, self.bounds.size.width / 4, self.bounds.size.height))];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.titleLabel];
        
        self.countLabel = [[UILabel alloc] initWithFrame:(CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.bounds.size.width , 5, self.bounds.size.width / 4, self.bounds.size.height))];
        self.countLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.countLabel];
        self.backgroundColor = [UIColor silverColor];
        self.alpha = 0.5;
    }
    return self;
}

@end
