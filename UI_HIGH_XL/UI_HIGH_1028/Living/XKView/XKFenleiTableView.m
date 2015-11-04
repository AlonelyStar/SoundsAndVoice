//
//  XKFenleiTableView.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKFenleiTableView.h"
#import "XKRankingListModel.h"
#import "XKRankingListCell.h"
@interface XKFenleiTableView()<UITableViewDataSource>


@end

@implementation XKFenleiTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.rowHeight = kScreenWidth/5 + 30;
        
        
    }
    return self;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *LivingCell = @"LivingCell";
    XKRankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:LivingCell];
    if (cell == nil) {
        cell = [[XKRankingListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:LivingCell];
    }
    if (self.kindsArray != nil) {
        cell.model = self.kindsArray[indexPath.row];
    }
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.kindsArray != nil) {
        return self.kindsArray.count;
    }
    return 0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(void)setKindsArray:(NSArray *)kindsArray{
    _kindsArray = [NSArray arrayWithArray:kindsArray];
    if (kindsArray != nil) {
        
        [self reloadData];
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
