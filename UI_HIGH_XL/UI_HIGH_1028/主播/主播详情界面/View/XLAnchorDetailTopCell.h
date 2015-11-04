//
//  XLAnchorDetailTopCell.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLDetailTop;
@interface XLAnchorDetailTopCell : UITableViewCell

@property (nonatomic,strong) XLDetailTop *detailTop;

@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;

@property (strong, nonatomic) IBOutlet UIButton *funsBtn;

@property (strong, nonatomic) IBOutlet UIButton *praiseBtn;

@property (strong, nonatomic) IBOutlet UIImageView *jiantouImageView;

@property (strong, nonatomic) IBOutlet UIImageView *circleImageV;


@end
