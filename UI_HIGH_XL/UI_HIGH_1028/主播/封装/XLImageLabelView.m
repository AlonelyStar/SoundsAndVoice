//
//  XLImageLabelView.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLImageLabelView.h"

@implementation XLImageLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(2, 2, 16, 16))];
        self.imageView.image = [UIImage imageNamed:@"iconfont-play"];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(20, 0, frame.size.width - 20, frame.size.height))];
        [self addSubview:self.titleLabel];
        
        self.titleLabel.text = @"新晋主播";
    }
    return self;
}
@end
