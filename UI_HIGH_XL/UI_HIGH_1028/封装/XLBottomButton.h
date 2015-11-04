//
//  XLBottomButton.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropButton,XLFirstListList;
@interface XLBottomButton : UIView

@property (nonatomic,strong) UIButton *imageButton;
@property (nonatomic,strong) DropButton *titleBtn;

@property (nonatomic,strong) XLFirstListList *listlist;

@end
