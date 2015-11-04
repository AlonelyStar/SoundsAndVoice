//
//  XKRankingListCell.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKRankingListCell.h"
#import "XKRankingListModel.h"
#import "UIImageView+WebCache.h"
#import "UIColor+AddColor.h"

@interface XKRankingListCell ()

@property (nonatomic,strong)UIImageView *imageV;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *stateLabel;

@property (nonatomic,strong)UILabel *peopleLabel;

@property (nonatomic,strong)UIImageView *rightV;



@end

@implementation XKRankingListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth/5 + 10, kScreenWidth/5 + 10)];
        
        [self.contentView addSubview:self.imageV];
        self.imageV.layer.borderWidth = 1;
        self.imageV.layer.borderColor = [UIColor huiseColor].CGColor;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageV.frame.origin.x + self.imageV.frame.size.width + 5, self.imageV.frame.origin.y, kScreenWidth / 5 * 3, self.imageV.bounds.size.height / 3)];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];
        
        
        self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height)];
        self.stateLabel.font = [UIFont systemFontOfSize:13];
        self.stateLabel.alpha = 0.5;
        [self.contentView addSubview:self.stateLabel];
        
        
        self.peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.stateLabel.frame.origin.x, self.stateLabel.frame.origin.y + self.stateLabel.bounds.size.height, self.stateLabel.bounds.size.width, self.stateLabel.bounds.size.height)];
        self.peopleLabel.font = [UIFont systemFontOfSize:12];
        self.peopleLabel.alpha = 0.5;
        [self.contentView addSubview:self.peopleLabel];
        
        
        self.rightV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 40, kScreenWidth/10  , 30, 30)];
        self.rightV.image = [UIImage imageNamed:@"iconfont-jiantouyou"];
        [self.contentView addSubview:self.rightV];
   
        
    }
    return self;
    
    
    
}

-(void)setModel:(XKRankingListModel *)model{
    _model = model;
    if (model != nil) {
        [self.imageV setImageWithURL:[NSURL URLWithString:model.radioCoverLarge] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        self.titleLabel.text = model.rname;
        if (model.programName == nil) {
            model.programName = @"暂无节目单";
        }
        self.stateLabel.text = [NSString stringWithFormat:@"直播中: %@",model.programName];
        if (model.radioPlayCount >= 10000) {
            CGFloat b = model.radioPlayCount;
            CGFloat a = b / 10000.0;
            self.peopleLabel.text = [NSString stringWithFormat:@"收听人数:  %.1f万人",a];
        }else{
            self.peopleLabel.text = [NSString stringWithFormat:@"收听人数: %ld人",model.radioPlayCount];
        }
     
    }
}
@end
