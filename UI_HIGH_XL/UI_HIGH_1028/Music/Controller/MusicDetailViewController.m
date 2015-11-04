//
//  MusicDetailViewController.m
//  Music
//
//  Created by zhupeng on 15/10/29.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "MusicDetailTopView.h"
#import "NetHandler.h"
#import "TracksList.h"
#import "MusicAlbumListCell.h"
#import "UIColor+AddColor.h"
#import "Header2View.h"
#import "TitleScrollView.h"
#import "IntroductionViewController.h"
#import "TagsCollectionViewCell.h"
#import "SoundAlbumViewController.h"
#import "MusicViewController.h"

@interface MusicDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) TitleScrollView *titleScrollView;

@property (nonatomic, strong) MusicDetailTopView *musicTopView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AlbumDetail *albumDetail;
@property (nonatomic, strong) NSMutableArray *tracksListArray;
@property (nonatomic, strong) NSArray *tagsArr;

@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, assign) BOOL isSorted;

@end

@implementation MusicDetailViewController

#pragma mark-- collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagsArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell1" forIndexPath:indexPath];
    if (self.tagsArr.count != 0) {
        cell.titleLabel.text = self.tagsArr[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SoundAlbumViewController *soundAlbumVC = [[SoundAlbumViewController alloc]init];
    soundAlbumVC.albumSting = self.tagsArr[indexPath.item];
    [self.navigationController pushViewController:soundAlbumVC animated:YES];
    
    NSLog(@"%@", indexPath);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.musicTopView = [[MusicDetailTopView alloc]initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 3))];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.musicTopView.desLabel addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.musicTopView.nextImageView addGestureRecognizer:tap1];
    self.musicTopView.collectionView.delegate = self;
    self.musicTopView.collectionView.dataSource = self;
    [self.view addSubview:self.musicTopView];
    
    self.tableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, self.musicTopView.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.musicTopView.bounds.size.height)) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shareButton.frame = CGRectMake(self.topView.bounds.size.width - 45, 30, 30, 30);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"fenxiang_nomal"] forState:(UIControlStateNormal)];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"fenxiang_height"] forState:(UIControlStateHighlighted)];
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.topView addSubview:shareButton];
    
    self.topView.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.topView];
    [self.view bringSubviewToFront:self.button];

    [self handle];
    
    self.albumDetail = [[AlbumDetail alloc]init];
    
    self.titleScrollView = [[TitleScrollView alloc]initWithFrame:(CGRectMake(self.view.bounds.size.width / 4, 30, self.view.bounds.size.width / 2, 30))];
    self.titleScrollView.contentOffset = CGPointZero;
    self.titleScrollView.contentSize = CGSizeMake(200, 30);
    self.titleScrollView.layer.cornerRadius = 8;
    [self.view addSubview:self.titleScrollView];
    
    self.isSorted = NO;
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action:) name:@"播放图片刷新通知" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)action:(id)object {
    
    [self.tableView reloadData];
    
}

- (void)shareAction:(UIButton *)button {
    NSLog(@"分享%d", __LINE__);
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    IntroductionViewController *introductionVC = [[IntroductionViewController alloc]init];
    introductionVC.albumDetail = self.albumDetail;
    [self.navigationController pushViewController:introductionVC animated:YES];
    
}

- (void)handle {
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/1/20?device=iPhone&position=1&title=精选歌单", self.albumId] completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *albumDic = [rootDic objectForKey:@"album"];
            [self.albumDetail setValuesForKeysWithDictionary:albumDic];
            
            self.titleScrollView.titleStr = self.albumDetail.title;
            
            self.musicTopView.albumDetail = self.albumDetail;
            
            self.tracksListArray = [NSMutableArray array];
            NSDictionary *tracksDic = [rootDic objectForKey:@"tracks"];
            NSArray *array = [tracksDic objectForKey:@"list"];
            for (NSDictionary *dic in array) {
                TracksList *tracksList = [[TracksList alloc]init];
                [tracksList setValuesForKeysWithDictionary:dic];
                [self.tracksListArray addObject:tracksList];
            }
            
            self.tagsArr = [self.albumDetail.tags componentsSeparatedByString:@","];
            
            [self.tableView reloadData];
        }
        
    }];
}

#pragma mark-- tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tracksListArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicViewController *musicVC = [[MusicViewController alloc]init];
    musicVC.tracksArray = self.tracksListArray;
    musicVC.currentIndex = indexPath.row;
    [self.navigationController presentViewController:musicVC animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *titleName = [NSString stringWithFormat:@"共%ld集", self.albumDetail.tracks];
    return titleName;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Header2View *headerV = [[Header2View alloc]initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, 30))];
    NSString *titleName = [NSString stringWithFormat:@"共%ld集", self.albumDetail.tracks];
    headerV.titleLabel.text = titleName;
    [headerV.sortButton addTarget:self action:@selector(sortAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return headerV;
}
//排序
- (void)sortAction:(UIButton *)button {
    if (self.isSorted == NO) {
        NSArray *array = [self.tracksListArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [((TracksList *)obj1).title compare:((TracksList *)obj2).title];
        }];
        self.tempArray = [self.tracksListArray mutableCopy];
        [self.tracksListArray removeAllObjects];
        self.tracksListArray = [NSMutableArray arrayWithArray:array];
        [self.tableView reloadData];
        self.isSorted = YES;
    }else {
        self.tracksListArray = nil;
        self.tracksListArray = [self.tempArray mutableCopy];
        self.tempArray = nil;
        [self.tableView reloadData];
        self.isSorted = NO;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell20";
    
    MusicAlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[MusicAlbumListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    }
    
    // Configure the cell...
    if (self.tracksListArray.count != 0) {
        cell.tracksList = self.tracksListArray[indexPath.row];
    }
    cell.backgroundColor = [UIColor silverColor];
    cell.alpha = 0.8;

    return cell;
}

- (void)dealloc {
    [self.titleScrollView.timer invalidate];
    self.titleScrollView.timer = nil;
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
