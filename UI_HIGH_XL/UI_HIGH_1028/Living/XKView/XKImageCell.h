//
//  XKImageCell.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKRankingListModel;

@interface XKImageCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *biankuangView;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UILabel *label;

@property (nonatomic,strong)XKRankingListModel *model;

@end
