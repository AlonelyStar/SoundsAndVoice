//
//  MoreKindTopView.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/31.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "MoreKindTopView.h"
#import "AreaListModel.h"
#import "AreaNameCell.h"

@interface MoreKindTopView()<UICollectionViewDataSource>



@end
@implementation MoreKindTopView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kScreenWidth / 6, 30);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 50, 40) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.dataSource =self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[AreaNameCell class] forCellWithReuseIdentifier:@"areaCell"];
        
        self.changeView = [[UIImageView alloc]initWithFrame:CGRectMake(self.collectionView.frame.origin.x + self.collectionView.frame.size.width + 5, 10, 20, 20)];
        self.changeView.userInteractionEnabled = YES;
        self.changeView.image = [UIImage imageNamed:@"iconfont-xiangzuojiantou"];
        [self addSubview:self.changeView];
        
        self.indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
    }
    return self;
}


-(void)setAreaArray:(NSArray *)areaArray{
    _areaArray = [NSArray arrayWithArray:areaArray];
    if (_areaArray != nil) {
        [self.collectionView reloadData];
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AreaNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"areaCell" forIndexPath:indexPath];
    
    if (self.areaArray != nil) {
        cell.model = self.areaArray[indexPath.item];
    }
        if (indexPath == self.indexPath) {
            cell.label.backgroundColor = [UIColor orangeColor];
            cell.label.textColor = [UIColor whiteColor];
        }else{
            cell.label.backgroundColor = [UIColor whiteColor];
            cell.label.textColor = [UIColor blackColor];
        }  
    return cell;
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.areaArray != nil) {
        return self.areaArray.count;
        
    }
    return 0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
