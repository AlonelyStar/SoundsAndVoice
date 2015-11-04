//
//  XLTopView.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLTopView.h"

#import "XLTopCell.h"
#import "XLAlbumType.h"

@interface XLTopView() <UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, assign) BOOL isColor;


@end

@implementation XLTopView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
       
       
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width / 4;
        CGFloat itemHeight = frame.size.height;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 2;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collection = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height)) collectionViewLayout:layout];
        [self addSubview:self.collection];
        self.collection.showsHorizontalScrollIndicator = NO;
        self.collection.delegate = self;
        self.collection.dataSource = self;
        [self.collection registerClass:[XLTopCell class] forCellWithReuseIdentifier:@"cell"];
        self.collection.backgroundColor = [UIColor whiteColor];
        self.arr = [NSMutableArray array];
        self.collection.backgroundColor = [UIColor whiteColor];
        
        self.indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    }
    return self;
    
}

- (void)setArr:(NSMutableArray *)arr {
    _arr = [NSMutableArray arrayWithArray:arr];
    
    [self.collection reloadData];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    NSLog(@"%ld",indexPath.item);
    [self.collection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XLTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    XLAlbumType *list = self.arr[indexPath.item];
    cell.titleLabel.text = list.title;
    if (indexPath.item == self.indexPath.item) {
        cell.titleLabel.textColor = [UIColor orangeColor];
        cell.titleLabel.font = [UIFont systemFontOfSize:20];
        cell.bottomView.alpha = 1;
    }else{
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.titleLabel.font = [UIFont systemFontOfSize:16];
        cell.bottomView.alpha = 0;
    }
    
    return cell;
}



@end
