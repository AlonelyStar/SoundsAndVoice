//
//  MoreAnchorCell.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLOneAnchorCell;
typedef void (^ListeningBtnReturnUidBlock) (NSInteger uid);
@interface MoreAnchorCell : UICollectionViewCell

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) XLOneAnchorCell *cell;

@property (nonatomic,copy) ListeningBtnReturnUidBlock listeningBlock;

@end
