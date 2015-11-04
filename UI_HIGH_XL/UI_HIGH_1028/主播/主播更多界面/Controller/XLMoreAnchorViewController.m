//
//  XLMoreAnchorViewController.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/28.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLMoreAnchorViewController.h"
#import "XLTopView.h"
#import "MoreAnchorCell.h"
#import "XLAnchorDetailListViewController.h"
#import "NetHandler.h"
#import "XLMoreList.h"
#import "XLFirstList.h"
#import "XLAlbumType.h"
#import "XLTopCell.h"
#import "UIScrollView+MJRefresh.h"
#import "XLOneAnchorCell.h"
#import "DropButton.h"
#import "XLPublishVoice.h"
#import "MusicViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface XLMoreAnchorViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate>


@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *morelistArr;
@property (nonatomic,strong) XLTopView *topV;
@property (nonatomic,strong) NSString *category_nameStr;
@property (nonatomic,strong) NSString *conditionStr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) MoreAnchorCell *cell;

@property (nonatomic,assign) NSInteger indexTag;

@property (nonatomic,assign) BOOL isNewHotClick;
@property (nonatomic,assign) NSInteger listeningUid;
@property (nonatomic,strong) NSMutableArray *voiceListArr;


@end

@implementation XLMoreAnchorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.page = 1;
    
    UIButton *newHotBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    newHotBtn.frame = CGRectMake(self.topView.bounds.size.width / 2 - 30, self.topView.bounds.size.height - 40, 60, 40);
    [newHotBtn setTitle:@"最热" forState:(UIControlStateNormal)];
    [newHotBtn addTarget:self action:@selector(newHotBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    newHotBtn.tintColor = [UIColor blackColor];
    newHotBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.topView addSubview:newHotBtn];
    
    self.topV = [[XLTopView alloc] initWithFrame:(CGRectMake(0, 64, ScreenWidth, 30))];
    [self getIndexPathAndSetContentOff];
    self.topV.arr = [self.typeArr mutableCopy];
    self.topV.collection.delegate = self;
    
    [self.view addSubview:self.topV];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64 - 30);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, 30 + 64, ScreenWidth , ScreenHeight- 64 - 30)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
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

- (void)newHotBtn:(UIButton *)button {
    self.isNewHotClick = !self.isNewHotClick;
    if (self.isNewHotClick) {
        [button setTitle:@"最新" forState:(UIControlStateNormal)];
        self.conditionStr = @"new";
        [self setupRefresh];
    } else {
        [button setTitle:@"最热" forState:(UIControlStateNormal)];
        self.conditionStr = @"hot";
        [self setupRefresh];
    }
}

- (void)getIndexPathAndSetContentOff {
    for (NSInteger i = 0; i < self.typeArr.count; i++) {
        XLAlbumType *type = self.typeArr[i];
        if ([self.specificList.name isEqual:type.name]) {
            self.indexTag = i;
            self.topV.indexPath = [NSIndexPath indexPathForItem:self.indexTag inSection:0];
            [self.collectionView setContentOffset:(CGPointMake([UIScreen mainScreen].bounds.size.width * self.indexTag, 0))];
            [self.topV.collection setContentOffset:(CGPointMake([UIScreen mainScreen].bounds.size.width / 4 * self.indexTag, 0))];
        }
    }
}



- (void)setSpecificList:(XLFirstList *)specificList {
    
    _specificList = specificList;
    if ([specificList.name isEqual:@"new"]) {
        self.category_nameStr = @"all";
        self.conditionStr = @"new";
    }else {
        self.category_nameStr = specificList.name;
        self.conditionStr = @"hot";
    }
}



- (void)netHandle {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_user_list?category_name=%@&condition=%@&device=android&page=%ld&per_page=20",self.category_nameStr,self.conditionStr,self.page];
    NSLog(@"%@",urlStr);
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
    return self.typeArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 150;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    self.cell.tableView.delegate = self;
    

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

#pragma mark - 大collection滑动的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   
    NSInteger tag = self.collectionView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    XLAlbumType *albumType = self.typeArr[tag];
    self.category_nameStr = albumType.name;
    
    
    self.topV.indexPath = [NSIndexPath indexPathForItem:tag inSection:0];
    
    [self.topV.collection setContentOffset:(CGPointMake([UIScreen mainScreen].bounds.size.width / 4 * tag, 0))];
    self.morelistArr = [NSMutableArray array];
    [self scroll];
    
}

- (void)scroll {
    [self netHandle];
}

#pragma mark - 点击topCollection事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.topV.collection) {
        XLAlbumType *albumType = self.typeArr[indexPath.item];
        self.category_nameStr = albumType.name;
        
        self.topV.indexPath = indexPath;
        
        [self.collectionView setContentOffset:(CGPointMake([UIScreen mainScreen].bounds.size.width * indexPath.item, 0))];
        [self.topV.collection setContentOffset:(CGPointMake([UIScreen mainScreen].bounds.size.width / 4 * indexPath.item, 0))];
        
    }
    
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
    self.morelistArr = [NSMutableArray array];
    [self netHandle];
    
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        self.cell.arr = self.morelistArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.cell.tableView reloadData];
            [self.collectionView reloadData];
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
        // 请求加载数据
        [self netHandle];
    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        self.cell.arr = self.morelistArr;
        [self.cell.tableView reloadData];

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



@end
