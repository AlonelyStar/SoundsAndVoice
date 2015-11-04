//
//  XKCateGoryCell.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CateGoryView;

@interface XKCateGoryCell : UITableViewCell

@property (nonatomic,strong)CateGoryView *localView;
@property (nonatomic,strong)CateGoryView *CountryView;
@property (nonatomic,strong)CateGoryView *shengView;
@property (nonatomic,strong)CateGoryView *internetView;



@end
