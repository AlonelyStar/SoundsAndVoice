//
//  XLAlbumDetailTopView.h
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLAlbumTop;
@interface XLAlbumDetailTopView : UIView

+ (instancetype)albumDetailTopView;

@property (nonatomic,strong) XLAlbumTop *albumTop;

@property (strong, nonatomic) IBOutlet UILabel *playtimeLabel;

@property (strong, nonatomic) IBOutlet UIImageView *jiantouImageView;
@property (strong, nonatomic) IBOutlet UILabel *richIntroLabel;

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UIImageView *albumImageLabel;

@property (strong, nonatomic) IBOutlet UIButton *introduceButton;


@end
