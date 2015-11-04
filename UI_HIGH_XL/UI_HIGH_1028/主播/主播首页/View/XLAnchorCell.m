//
//  XLAnchorCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAnchorCell.h"
#import "XLImageLabelView.h"
#import "DropButton.h"
#import "XLBottomButton.h"
#import "UIImageView+WebCache.h"
#import "XLFirstList.h"
#import "XLFirstListList.h"


#define kLeft 10
#define kTop 10
#define kHorizon 20
#define kVertical 20
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface XLAnchorCell()



@end
@implementation XLAnchorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imglabView = [[XLImageLabelView alloc] initWithFrame:(CGRectMake(kLeft, kTop, ScreenWidth / 2, 20))];
        [self.contentView addSubview:self.imglabView];
        
        
        CGFloat dropBtnWidth = 60;
        self.moreBtn = [DropButton buttonWithType:(UIButtonTypeCustom)];
        self.moreBtn.frame = (CGRectMake(ScreenWidth - kLeft - dropBtnWidth, kTop, dropBtnWidth, 20)) ;
        
        [self.moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
        [self.moreBtn setImage:[UIImage imageNamed:@"dropBtnImg"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.moreBtn];
        
        
        CGFloat leftX = kLeft;
        CGFloat leftY = self.imglabView.frame.origin.y + self.imglabView.bounds.size.height + kTop;
        CGFloat leftWidth = (ScreenWidth - 2 * kLeft - 2 * kHorizon) / 3;
        CGFloat leftHeight = leftWidth + leftWidth / 3;
        self.leftBtn = [[XLBottomButton alloc] initWithFrame:(CGRectMake(leftX, leftY, leftWidth, leftHeight))];
        self.leftBtn.imageButton.tag = 1000;
        [self.contentView addSubview:self.leftBtn];
        
        self.centerBtn = [[XLBottomButton alloc] initWithFrame:(CGRectMake(self.leftBtn.frame.origin.x + self.leftBtn.bounds.size.width + kHorizon, leftY, leftWidth, leftHeight))];
        self.centerBtn.imageButton.tag = 1001;
        [self.contentView addSubview:self.centerBtn];
        
        self.rightBtn = [[XLBottomButton alloc] initWithFrame:(CGRectMake(self.centerBtn.frame.origin.x + self.centerBtn.bounds.size.width + kHorizon, leftY, leftWidth, leftHeight))];
        self.rightBtn.imageButton.tag = 1002;
        [self.contentView addSubview:self.rightBtn];

        
    }
    return self;
}

- (void)setListlistArr:(NSArray *)listlistArr {
    _listlistArr = listlistArr;
    if (listlistArr.count != 0) {
       
        self.leftBtn.listlist = listlistArr[0];
        self.centerBtn.listlist = listlistArr[1];
        self.rightBtn.listlist = listlistArr[2];
        
    }
}

- (void)setListArr:(XLFirstList *)listArr {
    _listArr = listArr;
    
    self.imglabView.titleLabel.text = listArr.title;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
