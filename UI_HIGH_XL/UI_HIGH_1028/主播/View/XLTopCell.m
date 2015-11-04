//
//  XLTopCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLTopCell.h"

@implementation XLTopCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];

        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.bottomView = [[UIView alloc] initWithFrame:(CGRectMake(0, frame.size.height - 2, frame.size.width, 2))];
        self.bottomView.backgroundColor = [UIColor orangeColor];
        self.bottomView.alpha = 0;
        [self.contentView addSubview:self.bottomView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
     self.titleLabel.frame = (CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
}

@end
