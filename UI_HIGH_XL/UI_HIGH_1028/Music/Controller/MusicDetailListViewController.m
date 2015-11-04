//
//  MusicDetailListViewController.m
//  Music
//
//  Created by zhupeng on 15/10/29.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MusicDetailListViewController.h"
#import "NetHandler.h"
#import "ProgramSelection.h"
#import "MusicListCell.h"
#import "UIColor+AddColor.h"
#import "MJRefresh.h"
#import "MusicDetailViewController.h"
#import "CategoryMusic.h"
#import "ProgramSelection.h"

@interface MusicDetailListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISegmentedControl *seg;
@property (nonatomic, strong) UITableView *hotTableView;
@property (nonatomic, strong) UITableView *recentTableView;
@property (nonatomic, strong) UITableView *mostPlayTableView;

@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *recentArray;
@property (nonatomic, strong) NSMutableArray *mostPlayArray;

@property (nonatomic, assign) BOOL isHot;
@property (nonatomic, assign) BOOL isRecent;
@property (nonatomic, assign) BOOL isMostPlay;

@end

@implementation MusicDetailListViewController
- (void)dealloc {
    i = 1;
    j = 1;
    k = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"最火", @"最近更新", @"经典"]];
    self.seg.frame = CGRectMake(10, 10, self.backgroundView.bounds.size.width - 20, 30);
    [self.seg addTarget:self action:@selector(segAction:) forControlEvents:(UIControlEventValueChanged)];
    self.seg.selectedSegmentIndex = 0;
    self.seg.tintColor = [UIColor jinjuse];
    [self.backgroundView addSubview:self.seg];
    
    self.hotTableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, 50, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height - 50)) style:(UITableViewStylePlain)];
    self.hotTableView.tag = 200;
    self.hotTableView.delegate = self;
    self.hotTableView.dataSource = self;
    [self.backgroundView addSubview:self.hotTableView];
    
    self.recentTableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, 50, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height - 50)) style:(UITableViewStylePlain)];
    self.recentTableView.tag = 201;
    self.recentTableView.delegate = self;
    self.recentTableView.dataSource = self;
    [self.backgroundView addSubview:self.recentTableView];
    
    self.mostPlayTableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, 50, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height - 50)) style:(UITableViewStylePlain)];
    self.mostPlayTableView.tag = 202;
    self.mostPlayTableView.delegate = self;
    self.mostPlayTableView.dataSource = self;
    [self.backgroundView addSubview:self.mostPlayTableView];
    
    [self.backgroundView bringSubviewToFront:self.hotTableView];
    self.isHot = YES;
    self.isRecent = NO;
    self.isMostPlay = NO;
    
    self.hotArray = [NSMutableArray array];
    self.recentArray = [NSMutableArray array];
    self.mostPlayArray = [NSMutableArray array];
    [self setupRefresh];

    // Do any additional setup after loading the view.
}

static int i = 1;
static int j = 1;
static int k = 1;
- (void)hotHandle {
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=iPhone&pageId=%d&pageSize=20&position=1&status=0&tagName=%@&title=精选歌单", i, self.tagName] completion:^(NSData *data) {
        if (data != nil) {            
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *array = [rootDic objectForKey:@"list"];
            [self addArray1:array ToArray2:self.hotArray];
            [self.hotTableView reloadData];
            [self.hotTableView headerEndRefreshing];
        }
    }];
}
- (void)recentHandle {
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=recent&categoryId=2&device=iPhone&pageId=%d&pageSize=20&position=1&status=0&tagName=%@&title=精选歌单", j, self.tagName] completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *array = [rootDic objectForKey:@"list"];
            [self addArray1:array ToArray2:self.recentArray];
            [self.recentTableView reloadData];
            [self.recentTableView headerEndRefreshing];
        }
    }];
}
- (void)mostPlayHandle {
    [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=mostplay&categoryId=2&device=iPhone&pageId=%d&pageSize=20&position=1&status=0&tagName=%@&title=精选歌单", k, self.tagName] completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *array = [rootDic objectForKey:@"list"];
            [self addArray1:array ToArray2:self.mostPlayArray];
            [self.mostPlayTableView reloadData];
            [self.mostPlayTableView headerEndRefreshing];
        }
    }];
}

- (void)addArray1:(NSArray *)array1 ToArray2:(NSMutableArray *)array2 {
    for (NSDictionary *dic in array1) {
        ProgramSelection *program  = [[ProgramSelection alloc]init];
        [program setValuesForKeysWithDictionary:dic];
        [array2 addObject:program];
    }
}

