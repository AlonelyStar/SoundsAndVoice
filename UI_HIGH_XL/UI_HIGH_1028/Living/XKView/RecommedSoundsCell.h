//
//  RecommedSoundsCell.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommedSoundsCell : UITableViewCell

@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UIImageView *image;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSArray *array;



@end
