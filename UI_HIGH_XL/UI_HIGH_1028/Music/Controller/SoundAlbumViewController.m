//
//  SoundAlbumViewController.m
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "SoundAlbumViewController.h"
#import "MJRefresh.h"
#import "NetHandler.h"
#import "MusicAlbumListCell.h"
#import "TracksList.h"
#import "Album.h"
#import "MusicListCell.h"
#import "MusicDetailViewController.h"
#import "UIColor+AddColor.h"
#import "MusicViewController.h"

@interface SoundAlbumViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *albumTableView;
@property (nonatomic, strong) UITableView *soundTableView;
@property (nonatomic, strong) NSMutableArray *albumArray;
@property (nonatomic, strong) NSMutableArray *soundArray;
@property (nonatomic, assign) BOOL isAlbum;
@property (nonatomic, assign) BOOL isSound;

@property (nonatomic, strong) UISegmentedControl *seg;

@end

@implementation SoundAlbumViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isAlbum) {
        return self.albumArray.count;
    }else {
        return self.soundArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell60";
    static NSString *reuseIdentifier1 = @"cell61";
    
    if (tableView == self.albumTableView) {
        MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[MusicListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
        }
        
        // Configure the cell...
        cell.album = self.albumArray[indexPath.row];
        
        return cell;
    }
    if (tableView == self.soundTableView) {
        MusicAlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
        if (cell == nil) {
            cell = [[MusicAlbumListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier1];
        }
        
        // Configure the cell...
        cell.tracksList = self.soundArray[indexPath.row];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.soundTableView) {
        return 100;
    }
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.albumTableView) {
        MusicDetailViewController *musicDVC = [[MusicDetailViewController alloc]init];
        musicDVC.albumId = [((Album *)self.albumArray[indexPath.row]).ID integerValue];
        [self.navigationController pushViewController:musicDVC animated:YES];
    }
    if (tableView == self.soundTableView) {
        MusicViewController *musicVC = [[MusicViewController alloc]init];
        musicVC.tracksArray = self.soundArray;
        musicVC.currentIndex = indexPath.row;
        [self presentViewController:musicVC animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.albumSting;
    
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"声音", @"专辑"]];
    [self.seg addTarget:self action:@selector(segAction:) forControlEvents:(UIControlEventValueChanged)];
    self.seg.selectedSegmentIndex = 0;
    self.seg.tintColor = [UIColor jinjuse];
    self.seg.frame = CGRectMake(0, 0, self.backgroundView.bounds.size.width, 30);
    [self.backgroundView addSubview:self.seg];
    
    self.albumTableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, 30, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height - 30)) style:(UITableViewStylePlain)];
    self.albumTableView.delegate = self;
    self.albumTableView.dataSource = self;
    self.albumTableView.tag = 1001;
    self.albumTableView.tableFooterView = [[UIView alloc]init];
    [self.backgroundView addSubview:self.albumTableView];
    
    self.soundTableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, 30, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height - 30)) style:(UITableViewStylePlain)];
    self.soundTableView.delegate = self;
    self.soundTableView.dataSource = self;
    self.soundTableView.tag = 1000;
    self.soundTableView.tableFooterView = [[UIView alloc]init];
    [self.backgroundView addSubview:self.soundTableView];
    
    self.albumArray = [NSMutableArray array];
    self.soundArray = [NSMutableArray array];
    
    self.isSound = YES;
    self.isAlbum = NO;
    [self setupRefresh];
    
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action:) name:@"播放图片刷新通知" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)action:(id)object {
    
    [self.soundTableView reloadData];
    
}

- (void)segAction:(UISegmentedControl *)seg {
    UIView *view = [self.backgroundView viewWithTag:(seg.selectedSegmentIndex + 1000)];
    if (view == self.soundTableView) {
        self.isAlbum = NO;
        self.isSound = YES;
    }
    if (view == self.albumTableView){
        self.isAlbum = YES;
        self.isSound = NO;
        if (self.albumArray.count == 0) {
            [self setupRefresh];
        }
    }
    [self.backgroundView bringSubviewToFront:view];
}

static int i = 1;
static int j = 1;
- (void)albumHandle {
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/tags/get_albums?device=iPhone&page=%d&sort=hot&tname=%@", i, self.albumSting] completion:^(NSData *data) {
        if (data != nil) {
            
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *tracksArr = [rootDic objectForKey:@"list"];
            for (NSDictionary *dic in tracksArr) {
                Album *album = [[Album alloc]init];
                [album setValuesForKeysWithDictionary:dic];
                [self.albumArray addObject:album];
            }
            [self.albumTableView reloadData];
            [self.albumTableView headerEndRefreshing];
            
        }
    }];
}

- (void)soundHandle {
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/tags/get_sounds?device=iPhone&page=%d&sort=hot&tname=%@", j, self.albumSting] completion:^(NSData *data) {
        NSLog(@"%d,%@",j,self.albumSting);
        if (data != nil) {
            
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *soundArray = [rootDic objectForKey:@"list"];
            for (NSDictionary *dic in soundArray) {
                TracksList *tracksList = [[TracksList alloc]init];
                [tracksList setValuesForKeysWithDictionary:dic];
                [self.soundArray addObject:tracksList];
            }
            [self.soundTableView reloadData];
            [self.soundTableView headerEndRefreshing];
            
        }
    }];
}

- (void)setupRefresh
{
    //    NSLog(@"进入了setupRefresh");
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    if (self.isAlbum) {
        [self.albumTableView addHeaderWithTarget:self action:@selector(headerRereshing3)];
        //进入刷新状态(一进入程序就下拉刷新)
        [self.albumTableView headerBeginRefreshing];
        
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.albumTableView addFooterWithTarget:self action:@selector(footerRereshing3)];
    }
    if (self.isSound) {
        [self.soundTableView addHeaderWithTarget:self action:@selector(headerRereshing3)];
        //进入刷新状态(一进入程序就下拉刷新)
        [self.soundTableView headerBeginRefreshing];
        
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.soundTableView addFooterWithTarget:self action:@selector(footerRereshing3)];
    }
}



#pragma mark 开始进入刷新状态
- (void)headerRereshing3
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    if (self.isAlbum) {
        [self albumHandle];
    }
    if (self.isSound) {
        [self soundHandle];
    }
    
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.isAlbum) {
            // 刷新表格
            [self.albumTableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.albumTableView headerEndRefreshing];
        }
        if (self.isSound) {
            // 刷新表格
            [self.soundTableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.soundTableView headerEndRefreshing];
        }
    });
}

//   进入加载状态
- (void)footerRereshing3
{
    //1. 拼接口等操作
    if (self.isAlbum) {
        i++;
        [self albumHandle];
    }
    if (self.isSound) {
        j++;
        [self soundHandle];
    }
    
    // 请求加载数据
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        if (self.isAlbum) {
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.albumTableView reloadData];
            [self.albumTableView footerEndRefreshing];
        }
        if (self.isSound) {
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.soundTableView reloadData];
            [self.soundTableView footerEndRefreshing];
        }
    });
}

- (void)dealloc {
    i = 1;
    j = 1;
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
