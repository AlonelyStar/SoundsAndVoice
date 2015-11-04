//
//  HeaderView.m
//  Music
//
//  Created by zhupeng on 15/10/29.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "HeaderView.h"
#import "UIColor+AddColor.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.iconImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(5, 3, 15, 15))];
        self.iconImageView.image = [UIImage imageNamed:@"iconfont-right-2"];
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:(CGRectMake(20, 0, 200, 20))];
        [self addSubview:self.titleLabel];
        
        self.moreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.moreButton.frame = CGRectMake(220, 0, self.bounds.size.width - 220, 20);
        [self.moreButton setTitle:@"更多 >" forState:(UIControlStateNormal)];
        [self.moreButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self.moreButton setTitleColor:[UIColor jinjuse] forState:(UIControlStateHighlighted)];
        self.moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, self.moreButton.bounds.size.width - 50, 0, 0);
        self.moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.moreButton];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
