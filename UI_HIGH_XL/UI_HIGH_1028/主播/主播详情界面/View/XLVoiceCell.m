//
//  XLVoiceCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLVoiceCell.h"
#import "XLPublishVoice.h"
#import "UIImageView+WebCache.h"
#import "NSString+XL.h"
#import "NSString+CZ.h"
@interface XLVoiceCell()

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (strong, nonatomic) IBOutlet UILabel *playtimesLabel;

@property (strong, nonatomic) IBOutlet UILabel *likesLabel;

@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;


@end


@implementation XLVoiceCell


- (void)setPulishVoice:(XLPublishVoice *)pulishVoice {
    _pulishVoice = pulishVoice;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:pulishVoice.coverSmall] placeholderImage:nil];
    
    self.titleLabel.text = pulishVoice.title;
    self.titleLabel.numberOfLines = 0;
    self.nicknameLabel.text = pulishVoice.nickname;
    
    self.playtimesLabel.text = [NSString getGreaterTenThousandWithNumber:pulishVoice.playtimes];
    
    self.likesLabel.text = [NSString getGreaterTenThousandWithNumber:pulishVoice.likes];
    
    self.createdAtLabel.text = [NSString getMinuteSecondWithSecond:pulishVoice.duration];
    

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
