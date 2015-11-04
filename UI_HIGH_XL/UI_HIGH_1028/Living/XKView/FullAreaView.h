//
//  FullAreaView.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/31.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullAreaView : UIView

@property (nonatomic,strong)NSArray *areaArray;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSIndexPath *indexPath;

@end
