//
//  AreaNameCell.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/31.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "AreaNameCell.h"
#import "AreaListModel.h"

@interface AreaNameCell()



@end

@implementation AreaNameCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.label.layer.cornerRadius = 5;
        self.label.layer.masksToBounds = YES;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.label];
 
        
    }
    return self;
    
    
}


-(void)setModel:(AreaListModel *)model{
    _model = model;
    if (model != nil) {
        self.label.text = model.provinceName;
        
    }
}

@end
