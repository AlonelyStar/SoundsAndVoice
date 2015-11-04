//
//  XLAlbumTypeView.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAlbumTypeView.h"
#import "XLTopCell.h"

@interface XLAlbumTypeView() <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

@end
@implementation XLAlbumTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.collection = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)) collectionViewLayout:self.flowLayout];
        self.collection.pagingEnabled = NO;
        self.collection.bounces = NO;
        self.collection.showsHorizontalScrollIndicator = NO;
        
        self.typeArr = [NSMutableArray array] ;
        
        [self.collection registerClass:[XLTopCell class] forCellWithReuseIdentifier:@"cell"];
        self.collection.delegate = self;
        self.collection.dataSource = self;
        [self addSubview:self.collection];
        self.collection.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setTypeArr:(NSMutableArray *)typeArr {
    _typeArr = typeArr;
    
    NSInteger scale = 0;
    if (self.typeArr.count < 4 && self.typeArr.count > 0) {
        scale = self.typeArr.count;
    } else {
        scale = 4;
    }
    self.flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / scale, 40);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 1;
    
    [self.collection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.typeArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XLTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = self.typeArr[indexPath.item];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mohu2"]];
    cell.titleLabel.textColor = [UIColor whiteColor];
    return cell;
}
@end
