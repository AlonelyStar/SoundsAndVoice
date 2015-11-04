//
//  XLAttentionCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAttentionCell.h"
#import "UIImageView+WebCache.h"
#import "XLDetailTop.h"
#import "NSString+XL.h"
@interface XLAttentionCell()

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@property (strong, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (strong, nonatomic) IBOutlet UILabel *voiceLabel;

@property (strong, nonatomic) IBOutlet UILabel *funsLabel;

@property (strong, nonatomic) IBOutlet UILabel *ptitleLabel;

@property (strong, nonatomic) IBOutlet UIImageView *isVerifiedImgView;



@end

@implementation XLAttentionCell




- (void)setAttention:(XLDetailTop *)attention {
    _attention = attention;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:attention.smallLogo] placeholderImage:nil];
    
    self.nicknameLabel.text = attention.nickname;
    self.voiceLabel.text = [NSString getGreaterTenThousandWithNumber:attention.tracks];
    self.funsLabel.text = [NSString getGreaterTenThousandWithNumber:attention.followers];
    self.ptitleLabel.text = attention.ptitle;
    
    if (attention.isVerified) {
        self.isVerifiedImgView.image = [UIImage imageNamed:@"daV"];
    }
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
