//
//  XLLookAllAlbumViewController.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLLookAllAlbumViewController.h"
#import "XLAlbumCell.h"
#import "NetHandler.h"
#import "XLPublishAlbum.h"
#import "UIScrollView+MJRefresh.h"
#import "XLAlbumDetailViewController.h"

@interface XLLookAllAlbumViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *allAlbumArr;
@end

@implementation XLLookAllAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.view bringSubviewToFront:self.button];
    [self setupRefresh];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view bringSubviewToFront:(UIView *)self.picControl];
}

- (void)netHandleAllAlbum {
    self.allAlbumArr = [NSMutableArray array];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/%ld/1/30?device=android",self.uid];
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        for (NSDictionary *dic in rootDic[@"list"]) {
            XLPublishAlbum *allAlbum = [[XLPublishAlbum alloc] init];
            [allAlbum setValuesForKeysWithDictionary:dic];
            [self.allAlbumArr addObject:allAlbum];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allAlbumArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier1 = @"albumCell";
    XLAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XLAlbumCell" owner:nil options:nil] lastObject];
    }
    cell.pulishAlbum = self.allAlbumArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XLAlbumDetailViewController *albumDVC = [[XLAlbumDetailViewController alloc] init];
    XLPublishAlbum *album = self.allAlbumArr[indexPath.row];
    albumDVC.albumId = album.albumId;
    albumDVC.uid = album.uid;
    [self.navigationController pushViewController:albumDVC animated:YES];
}


- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
    
    //进入刷新状态(一进入程序就下拉刷新)
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入刷新状态(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
}



#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    [self netHandleAllAlbum];
    
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
        [self.tableView headerEndRefreshing];
    });
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
