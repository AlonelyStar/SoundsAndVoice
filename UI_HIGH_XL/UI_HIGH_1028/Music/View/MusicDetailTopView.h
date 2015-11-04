//
//  MusicDetailTopView.h
//  Music
//
//  Created by zhupeng on 15/10/29.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumDetail.h"

@interface MusicDetailTopView : UIView

@property (nonatomic, strong) AlbumDetail *albumDetail;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIImageView *nextImageView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
