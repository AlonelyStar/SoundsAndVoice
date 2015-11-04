//
//  XLViewController.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLViewController.h"
#import "XLTopView.h"
#import "XLAnchorCell.h"
#import "DropButton.h"
#import "XLMoreAnchorViewController.h"
#import "NetHandler.h"

#import "XLFirstList.h"
#import "XLFirstListList.h"
#import "XLAlbumType.h"
#import "XLBottomButton.h"
#import "XLAnchorDetailListViewController.h"
#import "XLImageLabelView.h"
#import "XLZhuboMoreViewController.h"
#import "UIScrollView+MJRefresh.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface XLViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *listArr;
@property (nonatomic,strong) NSMutableArray *recommendZBArr;
@property (nonatomic,strong) NSMutableArray *typeArr;
@property (nonatomic,assign) NSInteger page;

@end

@implementation XLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden= YES;
    self.title = @"主播";
    
//    XLTabBarView *tabBarView = [[XLTabBarView alloc] initWithFrame:(CGRectMake(0, ScreenHeight - 54, [UIScreen mainScreen].bounds.size.width, 54))];
//    [self.view addSubview:tabBarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    
//    [self.view bringSubviewToFront:tabBarView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupRefresh];
    
    self.page = 1;
    self.typeArr = [NSMutableArray array];
    self.listArr = [NSMutableArray array];
    
    [self.view bringSubviewToFront:(UIView *)self.picControl];
}

- (void)netHandle {
    self.recommendZBArr = [NSMutableArray array];
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_user_index?device=android&page=%ld",self.page];
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        if (data != nil) {            
            NSMutableDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *listRootArr = [rootDic valueForKey:@"list"];
            
            for (NSDictionary *dic in listRootArr) {
                XLFirstList *list = [[XLFirstList alloc] init];
                [list setValuesForKeysWithDictionary:dic];
                [self.listArr addObject:list];
                XLAlbumType *type = [[XLAlbumType alloc] init];
                [type setValuesForKeysWithDictionary:dic];
                [self.typeArr addObject:type];
            }
            
            NSMutableDictionary *commendDic = [rootDic valueForKey:@"recommendBozhu"];
            
            for (NSDictionary *dic in commendDic[@"list"]) {
                XLFirstListList *listlist = [[XLFirstListList alloc] init];
                [listlist setValuesForKeysWithDictionary:dic];
                [self.recommendZBArr addObject:listlist];
            }
        }
        
    }];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenHeight / 3 - 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    XLAnchorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[XLAnchorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
   
    if (indexPath.row == 1) {

        cell.listlistArr = self.recommendZBArr;
        cell.imglabView.titleLabel.text = @"新晋主播";

    } else {

    if (self.listArr.count != 0) {
        XLFirstList *list = [[XLFirstList alloc] init];
        if (indexPath.row == 0) {
            list = self.listArr[0];
        } else {
            list = self.listArr[indexPath.row - 1];
        }
        cell.listArr = list;

        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in list.list) {
            XLFirstListList *listlist = [[XLFirstListList alloc] init];
            [listlist setValuesForKeysWithDictionary:dic];
            [arr addObject:listlist];
        }
        cell.listlistArr = arr;
    }
    }
    [cell.moreBtn addTarget:self action:@selector(returnToMoreAnchorControView:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.leftBtn.imageButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.centerBtn.imageButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.rightBtn.imageButton addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
#pragma mark - 头像按钮点击
- (void)buttonAction:(XLBottomButton *)button {
    
   
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)([[button superview] superview].superview)];

    NSInteger tag = button.tag - 1000;
    XLFirstListList *listlist = [[XLFirstListList alloc] init];
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row == 1) {
        listlist = self.recommendZBArr[tag];
    } else {
        XLFirstList *list = [[XLFirstList alloc] init];
        if (indexPath.row == 0) {
            list = self.listArr[0];
        } else {
            list = self.listArr[indexPath.row - 1];
        }
        [listlist setValuesForKeysWithDictionary:list.list[tag]];
    }
    XLAnchorDetailListViewController *anchorDetailListVC = [[XLAnchorDetailListViewController alloc] init];
    anchorDetailListVC.uid = listlist.uid;
    [self.navigationController pushViewController:anchorDetailListVC animated:YES];
}

#pragma mark - 更多按钮点击
- (void)returnToMoreAnchorControView:(DropButton *)button {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)([[button superview] superview])];
    XLFirstList *list = [[XLFirstList alloc] init];
    if (indexPath.row == 1) {
        XLZhuboMoreViewController *zhuboMoreVC = [[XLZhuboMoreViewController alloc] init];
        list.name = @"new";
        list.title = @"新晋主播";
        zhuboMoreVC.specificList = list;
        [self.navigationController pushViewController:zhuboMoreVC animated:YES];
    } else {
        XLMoreAnchorViewController *moreAnchorVC = [[XLMoreAnchorViewController alloc] init];
        if (self.listArr.count > 0) {
            
            if (indexPath.row > 1) {
                list = self.listArr[indexPath.row - 1];
            } else {
                list = self.listArr[indexPath.row];
            }
            moreAnchorVC.specificList = list;
            moreAnchorVC.typeArr = self.typeArr;
            [self.navigationController pushViewController:moreAnchorVC animated:YES];
            
        }
    }
}


- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
  
    //进入刷新状态(一进入程序就下拉刷新)
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入刷新状态(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}



#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    [self netHandle];
    
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

//   进入加载状态
- (void)footerRereshing
{
    //1. 拼接口等操作
    if (self.page < 30) {
        self.page++;
    }
    
    // 请求加载数据
    [self netHandle];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        //        dispatch_async(dispatch_get_main_queue(), ^{
        
        //        });
        [self.tableView footerEndRefreshing];
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
