//
//  XLOneAnchorCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLOneAnchorCell.h"
#import "DropButton.h"
#import "XLImageLabelView.h"
#import "XLBottomButton.h"
#import "UIImageView+WebCache.h"
#import "XLMoreList.h"
#import "NSString+XL.h"

#define kLeft 10
#define kTop 10
#define kHorizon 20
#define kVertical 20
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface XLOneAnchorCell()

@property (nonatomic,strong) UIImageView *iconImageV;
@property (nonatomic,strong) DropButton *nicknameBtn;
@property (nonatomic,strong) UILabel *personDesLabel;
@property (nonatomic,strong) XLImageLabelView *trackCountV;
@property (nonatomic,strong) XLImageLabelView *followerCountV;

@end

@implementation XLOneAnchorCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconImageV = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.iconImageV];
        
        self.nicknameBtn = [DropButton buttonWithType:(UIButtonTypeCustom)];
        [self.contentView addSubview:self.nicknameBtn];
        
        self.personDesLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.personDesLabel];
        
        
        self.listeningBtn = [[DropButton alloc] init];
        [self.contentView addSubview:self.listeningBtn];
        
        CGFloat iconX = 0;
        CGFloat iconY = 0;
        CGFloat iconWidth = ScreenWidth * 2 / 5;
        CGFloat iconHeight =iconWidth;
        self.iconImageV.frame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
        
        
        CGFloat nameX = self.iconImageV.frame.origin.x + self.iconImageV.bounds.size.width + kLeft;
        CGFloat nameY = kTop;
        CGFloat nameWidth = ScreenWidth - iconWidth - kLeft;
        CGFloat nameHeight = (iconHeight - 2*kTop) / 5;
        self.nicknameBtn.frame = CGRectMake(nameX, nameY, nameWidth / 2, nameHeight);
        [self.nicknameBtn setImage:[UIImage imageNamed:@"lovekong"] forState:(UIControlStateNormal)];
        
        self.personDesLabel.frame = CGRectMake(nameX, nameY + nameHeight + 5, nameWidth, nameHeight);
        self.trackCountV = [[XLImageLabelView alloc] initWithFrame:CGRectMake(nameX, self.personDesLabel.frame.origin.y + nameHeight + 5, nameWidth / 2, nameHeight)];
        [self.contentView addSubview:self.trackCountV];
        
        self.followerCountV = [[XLImageLabelView alloc] initWithFrame:CGRectMake(self.trackCountV.frame.origin.x + self.trackCountV.bounds.size.width, self.trackCountV.frame.origin.y , nameWidth / 2, nameHeight)];
        [self.contentView addSubview:self.followerCountV];

        self.trackCountV.imageView.image = [UIImage imageNamed:@"track"];
        
        self.followerCountV.imageView.image = [UIImage imageNamed:@"follower"];
        
        
        self.listeningBtn.frame = CGRectMake(nameX, self.trackCountV.frame.origin.y + nameHeight + kVertical, 60, 20);
        [self.listeningBtn setImage:[UIImage imageNamed:@"bofanglittle"] forState:(UIControlStateNormal)];
        [self.listeningBtn setTitle:@"试听" forState:(UIControlStateNormal)];
    }
    return self;
}

- (void)setMorelist:(XLMoreList *)morelist {
    _morelist = morelist;
    
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:morelist.middleLogo] placeholderImage:nil];
    [self.nicknameBtn setTitle:morelist.nickname forState:(UIControlStateNormal)];
    self.personDesLabel.text = morelist.personDescribe;

    
    self.trackCountV.titleLabel.text = [NSString stringWithFormat:@"%ld",self.morelist.tracksCounts];

    self.followerCountV.titleLabel.text = [NSString getGreaterTenThousandWithNumber:self.morelist.followersCounts];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
