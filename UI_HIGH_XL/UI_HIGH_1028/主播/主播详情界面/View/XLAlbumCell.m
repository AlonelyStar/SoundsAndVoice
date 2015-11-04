//
//  XLAlbumCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAlbumCell.h"
#import "XLPublishAlbum.h"
#import "UIImageView+WebCache.h"
#import "NSString+XL.h"
@interface XLAlbumCell()

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *playTimesLabel;

@property (strong, nonatomic) IBOutlet UILabel *tracksLabel;



@end

@implementation XLAlbumCell


- (void)setPulishAlbum:(XLPublishAlbum *)pulishAlbum {
    _pulishAlbum = pulishAlbum;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:pulishAlbum.coverSmall] placeholderImage:nil];
    
    self.titleLabel.text = pulishAlbum.title;
    self.titleLabel.numberOfLines = 0;
    
    self.timeLabel.text = [NSString getGreaterTenThousandWithNumber:pulishAlbum.shares];
    
    self.playTimesLabel.text = [NSString getGreaterTenThousandWithNumber:pulishAlbum.playTimes];
    
    self.tracksLabel.text = [NSString getGreaterTenThousandWithNumber:pulishAlbum.tracks];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
