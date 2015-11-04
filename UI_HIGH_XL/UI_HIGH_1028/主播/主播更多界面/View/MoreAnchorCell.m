//
//  MoreAnchorCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "MoreAnchorCell.h"
#import "XLOneAnchorCell.h"
#import "UIScrollView+MJRefresh.h"
#import "DropButton.h"
#import "XLMoreList.h"
@interface MoreAnchorCell() <UITableViewDelegate,UITableViewDataSource>

@end

@implementation MoreAnchorCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, frame.size.height)) style:(UITableViewStylePlain)];
        [self.contentView addSubview:self.tableView];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setArr:(NSArray *)arr {
    _arr = [NSMutableArray arrayWithArray:arr];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.cell == nil) {
        self.cell = [[XLOneAnchorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    self.cell.morelist = self.arr[indexPath.row];
    [self.cell.listeningBtn addTarget:self action:@selector(listeningBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    return self.cell;
}

- (void)listeningBtn:(DropButton *)button {
    XLOneAnchorCell *cell = (XLOneAnchorCell *)[[button superview] superview];
    NSInteger row = [self.tableView indexPathForCell:cell].row;
    XLMoreList *morelist = self.arr[row];
    self.listeningBlock(morelist.uid);
}

@end
