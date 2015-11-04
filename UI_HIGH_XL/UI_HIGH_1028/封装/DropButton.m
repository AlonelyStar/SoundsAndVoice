//
//  DropButton.m
//  LOL盒子
//
//  Created by lanou on 15/10/20.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "DropButton.h"
#define ImageWidth 30
@implementation DropButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter; 
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
}


// 设置标题位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleWidth = contentRect.size.width - ImageWidth;
    CGFloat titleHeight = contentRect.size.height;

    return CGRectMake(0, 0, titleWidth, titleHeight);
}
// 设置图片位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageWidth = ImageWidth;
    CGFloat imageHeight = contentRect.size.height;
    CGFloat imageX = contentRect.size.width - ImageWidth;
    return CGRectMake(imageX, 0, imageWidth, imageHeight);
}


@end
