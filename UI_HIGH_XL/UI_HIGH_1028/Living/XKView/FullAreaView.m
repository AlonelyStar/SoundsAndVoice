//
//  FullAreaView.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/31.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "FullAreaView.h"
#import "AreaNameCell.h"
@interface FullAreaView ()<UICollectionViewDataSource>



@end
@implementation FullAreaView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundimage"]];
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.9;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kScreenWidth/6, 30);
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, kScreenHeight / 3 * 2) collectionViewLayout:layout];
        [self.collectionView registerClass:[AreaNameCell class] forCellWithReuseIdentifier:@"AreaCell"];
//        self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundimage"]];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        self.collectionView.dataSource = self;
        
    }
    return self;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AreaNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AreaCell" forIndexPath:indexPath];
    if (self.areaArray != nil) {
        cell.model = self.areaArray[indexPath.item];
        
    }
    cell.label.backgroundColor = [UIColor lightGrayColor];
    if (self.indexPath == nil) {
        if (indexPath.item == 0) {
            cell.label.backgroundColor = [UIColor orangeColor];
            cell.label.textColor = [UIColor whiteColor];
        }
    }
    
    if (self.indexPath != nil) {
        if (indexPath == self.indexPath) {
            cell.label.backgroundColor = [UIColor orangeColor];
            cell.label.textColor = [UIColor whiteColor];
            
        }else{
            cell.label.backgroundColor = [UIColor lightGrayColor];
            cell.label.textColor = [UIColor blackColor];
        }
    }
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.areaArray != nil) {
        return self.areaArray.count;
    }
    return 0;
}


-(void)setAreaArray:(NSArray *)areaArray{
    _areaArray = [NSArray arrayWithArray:areaArray];
    if (areaArray != nil) {
        [self.collectionView reloadData];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
