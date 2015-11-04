//
//  MusicAlbumListCell.m
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MusicAlbumListCell.h"
#import "UIImageView+WebCache.h"
#import "MusicTool.h"

@interface MusicAlbumListCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nickname;

@property (nonatomic, strong) UIImageView *playCountsIV;
@property (nonatomic, strong) UILabel *playCountsLabel;
@property (nonatomic, strong) UIImageView *timeIV;
@property (nonatomic, strong) UILabel *timesLabel;

@property (nonatomic, assign) BOOL isPlay;


@end

@implementation MusicAlbumListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconImageView = [[UIImageView alloc]init];
        self.iconImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.iconImageView];
        
        self.playButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [self.playButton addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.iconImageView addSubview:self.playButton];
        
        self.titleLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.titleLabel];
        
        self.nickname = [[UILabel alloc]init];
        [self.contentView addSubview:self.nickname];
        
        self.playCountsIV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.playCountsIV];
        self.playCountsLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.playCountsLabel];
        
        self.timeIV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.timeIV];
        self.timesLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.timesLabel];
        
        self.isPlay = NO;
        
        
        
    }
    return self;
}
//播放按钮
- (void)playAction:(UIButton *)button {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"播放图片刷新通知" object:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.isPlay) {
                [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_nomal2"] forState:(UIControlStateNormal)];
                [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_click2"] forState:(UIControlStateHighlighted)];
                [[MusicTool sharedMusicTool] pause];
                self.isPlay = NO;
            }else {
                [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_nomal2"] forState:(UIControlStateNormal)];
                [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_click2"] forState:(UIControlStateHighlighted)];
                [[MusicTool sharedMusicTool] preparePlayWithMusic:self.tracksList.playPathAacv164];
                [[MusicTool sharedMusicTool] play];
                self.isPlay = YES;
            }
        });
    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(10, 10, self.bounds.size.height - 20, self.bounds.size.height - 20);
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width / 2;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.playButton.frame = CGRectMake(self.iconImageView.bounds.size.width / 2 - 10, self.iconImageView.bounds.size.height / 2 - 10, 20, 20);
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_nomal2"] forState:(UIControlStateNormal)];
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_click2"] forState:(UIControlStateHighlighted)];
    
    self.titleLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.bounds.size.width + 10, self.iconImageView.frame.origin.y, self.bounds.size.width - self.iconImageView.frame.origin.x - self.iconImageView.bounds.size.width - 10, self.bounds.size.height / 3);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.numberOfLines = 0;
    
    self.nickname.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height, self.titleLabel.bounds.size.width, self.iconImageView.bounds.size.width / 3);
    self.nickname.textColor = [UIColor grayColor];

    
    self.playCountsIV.frame = CGRectMake(self.titleLabel.frame.origin.x, self.nickname.frame.origin.y + self.nickname.bounds.size.height + 6, 10, 10);
    self.playCountsIV.image = [UIImage imageNamed:@"iconfont-bofang (3)"];
    
    self.playCountsLabel.frame = CGRectMake(self.titleLabel.frame.origin.x + 15, self.nickname.frame.origin.y + self.nickname.bounds.size.height, 80, self.iconImageView.bounds.size.width / 3);
    self.playCountsLabel.textColor = [UIColor grayColor];
    
    
    self.timeIV.frame = CGRectMake(self.playCountsLabel.frame.origin.x + self.playCountsLabel.bounds.size.width, self.playCountsIV.frame.origin.y, 10, 10);
    self.timeIV.image = [UIImage imageNamed:@"iconfont-shizhong"];
    self.timesLabel.frame = CGRectMake(self.timeIV.frame.origin.x + 15, self.playCountsLabel.frame.origin.y, 80, self.iconImageView.bounds.size.width / 3);
    self.timesLabel.textColor = [UIColor grayColor];
    
}

- (void)setTracksList:(TracksList *)tracksList {
    _tracksList = tracksList;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:tracksList.coverSmall]];
    
    
    self.titleLabel.text = tracksList.title;
    
    NSString *str = [NSString stringWithFormat:@"by %@", tracksList.nickname];
    self.nickname.text = str;
    
    self.playCountsLabel.text = [NSString stringWithFormat:@"%ld", tracksList.playtimes];
    
    NSInteger M = tracksList.duration / 60;
    NSInteger S = tracksList.duration % 60;
    NSString *timeStr = nil;
    if (S < 10 && M < 10) {
        timeStr = [NSString stringWithFormat:@"0%ld:0%ld", M, S];
    }else if (S < 10) {
        timeStr = [NSString stringWithFormat:@"%ld:0%ld", M, S];
    }else if (M < 10) {
        timeStr = [NSString stringWithFormat:@"0%ld:%ld", M, S];
    }else {
        timeStr = [NSString stringWithFormat:@"%ld:%ld", M, S];
    }
    self.timesLabel.text = timeStr;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
