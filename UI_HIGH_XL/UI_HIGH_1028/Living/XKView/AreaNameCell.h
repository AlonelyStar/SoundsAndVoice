//
//  AreaNameCell.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/31.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaListModel;

@interface AreaNameCell : UICollectionViewCell


@property (nonatomic,strong)AreaListModel *model;

@property (nonatomic,strong)UILabel *label;

@end
