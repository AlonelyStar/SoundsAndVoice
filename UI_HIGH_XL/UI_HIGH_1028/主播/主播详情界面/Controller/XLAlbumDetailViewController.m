//
//  XLAlbumDetailViewController.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAlbumDetailViewController.h"
#import "XLAlbumDetailTopCell.h"
#import "XLAlbumDetailTopView.h"
#import "XLAlbumListCell.h"
#import "NetHandler.h"
#import "XLPublishVoice.h"
#import "XLAlbumTop.h"
#import "UIColor+AddColor.h"
#import "XLAlbumTypeView.h"
#import "XLAnchorDetailListViewController.h"

#import "MusicViewController.h"
#import "TracksList.h"
#import "PicsLikeControl.h"
#import "MusicTool.h"
#import "UIImage+CZ.h"
@interface XLAlbumDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *publishArr;
@property (nonatomic,strong) NSMutableArray *topArr;
@property (nonatomic,strong) XLAlbumTop *albumTop;
@property (nonatomic,strong) XLAlbumDetailTopView *albumDTView;
@property (nonatomic,strong) NSArray *tagsArr;
@property (nonatomic,assign) NSInteger lastContentOffset;
@property (nonatomic,strong) XLAlbumTypeView *albumTypeView;

@property (nonatomic,strong) NSMutableArray *tracksArr;
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation XLAlbumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, -180, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 180)) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.albumDTView = [XLAlbumDetailTopView albumDetailTopView];
    self.albumDTView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 170);
    [self.view addSubview:self.albumDTView];
    
    
    self.albumTypeView = [[XLAlbumTypeView alloc] initWithFrame:(CGRectMake(0, 180, [UIScreen mainScreen].bounds.size.width, 40))];
    [self.view addSubview:self.albumTypeView];
    
    [self.view bringSubviewToFront:self.button];
    [self netHandleTop];
    [self netHandle];
    
    UITapGestureRecognizer *tapIconImgV = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconImgV:)];
    [self.albumDTView.iconImageView addGestureRecognizer:tapIconImgV];
    
    UITapGestureRecognizer *tapLeftImgV = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftImgV:)];
    [self.albumDTView.albumImageLabel addGestureRecognizer:tapLeftImgV];
    
    [self.albumDTView.introduceButton addTarget:self action:@selector(introduceButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view bringSubviewToFront:(UIView *)self.picControl];
    
    
}




#pragma mark - 点击相关介绍(收藏)
- (void)introduceButtonClick:(UIButton *)button {
//    XLAlbumIntroduceViewController *introduceVC = [[XLAlbumIntroduceViewController alloc] init];
//    introduceVC.albumIntroduce = self.albumTop;
//    [self.navigationController pushViewController:introduceVC animated:YES];
}


- (void)tapIconImgV:(UITapGestureRecognizer *)tap {
    XLAnchorDetailListViewController *anchorDetailListVC = [[XLAnchorDetailListViewController alloc] init];
    anchorDetailListVC.uid = self.uid;
    [self.navigationController pushViewController:anchorDetailListVC animated:YES];
}
#pragma mark - 点击头像播放
- (void)tapLeftImgV:(UITapGestureRecognizer *)tap {
    [self presentToMusicToolWidthIndex:0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self presentToMusicToolWidthIndex:indexPath.row];
}

- (void)presentToMusicToolWidthIndex:(NSInteger)index {
    self.currentIndex = index;
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    musicVC.tracksArray = self.tracksArr;
    musicVC.currentIndex = index;
    

    [self presentViewController:musicVC animated:YES completion:nil];

}

-( void )scrollViewDidScroll:( UIScrollView *)scrollView {
  __block NSInteger range = scrollView.contentOffset.y;
    if (range > 182) {
        range = 182;
    }
    if (scrollView.contentOffset.y < 0)
    {
        //向上
        
        [UIView animateWithDuration:0 animations:^{
                self.albumTypeView.transform = CGAffineTransformMakeTranslation(0, -range);
            self.albumDTView.richIntroLabel.numberOfLines = 0;
            NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
            CGRect rect = [self.albumDTView.richIntroLabel.text boundingRectWithSize:(CGSizeMake(self.albumDTView.richIntroLabel.bounds.size.width, 1000)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
            self.albumDTView.richIntroLabel.frame = CGRectMake(self.albumDTView.richIntroLabel.frame.origin.x, self.albumDTView.richIntroLabel.frame.origin.y, self.albumDTView.richIntroLabel.bounds.size.width, rect.size.height);
            self.albumDTView.jiantouImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            } completion:^(BOOL finished) {
                if (range ==0 ) {
                    self.albumDTView.richIntroLabel.numberOfLines = 1;
                    self.albumDTView.richIntroLabel.frame = CGRectMake(self.albumDTView.richIntroLabel.frame.origin.x, self.albumDTView.richIntroLabel.frame.origin.y, self.albumDTView.richIntroLabel.bounds.size.width, 30);
                    self.albumDTView.jiantouImageView.transform = CGAffineTransformRotate(self.albumDTView.jiantouImageView.transform, -M_PI_2);

                }
            }];

    } else if (scrollView. contentOffset.y > 0)
    {
        //向下
        [UIView animateWithDuration:0 animations:^{
            self.albumDTView.transform = CGAffineTransformMakeTranslation(0, -range);
            
            self.albumTypeView.transform = CGAffineTransformMakeTranslation(0, -range);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)netHandleTop {
    self.topArr = [NSMutableArray array];
    self.tagsArr = [NSMutableArray array];
    
    
     NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/1/20?albumId=%ld&pageSize=20&isAsc=true&device=android",self.albumId,self.albumId];

    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.albumTop = [[XLAlbumTop alloc] init];
        [self.albumTop setValuesForKeysWithDictionary:rootDic[@"album"]];
        self.albumDTView.albumTop = self.albumTop;
        
        self.tagsArr = [self.albumTop.tags componentsSeparatedByString:@","];
        
        self.albumTypeView.typeArr = [self.tagsArr mutableCopy];
        [self.tableView reloadData];
        
       
    }];
}

- (void)netHandle {

    self.publishArr = [NSMutableArray array];
    self.tracksArr = [NSMutableArray array];
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/track/%ld/1/30?device=android",self.uid];
    
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        for (NSDictionary *dic in rootDic[@"list"]) {
            XLPublishVoice *publish = [[XLPublishVoice alloc] init];
            [publish setValuesForKeysWithDictionary:dic];
            [self.publishArr addObject:publish];
        }
        NSDictionary *trackArr = rootDic[@"list"];
        for (NSDictionary *dic in trackArr) {
            TracksList *tracks = [[TracksList alloc] init];
            [tracks setValuesForKeysWithDictionary:dic];
            [self.tracksArr addObject:tracks];
        }
        [self.tableView reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 400;
    }
    if (indexPath.section == 1) {
        return 80;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.publishArr.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        XLAlbumDetailTopCell *albumTopCell = [tableView dequeueReusableCellWithIdentifier:@"topCell"];
        if (albumTopCell == nil) {
            albumTopCell = [[[NSBundle mainBundle] loadNibNamed:@"XLAlbumDetailTopCell" owner:nil options:nil] lastObject];
        }
         return albumTopCell;
    }
   
    
    if (indexPath.section == 1) {
        XLAlbumListCell *albumDTcell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
        if (albumDTcell == nil) {
            albumDTcell = [[[NSBundle mainBundle] loadNibNamed:@"XLAlbumListCell" owner:nil options:nil] lastObject];
        }
        albumDTcell.publish = self.publishArr[indexPath.row];
        return albumDTcell;
    }
    return 0;
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
