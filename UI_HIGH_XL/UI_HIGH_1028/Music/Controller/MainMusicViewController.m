//
//  MainMusicViewController.m
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MainMusicViewController.h"
#import "HeaderCell.h"
#import "MJRefresh.h"
#import "NetHandler.h"
#import "NewsTopCell.h"
#import "MusicImageList.h"
#import "MusicTitleList.h"
#import "ProgramSelection.h"
#import "CategoryMusic.h"
#import "MusicListCell.h"
#import "HeaderView.h"
#import "MusicDetailListViewController.h"
#import "MusicDetailViewController.h"
#import "UIColor+AddColor.h"
#import "MusicViewController.h"

@interface MainMusicViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UICollectionView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) NSMutableArray *scrollImageUrlArray;
@property (nonatomic, strong) NSMutableArray *scrollArray;
@property (nonatomic, strong) NSMutableArray *listTitleArray;
@property (nonatomic, strong) NSMutableArray *listDetailArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSString *currentCategory;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MainMusicViewController

- (void)dealloc {
    page2 = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.titleLabel.text = @"推荐音乐";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width / 5, 30);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.headerView = [[UICollectionView alloc]initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, 30)) collectionViewLayout:flowLayout];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.delegate = self;
    self.headerView.dataSource = self;
    [self.headerView registerClass:[HeaderCell class] forCellWithReuseIdentifier:@"headerCell"];
    self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.backgroundView addSubview:self.headerView];
    
    self.tableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, self.headerView.bounds.size.height, self.view.bounds.size.width, self.backgroundView.bounds.size.height - self.headerView.bounds.size.height)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.backgroundView addSubview:self.tableView];
    [self setupRefresh];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:(self.tableView.frame) style:(UITableViewStylePlain)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.tableFooterView = [[UIView alloc]init];

    // Do any additional setup after loading the view.
}

- (void)setupRefresh
{
    //    NSLog(@"进入了setupRefresh");
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    __weak __block typeof(self)WeakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        //1. 在这调用请求网络数据方法（刷新数据）
        
        [WeakSelf handle];
        //2. 2秒后刷新表格UI
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.listTitleArray.count == 0) {
                UIAlertView *alertV  = [[UIAlertView alloc]initWithTitle:nil message:@"网络慢~" delegate:WeakSelf cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [WeakSelf performSelector:@selector(dismisAlertV:) withObject:alertV afterDelay:1];
                [alertV show];
            }
            // 刷新表格
            [WeakSelf.tableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [WeakSelf.tableView headerEndRefreshing];
        });
    }];
    //进入刷新状态(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
}

- (void)setupRefresh2;
{
    //    NSLog(@"进入了setupRefresh");
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
//    [self.tableView2 addHeaderWithTarget:self action:@selector(headerRereshing2)];
    __weak __block typeof(self)WeakSelf = self;
    [self.tableView2 addHeaderWithCallback:^{
        //1. 在这调用请求网络数据方法（刷新数据）
        
        [WeakSelf handle2];
        //2. 2秒后刷新表格UI
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.categoryArray.count == 0) {
                UIAlertView *alertV  = [[UIAlertView alloc]initWithTitle:nil message:@"网络慢~" delegate:WeakSelf cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [WeakSelf performSelector:@selector(dismisAlertV:) withObject:alertV afterDelay:1];
                [alertV show];
            }
            // 刷新表格
            [WeakSelf.tableView2 reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [WeakSelf.tableView2 headerEndRefreshing];
        });
    }];
    
    
    //进入刷新状态(一进入程序就下拉刷新)
    [self.tableView2 headerBeginRefreshing];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView2 addFooterWithTarget:self action:@selector(footerRereshing2)];
}



#pragma mark 开始进入刷新状态
- (void)headerRereshing2
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    
    [self handle2];
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView2 reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView2 headerEndRefreshing];
    });
}

//   进入加载状态
- (void)footerRereshing2
{
    //1. 拼接口等操作
    page2 += 1;
    
    // 请求加载数据
    [self handle2];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView2 reloadData];
        [self.tableView2 footerEndRefreshing];
    });
}

- (void)dismisAlertV:(UIAlertView *)alertV {
    [alertV dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)handle {
    [NetHandler getDataWithUrl:@"http://mobile.ximalaya.com/mobile/discovery/v2/category/recommends?categoryId=2&contentType=album&device=iPhone&scale=2&version=4.3.20" completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *tagsDic = [rootDic objectForKey:@"tags"];
            NSArray *tagsArray = [tagsDic objectForKey:@"list"];
            self.listTitleArray = [NSMutableArray arrayWithObject:@"推荐"];
            for (NSDictionary *dic in tagsArray) {
                MusicTitleList *titleList = [[MusicTitleList alloc]init];
                [titleList setValuesForKeysWithDictionary:dic];
                [self.listTitleArray addObject:titleList.tname];
            }
            
            self.scrollImageUrlArray = [NSMutableArray array];
            self.scrollArray = [NSMutableArray array];
            NSDictionary *focusDictionary = [rootDic objectForKey:@"focusImages"];
            NSArray *focusArray = [focusDictionary objectForKey:@"list"];
            for (NSDictionary *dic in focusArray) {
                MusicImageList *imageList = [[MusicImageList alloc]init];
                [imageList setValuesForKeysWithDictionary:dic];
                [self.scrollArray addObject:imageList];
                [self.scrollImageUrlArray addObject:imageList.pic];
            }
            
            NSDictionary *categoryDic = [rootDic objectForKey:@"categoryContents"];
            NSArray *categoryArray = [categoryDic objectForKey:@"list"];
            self.listDetailArray = [NSMutableArray array];
            for (NSDictionary *dic in categoryArray) {
                CategoryMusic *categoryMusic = [[CategoryMusic alloc]init];
                [categoryMusic setValuesForKeysWithDictionary:dic];
                [self.listDetailArray addObject:categoryMusic];
            }
            
            [self.tableView reloadData];
            [self.headerView reloadData];
            [self.tableView headerEndRefreshing];
        }
    }];
}