- (void)segAction:(UISegmentedControl *)seg {
    UIView *view = [self.backgroundView viewWithTag:seg.selectedSegmentIndex + 200];
    if (seg.selectedSegmentIndex == 0) {
        self.isHot = YES;
        self.isRecent = NO;
        self.isMostPlay = NO;
    }
    if (seg.selectedSegmentIndex == 1) {
        self.isHot = NO;
        self.isRecent = YES;
        self.isMostPlay = NO;
        if (self.recentArray.count == 0) {
            [self setupRefresh];
        }
    }
    if (seg.selectedSegmentIndex == 2 && self.mostPlayArray.count == 0) {
        self.isHot = NO;
        self.isRecent = NO;
        self.isMostPlay = YES;
        if (self.mostPlayArray.count == 0) {
            [self setupRefresh];
        }
    }
    
    [self.backgroundView bringSubviewToFront:view];
}

#pragma mark-- tableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell10";
    
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[MusicListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    }
    
    // Configure the cell...
    if (self.isHot && self.hotArray.count != 0) {
        cell.programSelection = self.hotArray[indexPath.row];
    }
    if (self.isRecent && self.recentArray.count != 0) {
        cell.programSelection = self.recentArray[indexPath.row];
    }
    if (self.isMostPlay && self.mostPlayArray.count != 0) {
        cell.programSelection = self.mostPlayArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicDetailViewController *musicDetailVC = [[MusicDetailViewController alloc]init];
    if (self.isHot) {
        musicDetailVC.albumId = ((ProgramSelection *)self.hotArray[indexPath.row]).albumId;
    }
    if (self.isRecent) {
        musicDetailVC.albumId = ((ProgramSelection *)self.recentArray[indexPath.row]).albumId;
    }
    if (self.isMostPlay) {
        musicDetailVC.albumId = ((ProgramSelection *)self.mostPlayArray[indexPath.row]).albumId;
    }
    [self.navigationController pushViewController:musicDetailVC animated:YES];
    
    NSLog(@"222");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.hotTableView) {
        return self.hotArray.count;
    }
    if (tableView == self.recentTableView) {
        return self.recentArray.count;
    }
    if (tableView == self.mostPlayTableView) {
        return self.mostPlayArray.count;
    }
    return 0;
}

- (void)setupRefresh
{
    //    NSLog(@"进入了setupRefresh");
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    
    if (self.isHot) {
        [self.hotTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.hotTableView headerBeginRefreshing];
        [self.hotTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    }
    if (self.isRecent) {
        [self.recentTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.recentTableView headerBeginRefreshing];
        [self.recentTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    }
    if (self.isMostPlay) {
        [self.mostPlayTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.mostPlayTableView headerBeginRefreshing];
        [self.mostPlayTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    }

}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    //1. 在这调用请求网络数据方法（刷新数据）
    if (self.isHot) {
        [self hotHandle];
    }
    if (self.isRecent) {
        [self recentHandle];
    }
    if (self.isMostPlay) {
        [self mostPlayHandle];
    }
    //2. 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.hotArray.count == 0) {
            UIAlertView *alertV  = [[UIAlertView alloc]initWithTitle:nil message:@"网络慢~" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [self performSelector:@selector(dismisAlertV:) withObject:alertV afterDelay:1];
            [alertV show];
        }
        // 刷新表格
        if (self.isHot) {
            [self.hotTableView reloadData];
            [self.hotTableView headerEndRefreshing];
        }
        if (self.isRecent) {
            [self.recentTableView reloadData];
            [self.recentTableView headerEndRefreshing];
        }
        if (self.isHot) {
            [self.mostPlayTableView reloadData];
            [self.mostPlayTableView headerEndRefreshing];
        }
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态

    });
}

- (void)dismisAlertV:(UIAlertView *)alertV {
    [alertV dismissWithClickedButtonIndex:0 animated:YES];
}

//   进入加载状态
- (void)footerRereshing
{
    //1. 拼接口等操作
    if (self.isHot) {
        i++;
        [self hotHandle];
    }
    if (self.isRecent) {
        j++;
        [self recentHandle];
    }
    if (self.isMostPlay) {
        k++;
        [self mostPlayHandle];
    }
    // 请求加载数据
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        if (self.isHot) {
            [self.hotTableView reloadData];
            [self.hotTableView footerEndRefreshing];
        }
        if (self.isRecent) {
            [self.recentTableView reloadData];
            [self.recentTableView footerEndRefreshing];
        }
        if (self.isMostPlay) {
            [self.mostPlayTableView reloadData];
            [self.mostPlayTableView footerEndRefreshing];
        }
        
        
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
