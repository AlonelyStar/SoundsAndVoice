//
//  MusicDetailTopView.m
//  Music
//
//  Created by zhupeng on 15/10/29.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MusicDetailTopView.h"
#import "UIImageView+WebCache.h"
#import "TagsCollectionViewCell.h"

@interface MusicDetailTopView ()

@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIImageView *maskView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *kingImageView;
@property (nonatomic, strong) UILabel *kindLabel;

@end

@implementation MusicDetailTopView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(0, -30, self.bounds.size.width, self.bounds.size.width);
    
    self.maskView.frame = CGRectMake(0, -30, self.bounds.size.width, self.bounds.size.width);
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.7;
    
    self.iconImageView.frame = CGRectMake(20, self.bounds.size.height / 3 + 20, self.bounds.size.height / 3, self.bounds.size.height / 3);

    self.kingImageView.frame = CGRectMake(20 + self.iconImageView.bounds.size.width + 10, self.iconImageView.frame.origin.y, self.iconImageView.bounds.size.width / 3, self.iconImageView.bounds.size.width / 3);
    self.kingImageView.layer.cornerRadius = self.iconImageView.bounds.size.width / 6;
    self.kingImageView.layer.masksToBounds = YES;

    self.kindLabel.frame = CGRectMake(self.kingImageView.frame.origin.x + self.kingImageView.bounds.size.width, self.kingImageView.frame.origin.y, self.bounds.size.width - self.kingImageView.frame.origin.x - self.kingImageView.bounds.size.width - 20, self.iconImageView.bounds.size.width / 3);
    self.kindLabel.textColor  = [UIColor whiteColor];
    self.kindLabel.font = [UIFont systemFontOfSize:18];
    
    self.desLabel.frame = CGRectMake(self.kingImageView.frame.origin.x, self.kindLabel.frame.origin.y + self.kindLabel.bounds.size.height, self.kindLabel.bounds.size.width + self.kingImageView.bounds.size.width, self.kindLabel.bounds.size.height);
    self.desLabel.font = [UIFont systemFontOfSize:15];
    self.desLabel.textColor = [UIColor grayColor];
    
    self.nextImageView.frame = CGRectMake(self.desLabel.frame.origin.x + self.desLabel.bounds.size.width - 10, self.desLabel.frame.origin.y, 20, 20);
    self.nextImageView.image = [UIImage imageNamed:@"iconfont-fanhuiyou"];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backView = [[UIImageView alloc]init];
        [self addSubview:self.backView];
        
        self.maskView = [[UIImageView alloc]init];
        [self addSubview:self.maskView];
        
        self.iconImageView = [[UIImageView alloc]init];
        [self addSubview:self.iconImageView];
        
        self.kingImageView = [[UIImageView alloc]init];
        [self addSubview:self.kingImageView];
        
        self.kindLabel = [[UILabel alloc]init];
        [self addSubview:self.kindLabel];
        
        self.desLabel = [[UILabel alloc]init];
        self.desLabel.userInteractionEnabled = YES;
        [self addSubview:self.desLabel];
        
        self.nextImageView = [[UIImageView alloc]init];
        self.nextImageView.userInteractionEnabled = YES;
        [self addSubview:self.nextImageView];
        
        
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(self.bounds.size.width / 3, 40);
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[TagsCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell1"];
        [self addSubview:self.collectionView];
        
        
    }
    return self;
}


- (void)setAlbumDetail:(AlbumDetail *)albumDetail {
    _albumDetail = albumDetail;
    [self.backView sd_setImageWithURL:[NSURL URLWithString:albumDetail.coverOrigin]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:albumDetail.coverMiddle] placeholderImage:[UIImage imageNamed:@"iconfont-zhuantitu"]];
    
    [self.kingImageView sd_setImageWithURL:[NSURL URLWithString:albumDetail.avatarPath] placeholderImage:[UIImage imageNamed:@"iconfont-zhuantitu"]];
    
    self.kindLabel.text = albumDetail.nickname;
    self.desLabel.text = albumDetail.intro;
//    self.tagsArr = [self.albumDetail.tags componentsSeparatedByString:@","];
    [self.collectionView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
