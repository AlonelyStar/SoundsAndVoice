//
//  XKImageCell.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKImageCell.h"
#import "XKRankingListModel.h"
#import "UIImageView+WebCache.h"

@implementation XKImageCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.biankuangView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        self.biankuangView.image = [UIImage imageNamed:@"biankuang1"];
        [self.contentView addSubview:self.biankuangView];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, frame.size.width - 30, frame.size.width - 30)];
        [self.biankuangView addSubview:self.imageView];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(self.biankuangView.frame.origin.x, self.biankuangView.frame.origin.y + self.biankuangView.bounds.size.height + 10, self.biankuangView.bounds.size.width, 15)];
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];
       
    }
    return self;
}

-(void)setModel:(XKRankingListModel *)model{
    if (model != nil) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.picPath] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.label.text = model.rname;
    }
}

@end
