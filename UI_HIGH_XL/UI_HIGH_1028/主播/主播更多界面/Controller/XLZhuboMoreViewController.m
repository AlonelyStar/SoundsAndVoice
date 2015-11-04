//
//  XLZhuboMoreViewController.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLZhuboMoreViewController.h"
#import "XLTopView.h"
#import "MoreAnchorCell.h"
#import "XLAnchorDetailListViewController.h"
#import "NetHandler.h"
#import "XLMoreList.h"
#import "XLFirstList.h"
#import "XLAlbumType.h"
#import "XLTopCell.h"
#import "UIScrollView+MJRefresh.h"
#import "MusicViewController.h"
#import "XLPublishVoice.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface XLZhuboMoreViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *morelistArr;

@property (nonatomic,strong) NSString *category_nameStr;
@property (nonatomic,strong) NSString *conditionStr;

@property (nonatomic,assign) NSInteger page;

@property (nonatomic,strong) MoreAnchorCell *cell;

@property (nonatomic,strong) NSMutableArray *voiceListArr;
@property (nonatomic,assign) NSInteger listeningUid;

@end

@implementation XLZhuboMoreViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 64, ScreenWidth , ScreenHeight- 64 )) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[MoreAnchorCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.morelistArr = [NSMutableArray array];
    
    [self setupRefresh];
    [self.view bringSubviewToFront:(UIView *)self.picControl];
}


- (void)setSpecificList:(XLFirstList *)specificList {
    _specificList = specificList;
    if ([specificList.name isEqual:@"new"]) {
        self.category_nameStr = @"all";
        self.conditionStr = @"new";
    }
}



- (void)netHandle {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_user_list?category_name=%@&condition=%@&device=android&page=%ld&per_page=20",self.category_nameStr,self.conditionStr,self.page];
    
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        for (NSDictionary *dic in rootDic[@"list"]) {
            XLMoreList *morelist = [[XLMoreList alloc] init];
            [morelist setValuesForKeysWithDictionary:dic];
            [self.morelistArr addObject:morelist];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    self.cell.tableView.delegate = self;
    
    self.cell.arr = self.morelistArr;
    
    [self setupRefresh];
    
    __weak __block typeof(self)WeakSelf = self;
    self.cell.listeningBlock = ^(NSInteger uid) {
        WeakSelf.listeningUid = uid;
        [WeakSelf netHandleVoice];
    };

    
    return self.cell;
}

#pragma mark - 点击试听,进行发布的声音网络解析
- (void)netHandleVoice {
    self.voiceListArr = [NSMutableArray array];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/track/%ld/1/30?device=android",self.listeningUid];
    
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        for (NSDictionary *dic in rootDic[@"list"]) {
            XLPublishVoice *publishVoice = [[XLPublishVoice alloc] init];
            [publishVoice setValuesForKeysWithDictionary:dic];
            [self.voiceListArr addObject:publishVoice];
        }
        MusicViewController *musicVC = [[MusicViewController alloc] init];
        musicVC.tracksArray = self.voiceListArr;
        musicVC.currentIndex = 0;
        [self presentViewController:musicVC animated:YES completion:nil];
    }];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XLAnchorDetailListViewController *anchorDetailVC = [[XLAnchorDetailListViewController alloc] init];
    XLMoreList *moreList = self.morelistArr[indexPath.row];
    anchorDetailVC.uid = moreList.uid;
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
}


- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
   
    
    //进入刷新状态(一进入程序就下拉刷新)
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    [self.cell.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入刷新状态(一进入程序就下拉刷新)
    [self.cell.tableView headerBeginRefreshing];
    
    [self.cell.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}



#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    [self netHandle];
    
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.cell.tableView reloadData];
        [self.collectionView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
        });
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
        [self.cell.tableView headerEndRefreshing];
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
        self.cell.arr = self.morelistArr;
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        //        dispatch_async(dispatch_get_main_queue(), ^{
        
        //        });
        [self.cell.tableView footerEndRefreshing];
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
