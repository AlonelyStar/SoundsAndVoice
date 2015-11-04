//
//  XLAnchorCell.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLBottomButton,DropButton,XLImageLabelView;
@class XLFirstList,XLFirstListList;
@interface XLAnchorCell : UITableViewCell

@property (nonatomic,strong) XLImageLabelView *imglabView;

@property (nonatomic,strong) XLBottomButton *leftBtn;
@property (nonatomic,strong) XLBottomButton *centerBtn;
@property (nonatomic,strong) XLBottomButton *rightBtn;

@property (nonatomic,strong) DropButton *moreBtn;


@property (nonatomic,strong) NSArray *listlistArr;
@property (nonatomic,strong) XLFirstList *listArr;

@end
