//
//  XLTopView.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLAlbumType;
typedef void (^XLTopViewBlock) (XLAlbumType *);
@interface XLTopView : UIView

@property (nonatomic,strong) NSMutableArray *arr;

/**
 *  传递topCollection的点击
 */
@property (nonatomic, strong) XLTopViewBlock topViewBlock;

@property (nonatomic,strong) UICollectionView *collection;

@property (nonatomic,strong) NSIndexPath *indexPath;

@end
