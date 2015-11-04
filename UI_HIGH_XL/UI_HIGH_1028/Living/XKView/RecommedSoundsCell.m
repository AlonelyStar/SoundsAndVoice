//
//  RecommedSoundsCell.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "RecommedSoundsCell.h"
#import "XKImageCell.h"
#import "XKRankingListModel.h"
#import "UIImageView+WebCache.h"

@interface RecommedSoundsCell()<UICollectionViewDataSource>

@end

@implementation RecommedSoundsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 20)];
        [self.contentView addSubview:self.topView];
        
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
        self.image.image = [UIImage imageNamed:@"sanjiao"];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.image.frame.origin.x + self.image.bounds.size.width + 5, 0, 100, 20)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.text = @"推荐电台";
        [self.topView addSubview:self.image];
        [self.topView addSubview:self.titleLabel];
        
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.itemSize = CGSizeMake(kScreenWidth /3 - 60/3, kScreenWidth / 3 + 10);
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.topView.frame.origin.y + self.topView.bounds.size.height + 10, kScreenWidth, kScreenWidth/3 + 30) collectionViewLayout:layout];
        
        [self.collectionView registerClass:[XKImageCell class] forCellWithReuseIdentifier:@"XKImageCell"];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        self.collectionView.dataSource = self;
        [self.contentView addSubview:self.collectionView];
        
        
        
    }
    return self;
}

-(void)setArray:(NSArray *)array{
    _array = [NSArray arrayWithArray:array];
    if (array != nil) {
        [self.collectionView reloadData];
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XKImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XKImageCell" forIndexPath:indexPath];
    if (self.array != nil) {
        XKRankingListModel *model = self.array[indexPath.item];
        cell.model = model;
    }
    
    
    return cell;
    
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}




@end
