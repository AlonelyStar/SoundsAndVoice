//
//  MusicListCell.m
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MusicListCell.h"
#import "UIImageView+WebCache.h"

@interface MusicListCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UILabel *playsCountsLabel;
@property (nonatomic, strong) UILabel *tracksCountsLabel;

@property (nonatomic, strong) UIImageView *nextImageView;

@end

@implementation MusicListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
        
        self.introLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.introLabel];
        
        self.playsCountsLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.playsCountsLabel];
        
        self.tracksCountsLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.tracksCountsLabel];
        
        self.nextImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.nextImageView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(10, 10, self.bounds.size.height - 20, self.bounds.size.height - 20);
    self.iconImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iconfont-zhuantitu"]];
    
    self.titleLabel.frame = CGRectMake(self.iconImageView.frame.origin.x + self.iconImageView.bounds.size.width + 10, self.iconImageView.frame.origin.y, self.bounds.size.width - self.iconImageView.frame.origin.x - self.iconImageView.bounds.size.width - 20, self.iconImageView.bounds.size.height / 3);
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    
    self.introLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.bounds.size.height, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
    self.introLabel.font = [UIFont systemFontOfSize:15];
    self.introLabel.textColor = [UIColor grayColor];
    
    self.playsCountsLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.introLabel.frame.origin.y + self.introLabel.bounds.size.height, 80, self.titleLabel.bounds.size.height);
    self.playsCountsLabel.font = [UIFont systemFontOfSize:15];
    self.playsCountsLabel.textColor = [UIColor grayColor];
    
    self.tracksCountsLabel.frame = CGRectMake(self.playsCountsLabel.frame.origin.x + 80, self.playsCountsLabel.frame.origin.y, 80, self.titleLabel.bounds.size.height);
    self.tracksCountsLabel.font = [UIFont systemFontOfSize:15];
    self.tracksCountsLabel.textColor = [UIColor grayColor];
    
    self.nextImageView.frame = CGRectMake(self.introLabel.frame.origin.x + self.introLabel.bounds.size.width - 15, self.introLabel.frame.origin.y, 20, 20);
}

- (void)setProgramSelection:(ProgramSelection *)programSelection {
    _programSelection = programSelection;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:programSelection.albumCoverUrl290]];
    self.titleLabel.text = programSelection.title;
    self.introLabel.text = programSelection.intro;
    
    NSString *str = [NSString stringWithFormat:@"播:%ld", programSelection.playsCounts];
    self.playsCountsLabel.text = str;
    
    NSString *str2 = [NSString stringWithFormat:@"共%ld集", programSelection.tracksCounts];
    self.tracksCountsLabel.text = str2;
    
    self.nextImageView.image = [UIImage imageNamed:@"iconfont-fanhuiyou"];
}

- (void)setAlbum:(Album *)album {
    _album = album;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:album.albumCoverUrl290]];
    self.titleLabel.text = album.title;
    self.introLabel.text = album.intro;
    
    NSString *str = [NSString stringWithFormat:@"播:%ld", album.playsCounts];
    self.playsCountsLabel.text = str;
    
    NSString *str2 = [NSString stringWithFormat:@"共%ld集", album.trackCounts];
    self.tracksCountsLabel.text = str2;
    
    self.nextImageView.image = [UIImage imageNamed:@"iconfont-fanhuiyou"];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
