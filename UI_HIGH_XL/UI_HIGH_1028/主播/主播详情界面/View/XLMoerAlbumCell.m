//
//  XLMoerAlbumCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLMoerAlbumCell.h"


@interface XLMoerAlbumCell()



@property (nonatomic,strong) UILabel *lookAllLabel;
@property (nonatomic,strong) UIImageView *jiantouImgView;


@end

@implementation XLMoerAlbumCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.moreAlbumBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.moreAlbumBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
        [self.contentView addSubview:self.moreAlbumBtn];
        
        self.lookAllLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2 + 50, 30))];
        self.lookAllLabel.text = @"查看全部专辑";
        self.lookAllLabel.textAlignment = NSTextAlignmentRight;
        [self.moreAlbumBtn addSubview:self.lookAllLabel];
        
        self.jiantouImgView = [[UIImageView alloc] initWithFrame:(CGRectMake([UIScreen mainScreen].bounds.size.width / 2 + 50, 5, 20, 20))];
        self.jiantouImgView.image = [UIImage imageNamed:@"dropBtnImg"];
        [self.moreAlbumBtn addSubview:self.jiantouImgView];
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
