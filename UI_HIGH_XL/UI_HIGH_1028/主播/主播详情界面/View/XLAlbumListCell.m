//
//  XLAlbumListCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAlbumListCell.h"
#import "XLPublishVoice.h"
#import "NSString+CZ.h"
#import "NSString+XL.h"
@interface XLAlbumListCell()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *playTimesLabel;

@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

@property (strong, nonatomic) IBOutlet UILabel *durationLabel;




@end

@implementation XLAlbumListCell

- (void)setPublish:(XLPublishVoice *)publish {
    _publish = publish;
    
    self.titleLabel.text = publish.title;
    
    self.playTimesLabel.text = [NSString getGreaterTenThousandWithNumber:publish.playtimes];
    self.commentLabel.text = [NSString getGreaterTenThousandWithNumber:publish.comments];
    
    self.durationLabel.text = [NSString getMinuteSecondWithSecond:publish.duration];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
