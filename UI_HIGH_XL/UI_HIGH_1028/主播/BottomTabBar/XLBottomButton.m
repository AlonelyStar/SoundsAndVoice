//
//  XLBottomButton.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLBottomButton.h"

@implementation XLBottomButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.imageButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 10);
        [self addSubview:self.imageButton];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, self.imageButton.bounds.size.height, frame.size.width, 10))];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

@end
