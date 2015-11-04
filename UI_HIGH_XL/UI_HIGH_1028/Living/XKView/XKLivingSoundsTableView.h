//
//  XKLivingSoundsTableView.h
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XKRankingListModel;
typedef void (^MyBlock) (NSString *url);
typedef void (^MyBlock1) (XKRankingListModel *model);

@class XKCateGoryCell;
@class RecommedSoundsCell;
@class XKRankingListCell;

@interface XKLivingSoundsTableView : UITableView

@property (nonatomic,strong)NSArray *recommedArray;

@property (nonatomic,strong)NSArray *rankingArray;

@property (nonatomic,strong)UIView *moreView;

@property (nonatomic,strong)UIButton *moreButton;

@property (nonatomic,strong)XKCateGoryCell *categoryCell;

@property (nonatomic,strong)RecommedSoundsCell *recommedCell;

@property (nonatomic,strong)XKRankingListCell *rankingCell;

@property (nonatomic,strong)MyBlock block;

@property (nonatomic,strong)MyBlock1 block1;

@end
