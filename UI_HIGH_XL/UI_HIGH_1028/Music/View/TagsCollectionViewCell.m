//
//  TagsCollectionViewCell.m
//  Music
//
//  Created by zhupeng on 15/10/29.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "TagsCollectionViewCell.h"

@implementation TagsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.layer.borderColor = [UIColor grayColor].CGColor;
        self.titleLabel.layer.cornerRadius = self.bounds.size.height / 3;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.alpha = 0.8;
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}


@end
