//
//  XKLivingSoundsTableView.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKLivingSoundsTableView.h"
#import "XKCateGoryCell.h"
#import "RecommedSoundsCell.h"
#import "XKRankingListCell.h"
#import "UIColor+AddColor.h"
#import "CateGoryView.h"
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface XKLivingSoundsTableView ()<UITableViewDataSource,UICollectionViewDelegate>




@end


@implementation XKLivingSoundsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor silverColor];
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.rowHeight =  kScreenWidth/4- 12.5+ 50;
        self.moreButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.moreButton addTarget:self action:@selector(turnMore:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return self;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *categoryCell = @"categoryCell";
        self.categoryCell = [tableView dequeueReusableCellWithIdentifier:categoryCell];
        if (self.categoryCell == nil) {
            self.categoryCell = [[XKCateGoryCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:categoryCell];
        
        }
        [self.categoryCell.localView.imageButton addTarget:self action:@selector(turnMore:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.categoryCell.CountryView.imageButton addTarget:self action:@selector(turnMore:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.categoryCell.shengView.imageButton addTarget:self action:@selector(turnMore:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.categoryCell.internetView.imageButton addTarget:self action:@selector(turnMore:) forControlEvents:(UIControlEventTouchUpInside)];
        self.categoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.categoryCell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundimage"]];
        return self.categoryCell;
    }else if (indexPath.section == 1){
        static NSString *recommedCell = @"recommedCell";
        self.recommedCell = [tableView dequeueReusableCellWithIdentifier:recommedCell];
        if (self.recommedCell == nil) {
            self.recommedCell = [[RecommedSoundsCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:recommedCell];
        }
        self.recommedCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.recommedArray != nil) {
            self.recommedCell.array  =self.recommedArray;
        }
        self.recommedCell.collectionView.delegate = self;
        return self.recommedCell;
    }else if (indexPath.section == 2){
        static NSString *rankingCell = @"rankingCell";
        self.rankingCell = [tableView dequeueReusableCellWithIdentifier:rankingCell];
        if (self.rankingCell == nil) {
            self.rankingCell = [[XKRankingListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:rankingCell];
            
        }
        if (self.rankingArray != nil) {
            self.rankingCell.model = self.rankingArray[indexPath.row];
        }
        return self.rankingCell;
        
        
    }
    
    return nil;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
            
        default:
            break;
    }
    return 0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (void)turnMore:(UIButton *)button{
    switch (button.tag) {
        case 1000:
            self.block(@"本地台,http://live.ximalaya.com/live-web/v1/getRadiosListByType?device=iPhone&pageNum=1&pageSize=30&provinceCode=310000&radioType=2");
            break;
            
        case 1001:
            self.block(@"国家台,http://live.ximalaya.com/live-web/v1/getRadiosListByType?device=iPhone&pageNum=1&pageSize=30&provinceId=%28null%29&radioType=1");
            break;
        case 1002:
            self.block(@"省市台,http://live.ximalaya.com/live-web/v1/getProvinceList?device=iPhone,http://live.ximalaya.com/live-web/v1/getRadiosListByType?device=iPhone&pageNum=1&pageSize=30&provinceCode=110000&radioType=2");
            break;
        case 1003:
            self.block(@"网络台,http://live.ximalaya.com/live-web/v1/getRadiosListByType?device=iPhone&pageNum=1&pageSize=30&provinceId=%28null%29&radioType=3,http://live.ximalaya.com/live-web/v1/getRadiosListByType?device=iPhone&pageNum=2&pageSize=30&provinceId=%28null%29&radioType=3");
            break;
            
        case 1004:
            self.block(@"电台排行榜,http://live.ximalaya.com/live-web/v1/getTopRadiosList?device=iPhone&radioNum=100");
            break;
            
        default:
            break;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.recommedArray != nil) {
        XKRankingListModel *model = self.recommedArray[indexPath.item];
        self.block1(model);
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
