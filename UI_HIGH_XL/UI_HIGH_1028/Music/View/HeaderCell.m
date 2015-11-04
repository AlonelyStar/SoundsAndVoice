//
//  HeaderCell.m
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "HeaderCell.h"
#import "UIColor+AddColor.h"

@implementation HeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
        
        self.maskView = [[UIView alloc]init];
        self.maskView.alpha = 0;
        [self.contentView addSubview:self.maskView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.maskView.frame = CGRectMake(0, self.titleLabel.bounds.size.height - 1, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
    self.maskView.backgroundColor = [UIColor jinjuse];
}

@end
