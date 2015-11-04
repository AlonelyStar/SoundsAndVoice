//
//  XKCateGoryCell.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKCateGoryCell.h"
#import "CateGoryView.h"
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@implementation XKCateGoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.localView = [[CateGoryView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth/4- 12.5 ,kScreenWidth/4 - 12.5 + 35)];
        self.localView.titleLabel.text = @"本地台";
        self.localView.imageButton.tag = 1000;
        [self.localView.imageButton setImage:[UIImage imageNamed:@"iconfont-local"] forState:(UIControlStateNormal)];
        
        self.CountryView = [[CateGoryView alloc]initWithFrame:CGRectMake(self.localView.frame.origin.x + self.localView.frame.size.width + 10,10 , self.localView.bounds.size.width, self.localView.bounds.size.height)];
        self.CountryView.titleLabel.text = @"国家台";
        self.CountryView.imageButton.tag = 1001;
        [self.CountryView.imageButton setImage:[UIImage imageNamed:@"iconfont-guojia"] forState:(UIControlStateNormal)];
        
        self.shengView = [[CateGoryView alloc]initWithFrame:CGRectMake(self.CountryView.frame.origin.x + self.CountryView.frame.size.width + 10, 10, self.CountryView.bounds.size.width, self.CountryView.bounds.size.height)];
        self.shengView.titleLabel.text = @"省市台";
        self.shengView.imageButton.tag = 1002;
        [self.shengView.imageButton setImage:[UIImage imageNamed:@"iconfont-520shengshijilian"] forState:(UIControlStateNormal)];
        
        self.internetView = [[CateGoryView alloc]initWithFrame:CGRectMake(self.shengView.frame.origin.x + self.shengView.bounds.size.width + 10, 10, self.shengView.bounds.size.width, self.shengView.bounds.size.height)];
        self.internetView.titleLabel.text = @"网络台";
        self.internetView.imageButton.tag = 1003;
        [self.internetView.imageButton setImage:[UIImage imageNamed:@"iconfont-xinhaota"] forState:(UIControlStateNormal)];
        
        [self.contentView addSubview:self.localView];
        [self.contentView addSubview:self.CountryView];
        [self.contentView addSubview:self.shengView];
        [self.contentView addSubview:self.internetView];
        
        
    }
    return self;
}
@end