static int page2 = 1;
- (void)handle2 {
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=iPhone&pageId=%d&pageSize=20&position=1&status=0&tagName=%@&title=精选歌单", page2, self.currentCategory] completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (self.categoryArray.count == 0) {
                self.categoryArray = [NSMutableArray array];
            }else if (page2 == 1) {
                [self.categoryArray removeAllObjects];
            }
            NSArray *array = [rootDic objectForKey:@"list"];
            for (NSDictionary *dic in array) {
                ProgramSelection *programS = [[ProgramSelection alloc]init];
                [programS setValuesForKeysWithDictionary:dic];
                [self.categoryArray addObject:programS];
            }
            [self.tableView2 reloadData];
            [self.tableView2 headerEndRefreshing];
        }
    }];
}




#pragma mark-- collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listTitleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.listTitleArray[indexPath.item];
    if (self.currentIndexPath.item == indexPath.item) {
        cell.titleLabel.textColor = [UIColor jinjuse];
        cell.maskView.alpha = 1;
    }else {
        cell.titleLabel.textColor = [UIColor grayColor];
        cell.maskView.alpha = 0;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndexPath = indexPath;
    CGFloat width =  (indexPath.item * self.view.bounds.size.width / 5) - (self.view.bounds.size.width * 2 / 5);
    if (indexPath.item < 3) {
        width = 0;
    }
    if (indexPath.item > self.listTitleArray.count - 3) {
        width = ((indexPath.item + 1) * self.view.bounds.size.width / 5) - self.view.bounds.size.width;
    }
    CGPoint point = CGPointMake(width, 0);
    [collectionView setContentOffset:point animated:YES];
    page2 = 1;
    if (indexPath.item == 0) {
        if ([self.backgroundView.subviews containsObject:self.tableView2]) {
            [self.tableView2 removeFromSuperview];
            [self.backgroundView addSubview:self.tableView];
        }
        self.titleLabel.text = @"推荐音乐";
        [self.tableView reloadData];
    }else {
        if ([self.backgroundView.subviews containsObject:self.tableView]) {
            [self.tableView removeFromSuperview];
            [self.backgroundView addSubview:self.tableView2];
        }
        self.currentCategory = self.listTitleArray[indexPath.item];
        self.titleLabel.text = self.currentCategory;
        [self setupRefresh2];
    }
    [self.headerView reloadData];
    NSLog(@"%@", indexPath);
}

#pragma mark-- tableView数据源方法和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView2) {
        return self.categoryArray.count;
    }else {
        if (section == 0) {
            return 1;
        }else {
            return 3;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView2) {
        
        MusicDetailViewController *musicDVC = [[MusicDetailViewController alloc]init];
        musicDVC.albumId = ((ProgramSelection *)self.categoryArray[indexPath.row]).albumId;
        [self.navigationController pushViewController:musicDVC animated:YES];
        
    }else {
        MusicDetailViewController *musicDVC = [[MusicDetailViewController alloc]init];
        if (indexPath.section != 0) {
            musicDVC.albumId = ((ProgramSelection *)((CategoryMusic *)self.listDetailArray[indexPath.section]).list[indexPath.row]).albumId;
        }
        [self.navigationController pushViewController:musicDVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        HeaderView *headerView = [[HeaderView alloc]initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, 20))];
        [headerView.moreButton addTarget:self action:@selector(moreAtion:) forControlEvents:(UIControlEventTouchUpInside)];
        headerView.moreButton.tag = 100 + section;
        headerView.title = ((CategoryMusic *)self.listDetailArray[section]).title;
        return headerView;
    }
    return nil;
}
- (void)moreAtion:(UIButton *)button {
    
    MusicDetailListViewController *musicDetailListVC = [[MusicDetailListViewController alloc]init];
    musicDetailListVC.tagName = ((CategoryMusic *)self.listDetailArray[button.tag - 100]).tagName;
    [self.navigationController pushViewController:musicDetailListVC animated:YES];
    
    NSLog(@"111");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return self.listDetailArray.count;
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (section == 0) {
            return nil;
        }else {
            return ((CategoryMusic *)self.listDetailArray[section]).title;
        }
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell1";
    static NSString *reuseIdentifier2 = @"cell2";
    static NSString *reuseIdentifier3 = @"cell3";
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            NewsTopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                cell = [[NewsTopCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
            }
            if (cell.headerlineArray.count == 0) {
                cell.headerlineArray = self.scrollImageUrlArray;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            
            MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
            if (cell == nil) {
                cell = [[MusicListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier2];
            }
            cell.programSelection = ((CategoryMusic *)self.listDetailArray[indexPath.section]).list[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else {
        MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier3];
        if (cell == nil) {
            cell = [[MusicListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier3];
        }
        cell.programSelection = self.categoryArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            return 180;
        }else {
            return 100;
        }
    }
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
