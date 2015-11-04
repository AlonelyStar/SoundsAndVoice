//
//  XLBottomButton.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLBottomButton.h"
#import "DropButton.h"
#import "XLFirstListList.h"
#import "UIButton+WebCache.h"

@implementation XLBottomButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.imageButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height * 3 / 4);
        [self addSubview:self.imageButton];
        
        self.titleBtn = [DropButton buttonWithType:(UIButtonTypeCustom)];
        self.titleBtn.frame = (CGRectMake(0, self.imageButton.bounds.size.height, frame.size.width, frame.size.height / 4));
        [self.titleBtn setImage:[UIImage imageNamed:@"wujiaoxingkong"] forState:(UIControlStateNormal)];
       
    
        [self addSubview:self.titleBtn];
        

    }
    return self;
}

- (void)setListlist:(XLFirstListList *)listlist {
    _listlist = listlist;
    
    [self.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:listlist.smallLogo] forState:(UIControlStateNormal) placeholderImage:nil];
    self.titleBtn.titleLabel.text = listlist.nickname;
    [self.titleBtn setTitle:listlist.nickname forState:(UIControlStateNormal)];
    
}

@end
