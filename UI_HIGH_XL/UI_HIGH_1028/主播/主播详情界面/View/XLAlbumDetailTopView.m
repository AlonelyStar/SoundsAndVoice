//
//  XLAlbumDetailTopView.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAlbumDetailTopView.h"
#import "UIImageView+WebCache.h"
#import "XLAlbumTop.h"
#import "NSString+XL.h"
@interface XLAlbumDetailTopView()

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;





@property (strong, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation XLAlbumDetailTopView

+ (instancetype)albumDetailTopView {
    return [[[NSBundle mainBundle] loadNibNamed:@"XLAlbumDetailTopView" owner:nil options:nil] lastObject];
}

- (void)setAlbumTop:(XLAlbumTop *)albumTop {
    _albumTop = albumTop;
    

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:albumTop.avatarPath] placeholderImage:nil];
    self.iconImageView.layer.cornerRadius = 20;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.userInteractionEnabled = YES;
    
    [self.albumImageLabel sd_setImageWithURL:[NSURL URLWithString:albumTop.coverSmall] placeholderImage:nil];
    self.albumImageLabel.userInteractionEnabled = YES;
    
    self.richIntroLabel.text = albumTop.intro;
    
    self.albumTitleLabel.text = albumTop.nickname;
    self.titleLabel.text = albumTop.title;
    self.backgroundColor = [UIColor clearColor];
    
    self.playtimeLabel.text = [NSString getGreaterTenThousandWithNumber:albumTop.playTimes];
}

@end
